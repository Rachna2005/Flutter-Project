import 'package:flutter/material.dart';
import '../../model/life_lesson_control.dart';
import '../../model/life_lesson.dart';
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
  List<LifeLesson> _lessons = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadLessons(); 
  }

  @override
  void didUpdateWidget(covariant AllLessonsPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    _loadLessons();
  }

  Future<void> _loadLessons() async {
    final data = await widget.allLessons.getLessons();
    if (!mounted) return;
    setState(() {
      _lessons = data;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final displayedLessons = _lessons; 

    return Scaffold(
      appBar: AppBar(title: const Text('My Life Lessons')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : displayedLessons.isEmpty
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
                  onTap: () async {
                    final changed = await Navigator.push<bool>(
                      context,
                      MaterialPageRoute(
                        builder: (_) => LessonDetailPage(
                          lesson: lesson,
                          allLessons: widget.allLessons,
                        ),
                      ),
                    );

                    if (changed == true) {
                      await _loadLessons(); 
                    }
                  },
                  child: LessonCard(
                    key: ValueKey(lesson.id),
                    lesson: lesson,
                    color: categoryCardColor(lesson.category),

                    onFavorite: () async {
                      setState(() {
                        lesson.isFavorite = !(lesson.isFavorite ?? false);
                      });
                      await widget.allLessons.editLesson(lesson);
                    },

                    onDelete: () async {
                      setState(() {
                        _lessons.removeWhere((l) => l.id == lesson.id);
                      });
                      await widget.allLessons.deleteLesson(lesson.id);
                    },

                    onAction: (value) async {
                      if (lesson.actionPlan == null || value == null) return;
                      setState(() {
                        lesson.actionPlan!.isComplete = value;
                      });
                      await widget.allLessons.tapActionPlan(
                        lesson.actionPlan!,
                        value,
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
