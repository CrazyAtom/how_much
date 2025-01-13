import 'package:how_much/analysis/provider/analysis_history_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/analysis_model.dart';
import '../repository/analysis_repository.dart';

part 'analysis_provider.g.dart';

@Riverpod(keepAlive: true)
class Analysis extends _$Analysis {
  static const int maxImages = 5;

  @override
  FutureOr<AnalysisModel> build() {
    return AnalysisModel(
      productName: '',
      description: '',
      condition: '새제품',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      localImagePaths: [],
    );
  }

  AnalysisModel? getCurrentAnalysis() {
    if (state case AsyncData(value: final analysis)) {
      return analysis;
    }
    return null;
  }

  void updateProductName(String name) {
    if (state case AsyncData(value: final analysis)) {
      state = AsyncValue.data(analysis.copyWith(productName: name));
    }
  }

  void updateDescription(String description) {
    if (state case AsyncData(value: final analysis)) {
      state = AsyncValue.data(analysis.copyWith(description: description));
    }
  }

  void updateCondition(String condition) {
    if (state case AsyncData(value: final analysis)) {
      state = AsyncValue.data(analysis.copyWith(condition: condition));
    }
  }

  Future<void> pickImages() async {
    if (state case AsyncData(value: final analysis)) {
      try {
        final imagePicker = ImagePicker();
        final remainingSlots = maxImages - analysis.localImagePaths.length;

        if (remainingSlots <= 0) return;

        final images = await imagePicker.pickMultiImage();
        if (images.isNotEmpty) {
          final newImages =
              images.take(remainingSlots).map((image) => image.path).toList();
          state = AsyncValue.data(analysis.copyWith(
            localImagePaths: [...analysis.localImagePaths, ...newImages],
          ));
        }
      } catch (e, st) {
        state = AsyncValue.error(e, st);
      }
    }
  }

  void removeImage(int index) {
    if (state case AsyncData(value: final analysis)) {
      final newPaths = List<String>.from(analysis.localImagePaths)
        ..removeAt(index);
      state = AsyncValue.data(analysis.copyWith(localImagePaths: newPaths));
    }
  }

  Future<bool> analyzeProduct() async {
    if (state case AsyncData(value: final analysis)) {
      if (analysis.localImagePaths.isEmpty) {
        state = AsyncValue.error(
          Exception('이미지를 한 장 이상 추가해주세요.'),
          StackTrace.current,
        );
        return false;
      }

      if (analysis.productName.isEmpty) {
        state = AsyncValue.error(
          Exception('제품명을 입력해주세요.'),
          StackTrace.current,
        );
        return false;
      }

      state = const AsyncValue.loading();

      try {
        final analysisResult =
            await ref.read(analysisRepositoryProvider.notifier).analyzeProduct(
                  images: analysis.localImagePaths,
                  productName: analysis.productName,
                  description: analysis.description,
                  condition: analysis.condition,
                );

        final updatedAnalysis = analysis.copyWith(
          analysisResult: analysisResult,
        );

        state = AsyncValue.data(updatedAnalysis);

        await ref
            .watch(analysisHistoryProvider.notifier)
            .addAnalysis(updatedAnalysis);

        return true;
      } catch (e, st) {
        state = AsyncValue.error(e, st);
        return false;
      }
    }
    return false;
  }
}
