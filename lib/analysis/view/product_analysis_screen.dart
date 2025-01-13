import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:how_much/common/component/image_picker_section.dart';
import 'package:how_much/analysis/model/analysis_model.dart';
import 'package:how_much/analysis/provider/analysis_provider.dart';
import 'package:how_much/common/component/custom_text_form_field.dart';
import 'package:how_much/common/const/data.dart';
import 'package:how_much/common/layout/default_layout.dart';
import 'package:image_picker/image_picker.dart';

class ProductAnalysisScreen extends ConsumerStatefulWidget {
  static String get routeName => 'product_analysis';

  const ProductAnalysisScreen({super.key});

  @override
  ConsumerState<ProductAnalysisScreen> createState() =>
      _ProductAnalysisScreenState();
}

class _ProductAnalysisScreenState extends ConsumerState<ProductAnalysisScreen> {
  final _formKey = GlobalKey<FormState>();
  final _productNameController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _productNameController.addListener(() {
      ref
          .read(analysisProvider.notifier)
          .updateProductName(_productNameController.text);
    });
    _descriptionController.addListener(() {
      ref
          .read(analysisProvider.notifier)
          .updateDescription(_descriptionController.text);
    });
  }

  @override
  void dispose() {
    _productNameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      // title: '얼마야',
      child: ref.watch(analysisProvider).when(
            data: (analysis) => SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 24),
                      ImagePickerSection(
                        selectedImages: analysis.localImagePaths
                            .map((path) => XFile(path))
                            .toList(),
                        maxImages: Analysis.maxImages,
                        onPickImages: () {
                          ref.read(analysisProvider.notifier).pickImages();
                        },
                        onRemoveImage: (index) {
                          ref
                              .read(analysisProvider.notifier)
                              .removeImage(index);
                        },
                      ),
                      const SizedBox(height: 32),
                      _buildProductNameField(),
                      const SizedBox(height: 24),
                      _buildConditionField(analysis),
                      const SizedBox(height: 24),
                      _buildDescriptionField(),
                      const SizedBox(height: 32),
                      _buildSubmitButton(),
                    ],
                  ),
                ),
              ),
            ),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            error: (error, stack) => Center(
              child: Text('Error: $error'),
            ),
          ),
    );
  }

  Widget _buildProductNameField() {
    return CustomTextFormField(
      label: '제품명',
      controller: _productNameController,
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return '제품명을 입력해주세요';
        }
        return null;
      },
    );
  }

  Widget _buildConditionField(AnalysisModel? analysis) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: '상태',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.grey[300]!,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.grey[300]!,
            width: 1,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
      value: analysis?.condition ?? '새제품',
      items: Condition.values
          .map((condition) => DropdownMenuItem<String>(
                value: condition.label,
                child: Text(condition.label),
              ))
          .toList(),
      onChanged: (value) {
        if (value != null) {
          ref.read(analysisProvider.notifier).updateCondition(value);
        }
      },
      isExpanded: true,
      menuMaxHeight: 200,
      alignment: AlignmentDirectional.bottomStart,
    );
  }

  Widget _buildDescriptionField() {
    return CustomTextFormField(
      label: '자세한 설명',
      hint: '상품에 대해 자세히 작성해주세요.',
      controller: _descriptionController,
      maxLines: 6,
      maxLength: 1000,
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: () async {
        if (_formKey.currentState?.validate() ?? false) {
          final result =
              await ref.read(analysisProvider.notifier).analyzeProduct();

          if (result && mounted) {
            ref.watch(analysisProvider).whenData((analysis) {
              if (analysis.analysisResult != null) {
                context.go(
                  '/home/analysis_result',
                );
              }
            });
          }
        }
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      child: const Text(
        '작성 완료',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }
}
