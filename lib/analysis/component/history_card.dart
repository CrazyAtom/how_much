import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:how_much/analysis/model/analysis_model.dart';
import 'package:how_much/common/component/card/custom_card.dart';

class HistoryCard extends StatelessWidget {
  final Image image;
  final String productName;
  final String description;
  final DateTime createdAt;
  final String condition;
  final bool isResult;

  const HistoryCard({
    super.key,
    required this.image,
    required this.productName,
    required this.description,
    required this.createdAt,
    required this.isResult,
    required this.condition,
  });

  factory HistoryCard.fromModel({
    required AnalysisModel model,
  }) {
    return HistoryCard(
      image: Image.asset(
        model.localImagePaths.first,
        width: 60,
        height: 60,
        fit: BoxFit.cover,
      ),
      productName: model.productName,
      description: model.description,
      createdAt: model.createdAt,
      condition: model.condition,
      isResult: model.analysisResult != null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () {
          if (isResult) {
            context.go(
              '/home/analysis_result',
            );
          }
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: image,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          productName,
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          description,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Colors.grey[600],
                                  ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    condition,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                  Text(
                    createdAt.toString().substring(0, 10),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
