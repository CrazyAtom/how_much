import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:how_much/analysis/model/analysis_result_model.dart';
import 'package:how_much/analysis/provider/analysis_provider.dart';
import 'package:how_much/common/component/card/expandable_card_section.dart';
import 'package:how_much/common/layout/default_layout.dart';
import 'package:share_plus/share_plus.dart';

class ProductStrategyScreen extends ConsumerWidget {
  static String get routeName => 'sales_strategy';

  const ProductStrategyScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.read(analysisProvider.notifier).getCurrentAnalysis();
    final analysis = model?.analysisResult;
    if (analysis == null) {
      return const Center(child: Text('분석 결과가 없습니다.'));
    }

    return DefaultLayout(
      title: '판매 전략',
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        children: [
          _buildSalesPostSection(context, analysis.salesStrategy.salesPost),
          const SizedBox(height: 24),
          _buildSellingPointsSection(analysis.salesStrategy.sellingPoints),
          const SizedBox(height: 24),
          _buildFaqSection(analysis.salesStrategy.faq),
        ],
      ),
    );
  }

  Widget _buildSalesPostSection(BuildContext context, SalesPostModel post) {
    final hashtags = (post.hashtags as List).join(' ');

    return ExpandableCardSection(
      title: '판매글',
      children: [
        ListTile(
          title: Text(
            post.title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.copy),
                onPressed: () {
                  Clipboard.setData(ClipboardData(
                    text: '''${post.title}

${post.mainText}

💰 판매가: ${post.priceSuggestion}

✨ 상품 특징
${(post.keyFeatures as List).map((e) => '• $e').join('\n')}

$hashtags''',
                  ));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('판매글이 복사되었습니다')),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.share),
                onPressed: () {
                  Share.share('''${post.title}

${post.mainText}

💰 판매가: ${post.priceSuggestion}

✨ 상품 특징
${(post.keyFeatures as List).map((e) => '• $e').join('\n')}

$hashtags''');
                },
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(post.mainText),
              const SizedBox(height: 16),
              Text(
                '💰 판매가: ${post.priceSuggestion}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                '✨ 상품 특징',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              ...post.keyFeatures.map<Widget>((feature) => Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('• '),
                        Expanded(child: Text(feature)),
                      ],
                    ),
                  )),
              const SizedBox(height: 16),
              Text(
                hashtags,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSellingPointsSection(SellingPointsModel points) {
    return ExpandableCardSection(
      title: '판매 포인트',
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                points.point,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(points.description),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFaqSection(FaqModel faq) {
    return ExpandableCardSection(
      title: '예상 문의/답변',
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Q. ${faq.question}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text('A. ${faq.answer}'),
            ],
          ),
        ),
      ],
    );
  }
}
