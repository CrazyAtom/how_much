// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:how_much/analysis/provider/gemini_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/analysis_model.dart';
import '../model/analysis_result_model.dart';

part 'analysis_repository.g.dart';

@riverpod
class AnalysisRepository extends _$AnalysisRepository {
  @override
  FutureOr<void> build() async {}

  Future<List<AnalysisModel>> getAnalyses() async {
    // try {
    //   final firestore = FirebaseFirestore.instance;
    //   final userId = FirebaseAuth.instance.currentUser?.uid;

    //   if (userId == null) {
    //     throw Exception('사용자 인증이 필요합니다');
    //   }

    //   final snapshot = await firestore
    //       .collection('analyses')
    //       .where('userId', isEqualTo: userId)
    //       .orderBy('createdAt', descending: true)
    //       .get();

    //   return snapshot.docs
    //       .map((doc) => AnalysisModel.fromJson({
    //             'id': doc.id,
    //             ...doc.data(),
    //           }))
    //       .toList();
    // } catch (e) {
    //   throw Exception('분석 기록을 가져오는데 실패했습니다: $e');
    // }
    return [];
  }

  Future<void> createAnalysis(AnalysisModel analysis) async {
    // try {
    //   final firestore = FirebaseFirestore.instance;
    //   final userId = FirebaseAuth.instance.currentUser?.uid;

    //   if (userId == null) {
    //     throw Exception('사용자 인증이 필요합니다');
    //   }

    //   await firestore.collection('analyses').add({
    //     'userId': userId,
    //     ...analysis.toJson(),
    //   });
    // } catch (e) {
    //   throw Exception('분석 결과 저장에 실패했습니다: $e');
    // }
  }

  Future<AnalysisResultModel> analyzeProduct({
    required List<String> images,
    required String productName,
    required String description,
    required String condition,
  }) async {
    try {
      final geminiService = ref.read(geminiProvider);
      final xFiles = images.map((path) => XFile(path)).toList();

      final result = await geminiService.analyzeProduct(
        productName: productName,
        condition: condition,
        description: description,
        images: xFiles,
      );

      if (result == null) {
        throw Exception('분석 결과가 없습니다');
      }

      return result;
    } catch (e) {
      throw Exception('상품 분석에 실패했습니다: $e');
    }
  }
}
