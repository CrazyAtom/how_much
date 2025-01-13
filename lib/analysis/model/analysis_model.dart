import 'package:freezed_annotation/freezed_annotation.dart';

import 'analysis_result_model.dart';

part 'analysis_model.freezed.dart';
part 'analysis_model.g.dart';

@freezed
class AnalysisModel with _$AnalysisModel {
  const factory AnalysisModel({
    // required String id,
    required String productName,
    required String description,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
    @Default(false) @JsonKey(name: 'is_deleted') bool isDeleted,
    @Default([]) List<String> localImagePaths,
    @Default('새제품') String condition,
    AnalysisResultModel? analysisResult,
  }) = _AnalysisModel;

  factory AnalysisModel.fromJson(Map<String, dynamic> json) =>
      _$AnalysisModelFromJson(json);
}
