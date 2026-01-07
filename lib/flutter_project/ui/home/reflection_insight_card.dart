// lib/flutter_project/ui/home/reflection_insight_card.dart
import 'package:flutter/material.dart';

import '../../model/life_lesson.dart';
import '../widget/lesson_helper.dart';

class ReflectionInsightCard extends StatelessWidget {
   final LessonCategory? category;
  const ReflectionInsightCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final label = category == null
        ? 'No data yet'
        : categoryLabel(category!);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Reflection insight',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('You most frequently write lesson about'),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: category != null ? categoryCardColor(category!) : Colors.grey,
              ),
              child:  Center(
                child: Text(
                  label,
                  style: TextStyle(
                    color: const Color.fromARGB(255, 29, 29, 28),
                    fontWeight: FontWeight.bold,
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
