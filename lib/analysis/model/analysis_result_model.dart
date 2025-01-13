import 'package:freezed_annotation/freezed_annotation.dart';

part 'analysis_result_model.freezed.dart';
part 'analysis_result_model.g.dart';

@freezed
class GeminiResponseModel with _$GeminiResponseModel {
  const factory GeminiResponseModel({
    @JsonKey(name: 'product_analysis')
    required AnalysisResultModel productAnalysis,
  }) = _GeminiResponseModel;

  factory GeminiResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GeminiResponseModelFromJson(json);
}

@freezed
class AnalysisResultModel with _$AnalysisResultModel {
  const factory AnalysisResultModel({
    @JsonKey(name: 'basic_info') required BasicInfoModel basicInfo,
    @JsonKey(name: 'price_analysis') required PriceAnalysisModel priceAnalysis,
    @JsonKey(name: 'trade_trends') required TradeTrendsModel tradeTrends,
    @JsonKey(name: 'market_outlook') required MarketOutlookModel marketOutlook,
    @JsonKey(name: 'reliability_metrics')
    required ReliabilityMetricsModel reliabilityMetrics,
    @JsonKey(name: 'sales_strategy') required SalesStrategyModel salesStrategy,
  }) = _AnalysisResultModel;

  factory AnalysisResultModel.fromJson(Map<String, dynamic> json) =>
      _$AnalysisResultModelFromJson(json);
}

@freezed
class BasicInfoModel with _$BasicInfoModel {
  const factory BasicInfoModel({
    @JsonKey(name: 'product_name') required String productName,
    @JsonKey(name: 'category') required String category,
    @JsonKey(name: 'brand') required String brand,
    @JsonKey(name: 'model') required String model,
    @JsonKey(name: 'release_date') required String releaseDate,
    @JsonKey(name: 'original_price') required int originalPrice,
  }) = _BasicInfoModel;

  factory BasicInfoModel.fromJson(Map<String, dynamic> json) =>
      _$BasicInfoModelFromJson(json);
}

@freezed
class PriceAnalysisModel with _$PriceAnalysisModel {
  const factory PriceAnalysisModel({
    @JsonKey(name: 'current_market') required CurrentMarketModel currentMarket,
    @JsonKey(name: 'condition_based_prices')
    required Map<String, int> conditionBasedPrices,
    @JsonKey(name: 'regional_prices')
    required List<RegionalPriceModel> regionalPrices,
  }) = _PriceAnalysisModel;

  factory PriceAnalysisModel.fromJson(Map<String, dynamic> json) =>
      _$PriceAnalysisModelFromJson(json);
}

@freezed
class CurrentMarketModel with _$CurrentMarketModel {
  const factory CurrentMarketModel({
    @JsonKey(name: 'average_price') required int averagePrice,
    @JsonKey(name: 'lowest_price') required int lowestPrice,
    @JsonKey(name: 'highest_price') required int highestPrice,
    @JsonKey(name: 'median_price') required int medianPrice,
  }) = _CurrentMarketModel;

  factory CurrentMarketModel.fromJson(Map<String, dynamic> json) =>
      _$CurrentMarketModelFromJson(json);
}

@freezed
class RegionalPriceModel with _$RegionalPriceModel {
  const factory RegionalPriceModel({
    @JsonKey(name: 'region') required String region,
    @JsonKey(name: 'average_price') required int averagePrice,
    @JsonKey(name: 'transaction_count') required int transactionCount,
  }) = _RegionalPriceModel;

  factory RegionalPriceModel.fromJson(Map<String, dynamic> json) =>
      _$RegionalPriceModelFromJson(json);
}

@freezed
class TradeTrendsModel with _$TradeTrendsModel {
  const factory TradeTrendsModel({
    @JsonKey(name: 'transaction_metrics')
    required TransactionMetricsModel transactionMetrics,
    @JsonKey(name: 'platform_analysis')
    required List<PlatformAnalysisModel> platformAnalysis,
    @JsonKey(name: 'optimal_selling_points')
    required OptimalSellingPointsModel optimalSellingPoints,
  }) = _TradeTrendsModel;

  factory TradeTrendsModel.fromJson(Map<String, dynamic> json) =>
      _$TradeTrendsModelFromJson(json);
}

@freezed
class TransactionMetricsModel with _$TransactionMetricsModel {
  const factory TransactionMetricsModel({
    @JsonKey(name: 'monthly_volume') required int monthlyVolume,
    @JsonKey(name: 'average_sale_duration') required int averageSaleDuration,
    @JsonKey(name: 'successful_trade_rate') required double successfulTradeRate,
  }) = _TransactionMetricsModel;

  factory TransactionMetricsModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionMetricsModelFromJson(json);
}

@freezed
class PlatformAnalysisModel with _$PlatformAnalysisModel {
  const factory PlatformAnalysisModel({
    @JsonKey(name: 'platform_name') required String platformName,
    @JsonKey(name: 'transaction_share') required double transactionShare,
    @JsonKey(name: 'average_price') required int averagePrice,
    @JsonKey(name: 'listing_count') required int listingCount,
  }) = _PlatformAnalysisModel;

  factory PlatformAnalysisModel.fromJson(Map<String, dynamic> json) =>
      _$PlatformAnalysisModelFromJson(json);
}

@freezed
class OptimalSellingPointsModel with _$OptimalSellingPointsModel {
  const factory OptimalSellingPointsModel({
    @JsonKey(name: 'best_price_range') required PriceRangeModel bestPriceRange,
    @JsonKey(name: 'best_selling_period')
    required BestSellingPeriodModel bestSellingPeriod,
  }) = _OptimalSellingPointsModel;

  factory OptimalSellingPointsModel.fromJson(Map<String, dynamic> json) =>
      _$OptimalSellingPointsModelFromJson(json);
}

@freezed
class PriceRangeModel with _$PriceRangeModel {
  const factory PriceRangeModel({
    @JsonKey(name: 'min') required int min,
    @JsonKey(name: 'max') required int max,
    @JsonKey(name: 'success_rate') required double successRate,
  }) = _PriceRangeModel;

  factory PriceRangeModel.fromJson(Map<String, dynamic> json) =>
      _$PriceRangeModelFromJson(json);
}

@freezed
class BestSellingPeriodModel with _$BestSellingPeriodModel {
  const factory BestSellingPeriodModel({
    @JsonKey(name: 'season') required String season,
    @JsonKey(name: 'day_of_week') required String dayOfWeek,
    @JsonKey(name: 'time_of_day') required String timeOfDay,
  }) = _BestSellingPeriodModel;

  factory BestSellingPeriodModel.fromJson(Map<String, dynamic> json) =>
      _$BestSellingPeriodModelFromJson(json);
}

@freezed
class MarketOutlookModel with _$MarketOutlookModel {
  const factory MarketOutlookModel({
    @JsonKey(name: 'price_trends') required PriceTrendsModel priceTrends,
    @JsonKey(name: 'market_factors') required MarketFactorsModel marketFactors,
  }) = _MarketOutlookModel;

  factory MarketOutlookModel.fromJson(Map<String, dynamic> json) =>
      _$MarketOutlookModelFromJson(json);
}

@freezed
class PriceTrendsModel with _$PriceTrendsModel {
  const factory PriceTrendsModel({
    @JsonKey(name: 'current_trend') required String currentTrend,
    @JsonKey(name: 'next_30_days') required String next30Days,
    @JsonKey(name: 'next_90_days') required String next90Days,
    @JsonKey(name: 'reason') required String reason,
  }) = _PriceTrendsModel;

  factory PriceTrendsModel.fromJson(Map<String, dynamic> json) =>
      _$PriceTrendsModelFromJson(json);
}

@freezed
class MarketFactorsModel with _$MarketFactorsModel {
  const factory MarketFactorsModel({
    @JsonKey(name: 'demand_level') required String demandLevel,
    @JsonKey(name: 'supply_level') required String supplyLevel,
    @JsonKey(name: 'seasonal_effect') required String seasonalEffect,
    @JsonKey(name: 'market_events')
    required List<MarketEventModel> marketEvents,
  }) = _MarketFactorsModel;

  factory MarketFactorsModel.fromJson(Map<String, dynamic> json) =>
      _$MarketFactorsModelFromJson(json);
}

@freezed
class MarketEventModel with _$MarketEventModel {
  const factory MarketEventModel({
    @JsonKey(name: 'event') required String event,
    @JsonKey(name: 'impact') required String impact,
  }) = _MarketEventModel;

  factory MarketEventModel.fromJson(Map<String, dynamic> json) =>
      _$MarketEventModelFromJson(json);
}

@freezed
class ReliabilityMetricsModel with _$ReliabilityMetricsModel {
  const factory ReliabilityMetricsModel({
    @JsonKey(name: 'product_reliability')
    required ProductReliabilityModel productReliability,
    @JsonKey(name: 'market_reliability')
    required MarketReliabilityModel marketReliability,
  }) = _ReliabilityMetricsModel;

  factory ReliabilityMetricsModel.fromJson(Map<String, dynamic> json) =>
      _$ReliabilityMetricsModelFromJson(json);
}

@freezed
class ProductReliabilityModel with _$ProductReliabilityModel {
  const factory ProductReliabilityModel({
    @JsonKey(name: 'defect_rate') required double defectRate,
    @JsonKey(name: 'common_issues')
    required List<CommonIssueModel> commonIssues,
    @JsonKey(name: 'average_lifespan') required int averageLifespan,
  }) = _ProductReliabilityModel;

  factory ProductReliabilityModel.fromJson(Map<String, dynamic> json) =>
      _$ProductReliabilityModelFromJson(json);
}

@freezed
class CommonIssueModel with _$CommonIssueModel {
  const factory CommonIssueModel({
    @JsonKey(name: 'issue') required String issue,
    @JsonKey(name: 'frequency') required double frequency,
  }) = _CommonIssueModel;

  factory CommonIssueModel.fromJson(Map<String, dynamic> json) =>
      _$CommonIssueModelFromJson(json);
}

@freezed
class MarketReliabilityModel with _$MarketReliabilityModel {
  const factory MarketReliabilityModel({
    @JsonKey(name: 'fraud_risk') required int fraudRisk,
    @JsonKey(name: 'fake_listing_rate') required double fakeListingRate,
    @JsonKey(name: 'verification_tips') required List<String> verificationTips,
  }) = _MarketReliabilityModel;

  factory MarketReliabilityModel.fromJson(Map<String, dynamic> json) =>
      _$MarketReliabilityModelFromJson(json);
}

@freezed
class SalesStrategyModel with _$SalesStrategyModel {
  const factory SalesStrategyModel({
    @JsonKey(name: 'sales_post') required SalesPostModel salesPost,
    @JsonKey(name: 'selling_points') required SellingPointsModel sellingPoints,
    @JsonKey(name: 'faq') required FaqModel faq,
  }) = _SalesStrategyModel;

  factory SalesStrategyModel.fromJson(Map<String, dynamic> json) =>
      _$SalesStrategyModelFromJson(json);
}

@freezed
class SalesPostModel with _$SalesPostModel {
  const factory SalesPostModel({
    @JsonKey(name: 'title') required String title,
    @JsonKey(name: 'main_text') required String mainText,
    @JsonKey(name: 'price_suggestion') required String priceSuggestion,
    @JsonKey(name: 'key_features') required List<String> keyFeatures,
    @JsonKey(name: 'hashtags') required List<String> hashtags,
  }) = _SalesPostModel;

  factory SalesPostModel.fromJson(Map<String, dynamic> json) =>
      _$SalesPostModelFromJson(json);
}

@freezed
class SellingPointsModel with _$SellingPointsModel {
  const factory SellingPointsModel({
    @JsonKey(name: 'point') required String point,
    @JsonKey(name: 'description') required String description,
  }) = _SellingPointsModel;

  factory SellingPointsModel.fromJson(Map<String, dynamic> json) =>
      _$SellingPointsModelFromJson(json);
}

@freezed
class FaqModel with _$FaqModel {
  const factory FaqModel({
    @JsonKey(name: 'question') required String question,
    @JsonKey(name: 'answer') required String answer,
  }) = _FaqModel;

  factory FaqModel.fromJson(Map<String, dynamic> json) =>
      _$FaqModelFromJson(json);
}
