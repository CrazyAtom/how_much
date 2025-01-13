import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerSection extends StatelessWidget {
  final List<XFile> selectedImages;
  final int maxImages;
  final VoidCallback onPickImages;
  final Function(int) onRemoveImage;

  const ImagePickerSection({
    required this.selectedImages,
    required this.maxImages,
    required this.onPickImages,
    required this.onRemoveImage,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildImageGrid(context),
        if (selectedImages.length < maxImages) ...[
          const SizedBox(height: 16),
          _buildAddButton(context),
        ],
      ],
    );
  }

  Widget _buildImageGrid(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 1,
      ),
      itemCount: selectedImages.length,
      itemBuilder: (context, index) => _buildImageTile(context, index),
    );
  }

  Widget _buildImageTile(BuildContext context, int index) {
    return Stack(
      children: [
        Hero(
          tag: 'image_$index',
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: FileImage(File(selectedImages[index].path)),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
          top: 4,
          right: 4,
          child: _buildRemoveButton(context, index),
        ),
      ],
    );
  }

  Widget _buildRemoveButton(BuildContext context, int index) {
    return Material(
      color: Colors.black.withOpacity(0.5),
      shape: const CircleBorder(),
      child: InkWell(
        onTap: () => onRemoveImage(index),
        customBorder: const CircleBorder(),
        child: const Padding(
          padding: EdgeInsets.all(4),
          child: Icon(
            Icons.close,
            size: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPickImages,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      icon: const Icon(Icons.add_photo_alternate_outlined),
      label: Text('사진 추가하기 (${selectedImages.length}/$maxImages)'),
    );
  }
}
