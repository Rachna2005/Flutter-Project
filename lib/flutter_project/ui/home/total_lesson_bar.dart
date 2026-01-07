// lib/flutter_project/ui/home/total_lesson_bar.dart
import 'package:flutter/material.dart';

class TotalLessonBar extends StatelessWidget {
  final int total;
  const TotalLessonBar({super.key, required this.total});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF5A5AFF),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          'TOTAL LESSON     $total',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
