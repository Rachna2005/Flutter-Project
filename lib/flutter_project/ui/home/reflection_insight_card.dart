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
                gradient: const LinearGradient(
                  colors: [Color(0xFFB6B9FF), Color(0xFF7F84FF)],
                ),
              ),
              child:  Center(
                child: Text(
                  label,
                  style: TextStyle(
                    color: Colors.white,
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
