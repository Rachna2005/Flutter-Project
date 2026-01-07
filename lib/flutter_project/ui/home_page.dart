// lib/flutter_project/ui/home_page.dart
import 'package:flutter/material.dart';
import 'home/category_grid.dart';
import 'home/new_lesson_section.dart';
import 'home/reflection_insight_card.dart';
import 'home/total_lesson_bar.dart';
import '../model/life_lesson_control.dart';
import '../model/life_lesson.dart';
import 'lesson/category_page.dart';

class HomePage extends StatefulWidget {
  final LifeLessonControl controller;

  const HomePage({super.key, required this.controller});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
              future: widget.controller.mostFrequentCategory(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const ReflectionInsightCard(category: null);
                }

                return ReflectionInsightCard(category: snapshot.data);
              },
            ),

            const SizedBox(height: 12),
            FutureBuilder<int>(
              future: widget.controller.totalLessons(),
              builder: (context, snapshot) {
                return TotalLessonBar(total: snapshot.data ?? 0);
              },
            ),

            const SizedBox(height: 16),

            // CategoryGrid(controller: controller),
            SizedBox(
              child: CategoryGrid(
                onTap: (category) {
                  // Navigate to a page showing lessons filtered by this category
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CategoryLessonsPage(
                        controller: widget.controller,
                        category: category,
                      ),
                    ),
                  );
                  setState(() {});
                },
                thin: true,
                title: "Categories",
              ),
            ),

            const SizedBox(height: 16),
            NewLessonSection(controller: widget.controller),
          ],
        ),
      ),
    );
  }
}
