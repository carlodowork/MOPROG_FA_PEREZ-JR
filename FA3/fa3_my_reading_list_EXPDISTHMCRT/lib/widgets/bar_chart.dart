import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class SimpleBarChart extends StatelessWidget {
  final String title;
  final Map<String, int> data;
  final Color barColor;

  const SimpleBarChart({
    super.key,
    required this.title,
    required this.data,
    this.barColor = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    final maxValue =
        data.values.isEmpty ? 0 : data.values.reduce((a, b) => a > b ? a : b);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: AppSizes.padding),
            SizedBox(
              height: AppSizes.chartHeight + 40,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: data.entries.map((entry) {
                  final barHeight = maxValue == 0
                      ? 0.0
                      : (entry.value / maxValue) * AppSizes.chartHeight;
                  return Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('${entry.value}',
                            style: Theme.of(context).textTheme.bodySmall),
                        const SizedBox(height: 4),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: AppSizes.barWidth,
                          height: barHeight,
                          decoration: BoxDecoration(
                            color: barColor,
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          entry.key,
                          style: const TextStyle(fontSize: 10),
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}