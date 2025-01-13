import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:how_much/analysis/model/analysis_result_model.dart';
import 'package:how_much/common/config/config.dart';
import 'package:how_much/common/const/data.dart';
import 'package:image_picker/image_picker.dart';

final geminiModelProvider = Provider<GenerativeModel>((ref) {
  final schema = Schema.object(
    description: '중고 상품 분석 결과',
    properties: {
      'product_analysis': Schema.object(
        properties: {
          // 1. 기본 정보
          'basic_info': Schema.object(
            description: '기본 정보',
            properties: {
              'product_name':
                  Schema.string(description: '상품명', nullable: false),
              'category': Schema.string(description: '카테고리', nullable: false),
              'brand': Schema.string(description: '브랜드명', nullable: false),
              'model': Schema.string(description: '모델명', nullable: false),
              'release_date': Schema.string(description: '출시일'),
              'original_price': Schema.number(description: '출시 가격'),
            },
            requiredProperties: [
              'product_name',
              'category',
              'brand',
              'model',
              'release_date',
              'original_price',
            ],
          ),

          // 2. 가격 분석
          'price_analysis': Schema.object(
            description: '가격 분석',
            properties: {
              'current_market': Schema.object(
                properties: {
                  'average_price': Schema.number(description: '현재 평균 시세'),
                  'lowest_price': Schema.number(description: '현재 최저가'),
                  'highest_price': Schema.number(description: '현재 최고가'),
                  'median_price': Schema.number(description: '현재 중간가'),
                },
                requiredProperties: [
                  'average_price',
                  'lowest_price',
                  'highest_price',
                  'median_price',
                ],
              ),
              'condition_based_prices': Schema.object(
                properties: {
                  'like_new': Schema.number(description: '거의 새 제품 평균가'),
                  'good': Schema.number(description: '상태 좋음 평균가'),
                  'fair': Schema.number(description: '사용감 있음 평균가'),
                },
                requiredProperties: [
                  'like_new',
                  'good',
                  'fair',
                ],
              ),
              'regional_prices': Schema.array(
                description: '지역별 평균 가격',
                items: Schema.object(
                  properties: {
                    'region': Schema.string(description: '지역명'),
                    'average_price': Schema.number(description: '평균 가격'),
                    'transaction_count': Schema.number(description: '거래량'),
                  },
                  requiredProperties: [
                    'region',
                    'average_price',
                    'transaction_count',
                  ],
                ),
              ),
            },
            requiredProperties: [
              'current_market',
              'condition_based_prices',
              'regional_prices',
            ],
          ),

          // 3. 거래 동향
          'trade_trends': Schema.object(
            description: '거래 동향',
            properties: {
              'transaction_metrics': Schema.object(
                properties: {
                  'monthly_volume': Schema.number(description: '월간 거래량'),
                  'average_sale_duration':
                      Schema.number(description: '평균 판매 소요 시간(일)'),
                  'successful_trade_rate':
                      Schema.number(description: '거래 성사율(%)'),
                },
                requiredProperties: [
                  'monthly_volume',
                  'average_sale_duration',
                  'successful_trade_rate',
                ],
              ),
              'platform_analysis': Schema.array(
                items: Schema.object(
                  properties: {
                    'platform_name': Schema.string(description: '플랫폼명'),
                    'transaction_share': Schema.number(description: '거래 비중(%)'),
                    'average_price': Schema.number(description: '평균 가격'),
                    'listing_count': Schema.number(description: '등록 매물 수'),
                  },
                  requiredProperties: [
                    'platform_name',
                    'transaction_share',
                    'average_price',
                    'listing_count',
                  ],
                ),
              ),
              'optimal_selling_points': Schema.object(
                properties: {
                  'best_price_range': Schema.object(
                    properties: {
                      'min': Schema.number(description: '최적 최소가'),
                      'max': Schema.number(description: '최적 최대가'),
                      'success_rate':
                          Schema.number(description: '해당 가격대 거래 성사율(%)'),
                    },
                    requiredProperties: [
                      'min',
                      'max',
                      'success_rate',
                    ],
                  ),
                  'best_selling_period': Schema.object(
                    properties: {
                      'season': Schema.string(description: '최적 판매 계절'),
                      'day_of_week': Schema.string(description: '최적 판매 요일'),
                      'time_of_day': Schema.string(description: '최적 판매 시간대'),
                    },
                    requiredProperties: [
                      'season',
                      'day_of_week',
                      'time_of_day',
                    ],
                  ),
                },
                requiredProperties: ['best_price_range', 'best_selling_period'],
              ),
            },
            requiredProperties: [
              'transaction_metrics',
              'platform_analysis',
              'optimal_selling_points',
            ],
          ),

          // 4. 시장 전망
          'market_outlook': Schema.object(
            description: '시장 전망',
            properties: {
              'price_trends': Schema.object(
                properties: {
                  'current_trend':
                      Schema.string(description: '현재 가격 추세(상승/하락/유지)'),
                  'next_30_days': Schema.string(description: '30일 후 예상 추세'),
                  'next_90_days': Schema.string(description: '90일 후 예상 추세'),
                  'reason': Schema.string(description: '추세 변동 원인'),
                },
                requiredProperties: [
                  'current_trend',
                  'next_30_days',
                  'next_90_days',
                  'reason',
                ],
              ),
              'market_factors': Schema.object(
                properties: {
                  'demand_level': Schema.string(description: '수요 수준(높음/중간/낮음)'),
                  'supply_level': Schema.string(description: '공급 수준(높음/중간/낮음)'),
                  'seasonal_effect': Schema.string(description: '계절적 영향'),
                  'market_events': Schema.array(
                    description: '시장 영향 요인',
                    items: Schema.object(
                      properties: {
                        'event': Schema.string(description: '이벤트 내용'),
                        'impact': Schema.string(description: '영향도(긍정/부정)'),
                      },
                      requiredProperties: [
                        'event',
                        'impact',
                      ],
                    ),
                  ),
                },
                requiredProperties: [
                  'demand_level',
                  'supply_level',
                  'seasonal_effect',
                  'market_events',
                ],
              ),
            },
            requiredProperties: [
              'price_trends',
              'market_factors',
            ],
          ),

          // 5. 신뢰도 지표
          'reliability_metrics': Schema.object(
            description: '신뢰도 지표',
            properties: {
              'product_reliability': Schema.object(
                properties: {
                  'defect_rate': Schema.number(description: '하자 발생률(%)'),
                  'common_issues': Schema.array(
                    items: Schema.object(
                      properties: {
                        'issue': Schema.string(description: '문제 유형'),
                        'frequency': Schema.number(description: '발생 빈도(%)'),
                      },
                      requiredProperties: [
                        'issue',
                        'frequency',
                      ],
                    ),
                  ),
                  'average_lifespan': Schema.number(description: '평균 수명(개월)'),
                },
                requiredProperties: [
                  'defect_rate',
                  'common_issues',
                  'average_lifespan',
                ],
              ),
              'market_reliability': Schema.object(
                properties: {
                  'fraud_risk': Schema.number(description: '사기 거래 위험도(0-100)'),
                  'fake_listing_rate': Schema.number(description: '허위매물 비율(%)'),
                  'verification_tips': Schema.array(
                    items: Schema.string(description: '진품 확인 팁'),
                  ),
                },
                requiredProperties: [
                  'fraud_risk',
                  'fake_listing_rate',
                  'verification_tips',
                ],
              ),
            },
            requiredProperties: [
              'product_reliability',
              'market_reliability',
            ],
          ),

          // 6. 판매 전략 및 판매글
          'sales_strategy': Schema.object(
            description: '판매 전략 및 판매글',
            properties: {
              'sales_post': Schema.object(
                description: '판매글',
                properties: {
                  'title': Schema.string(description: '관심을 끄는 제목'),
                  'main_text': Schema.string(description: '판매 본문'),
                  'price_suggestion': Schema.string(description: '추천 판매가격'),
                  'key_features': Schema.array(
                    items: Schema.string(description: '핵심 장점'),
                  ),
                  'hashtags': Schema.array(
                    items: Schema.string(description: '해시태그'),
                  ),
                },
                requiredProperties: [
                  'title',
                  'main_text',
                  'price_suggestion',
                  'key_features',
                  'hashtags',
                ],
              ),
              'selling_points': Schema.object(
                properties: {
                  'point': Schema.string(description: '판매 포인트'),
                  'description': Schema.string(description: '상세 설명'),
                },
                requiredProperties: [
                  'point',
                  'description',
                ],
              ),
              'faq': Schema.object(
                description: '예상 문의답변',
                properties: {
                  'question': Schema.string(description: '예상 질문'),
                  'answer': Schema.string(description: '답변'),
                },
                requiredProperties: [
                  'question',
                  'answer',
                ],
              ),
            },
            requiredProperties: [
              'sales_post',
              'selling_points',
              'faq',
            ],
          ),
        },
        requiredProperties: [
          'basic_info',
          'price_analysis',
          'trade_trends',
          'market_outlook',
          'reliability_metrics',
          'sales_strategy',
        ],
      ),
    },
    requiredProperties: [
      'product_analysis',
    ],
  );

  return GenerativeModel(
    model: GeminiModel.geminiFlash.value,
    apiKey: Config.geminiApiKey,
    generationConfig: GenerationConfig(
      responseMimeType: 'application/json',
      responseSchema: schema,
    ),
  );
});

final geminiProvider = Provider<GeminiService>((ref) {
  final model = ref.watch(geminiModelProvider);
  return GeminiService(model: model);
});

class GeminiService {
  final GenerativeModel _model;

  GeminiService({
    required GenerativeModel model,
  }) : _model = model;

  Future<AnalysisResultModel?> analyzeProduct({
    required String productName,
    required String condition,
    required String description,
    required List<XFile> images,
  }) async {
    final prompt = '''
당신은 중고 상품 가격 분석 및 판매 전문가입니다.
아래 상품에 대한 상세 분석 및 판매 전략을 제공하고 판매글을 작성해주세요.

제품명: $productName
제품상태: $condition
상세설명: $description

상품 분석시 다음 규칙을 반드시 준수해주세요:
1. 응답은 정의된 JSON 스키마 형식을 정확히 따라야 합니다.
2. 모든 필수 필드를 누락없이 채워야 합니다.
3. 가격은 원화로 표시하며 천 단위 구분자는 제외합니다.
4. 수치 데이터는 최근 3개월 국내 기준으로 분석합니다.
5. 비율은 소수점 첫째 자리까지 표시합니다.
6. 지역별 가격은 주요 대도시 기준으로 제공합니다.
7. 가격 추세와 수요 추세는 '상승', '하락', '유지' 중 하나로 표시합니다.
8. 분석 결과는 실제 국내 중고 플랫폼 데이터를 기반으로 해야 합니다.

판매글 작성시 다음 규칙을 반드시 준수해주세요:
1. 판매글 작성
   - 호기심을 자극하는 매력적인 제목
   - 구매욕을 자극하는 재치있는 본문
   - 상품 가치를 부각시키는 핵심 장점 (3-5개)
   - 시장 분석을 기반으로 한 적정 판매가
   - 검색 노출을 위한 관련 해시태그 (5-8개)
   - 예상되는 구매자 문의와 답변 (3-5개)

2. 판매글 작성 규칙
   - 신뢰성: 실제 시장 데이터 기반의 가격 책정
   - 매력도: 구매자의 감성을 자극하는 문구 사용
   - 투명성: 제품 상태와 특징을 정직하게 설명
   - 간결성: 핵심 정보를 쉽고 명확하게 전달

응답은 정의된 JSON 스키마 형식을 정확히 따라야 합니다.
응답은 반드시 국문으로 작성 되어야 합니다.
''';

    try {
      final contents = [
        Content.multi([
          TextPart(prompt),
          if (images.isNotEmpty)
            for (final image in images)
              DataPart('image/jpeg', await File(image.path).readAsBytes()),
        ]),
      ];

      final generatedContent = await _model.generateContent(contents);
      if (generatedContent.text == null) {
        throw Exception('분석 결과 없음');
      }

      final response =
          jsonDecode(generatedContent.text!) as Map<String, dynamic>;
      final geminiResponse = GeminiResponseModel.fromJson(response);

      return geminiResponse.productAnalysis;
    } catch (e) {
      throw Exception('분석 실패: $e');
    }
  }
}
