import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerSection extends StatelessWidget {
  final List<XFile> selectedImages;
  final int maxImages;
  final Function() onPickImages;
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
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: selectedImages.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return _ImagePickerButton(
              selectedCount: selectedImages.length,
              maxImages: maxImages,
              onTap: onPickImages,
            );
          }
          return _SelectedImage(
            image: selectedImages[index - 1],
            onRemove: () => onRemoveImage(index - 1),
          );
        },
      ),
    );
  }
}

class _ImagePickerButton extends StatelessWidget {
  final int selectedCount;
  final int maxImages;
  final VoidCallback onTap;

  const _ImagePickerButton({
    required this.selectedCount,
    required this.maxImages,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 60,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.grey[300]!,
              width: 1,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.camera_alt_rounded,
                color: Colors.grey[600],
                size: 28,
              ),
              Text(
                '$selectedCount/$maxImages',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SelectedImage extends StatelessWidget {
  final XFile image;
  final VoidCallback onRemove;

  const _SelectedImage({
    required this.image,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            Image.file(
              File(image.path),
              width: 60,
              height: 60,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 60,
                  height: 60,
                  color: Colors.grey[300],
                  child: Icon(
                    Icons.error_outline,
                    color: Colors.grey[600],
                  ),
                );
              },
            ),
            Positioned(
              right: 4,
              top: 4,
              child: GestureDetector(
                onTap: onRemove,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
