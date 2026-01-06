import 'package:flutter/material.dart';
import 'home/reflection_insight_card.dart';
import 'home/total_lesson_bar.dart';
import 'home/category_grid.dart';
import '../model/life_lesson_control.dart';
import '../model/life_lesson.dart';

class HomePage extends StatelessWidget {
  final LifeLessonControl controller;

  const HomePage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    debugPrint('HomePage BUILD');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFC7DEFC),
        title: const Text(
          'Welcome to Merein jivit',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder<LessonCategory?>(
              future: controller.mostFrequentCategory(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const ReflectionInsightCard(category: null);
                }

                return ReflectionInsightCard(category: snapshot.data);
              },
            ),

            const SizedBox(height: 12),
            FutureBuilder<int>(
              future: controller.totalLessons(),
              builder: (context, snapshot) {
                return TotalLessonBar(total: snapshot.data ?? 0);
              },
            ),

            const SizedBox(height: 16),

            // CategoryGrid(controller: controller),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
