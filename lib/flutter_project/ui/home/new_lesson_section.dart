// lib/flutter_project/ui/home/new_lesson_section.dart
// import 'package:flutter/material.dart';
// import '../../model/life_lesson.dart';
// import '../widget/lesson_card.dart';
// import '../widget/lesson_helper.dart';

// class FavoriteSection extends StatelessWidget {
//   final List<LifeLesson> favorites;
//   const FavoriteSection({super.key, required this.favorites});

//   @override
//   Widget build(BuildContext context) {
//     if (favorites.isEmpty) {
//       return const Text('No favorite lessons yet');
//     }
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: favorites.map((lesson) {
//         return LessonCard(
//           lesson: lesson,
//           color: categoryCardColor(lesson.category),
//           onFavorite: () {},
//           onDelete: () {},
//         );
//       }).toList(),
//     );
//   }
// }
// lib/flutter_project/ui/home/new_lesson_section.dart
import 'package:flutter/material.dart';
import '../../model/life_lesson.dart';
import '../../model/life_lesson_control.dart';
import '../lesson/life_lesson_detail.dart';
import '../widget/lesson_card.dart';
import '../widget/lesson_helper.dart';

class NewLessonSection extends StatefulWidget {
  final LifeLessonControl controller;
  const NewLessonSection({super.key, required this.controller});

  @override
  State<NewLessonSection> createState() => _NewLessonSectionState();
}

class _NewLessonSectionState extends State<NewLessonSection> {
  List<LifeLesson> _lessons = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadLessons();
  }

  Future<void> _loadLessons() async {
    final recent = await widget.controller.recentLessons(limit: 5);
    if (!mounted) return;
    setState(() {
      _lessons = recent;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
          child: Text(
            'Recent Lessons',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 12),
        _loading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: _lessons.map((lesson) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: GestureDetector(
                      onTap: () async {
                        final result = await Navigator.push<bool>(
                          context,
                          MaterialPageRoute(
                            builder: (_) => LessonDetailPage(
                              lesson: lesson,
                              allLessons: widget.controller,
                            ),
                          ),
                        );
                        if (result == true) {
                          _loadLessons();
                        }
                      },
                      child: LessonCard(
                        lesson: lesson,
                        color: categoryCardColor(lesson.category),
                        onFavorite: () async {
                          await widget.controller.toggleFavorite(lesson);
                          setState(() {});
                        },
                        onDelete: () async {
                          await widget.controller.removeLesson(lesson);
                          setState(() {
                            _lessons.remove(lesson);
                          });
                        },
                        onAction: (value) async {
                          if (lesson.actionPlan == null || value == null) return;
                          setState(() {
                            lesson.actionPlan!.isComplete = value;
                          });
                          await widget.controller.tapActionPlan(
                            lesson.actionPlan!,
                            value,
                          );
                        },
                      ),
                    ),
                  );
                }).toList(),
              ),
      ],
    );
  }
}
