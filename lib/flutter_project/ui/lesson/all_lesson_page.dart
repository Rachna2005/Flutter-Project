//ui/all_lesson_page.dart
import 'package:flutter/material.dart';
import '../../model/life_lesson_control.dart';
import '../widget/lesson_card.dart';
import 'life_lesson_detail.dart';
import '../widget/lesson_helper.dart';

class AllLessonsPage extends StatefulWidget {
  final LifeLessonControl allLessons;

  const AllLessonsPage({super.key, required this.allLessons});

  @override
  State<AllLessonsPage> createState() => _AllLessonsPageState();
}

class _AllLessonsPageState extends State<AllLessonsPage> {
  @override
  Widget build(BuildContext context) {
    final displayedLessons = widget.allLessons.lessons.reversed.toList();

    return Scaffold(
      appBar: AppBar(title: const Text('My Life Lessons')),
      body: displayedLessons.isEmpty
          ? const Center(
              child: Text(
                'No lessons yet.\nStart reflecting',
                textAlign: TextAlign.center,
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: displayedLessons.length,
              itemBuilder: (context, index) {
                final lesson = displayedLessons[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => LessonDetailPage(
                          lesson: lesson,
                          allLessons: widget.allLessons,
                          onAction: (value) {
                            if (value == null) return;

                            setState(() {
                              lesson.actionPlan!.isComplete = value;
                            });
                          },
                          onFavorite: () {
                            setState(() {
                              lesson.isFavorite = !(lesson.isFavorite ?? false);
                            });
                          },
                        ),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      LessonCard(
                        lesson: lesson,
                        onFavorite: () {
                          setState(() {
                            lesson.isFavorite = !(lesson.isFavorite ?? false);
                          });
                        },
                        onDelete: () {
                          setState(() {
                            widget.allLessons.lessons.remove(lesson);
                          });
                        },
                        color: categoryCardColor(lesson.category),
                        onAction: (value) {
                          setState(() {
                            lesson.actionPlan!.isComplete = value!;
                          });
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
