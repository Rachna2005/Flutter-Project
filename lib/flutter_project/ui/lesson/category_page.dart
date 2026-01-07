// lib/flutter_project/ui/lesson/category_page.dart
// import 'package:flutter/material.dart';
// import '../../model/life_lesson.dart';
// import '../../model/life_lesson_control.dart';
// import '../widget/lesson_card.dart';
// import '../widget/lesson_helper.dart';
// class CategoryPage extends StatelessWidget {
//   final LessonCategory category;
//   final LifeLessonControl controller;

//   const CategoryPage({
//     super.key,
//     required this.category,
//     required this.controller,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final lessons = controller.lessonsByCategory(category);

//     return Scaffold(
//       appBar: AppBar(title: Text(categoryLabel(category))),
//       body: ListView.builder(
//         padding: const EdgeInsets.all(16),
//         itemCount: lessons.length,
//         itemBuilder: (_, i) {
//           return LessonCard(
//             lesson: lessons[i],
//             color: categoryCardColor(category),
//             onFavorite: () {},
//             onDelete: () {},
//           );
//         },
//       ),
//     );
//   }
// }
// lib/flutter_project/ui/lesson/category_lessons_page.dart
import 'package:flutter/material.dart';
import '../../model/life_lesson.dart';
import '../../model/life_lesson_control.dart';
import '../widget/lesson_card.dart';
import '../widget/lesson_helper.dart';
import 'life_lesson_detail.dart';

class CategoryLessonsPage extends StatefulWidget {
  final LifeLessonControl controller;
  final LessonCategory category;

  const CategoryLessonsPage({
    super.key,
    required this.controller,
    required this.category,
  });

  @override
  State<CategoryLessonsPage> createState() => _CategoryLessonsPageState();
}

class _CategoryLessonsPageState extends State<CategoryLessonsPage> {
  List<LifeLesson> _lessons = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadLessons();
  }

  Future<void> _loadLessons() async {
    final lessons = await widget.controller.lessonsByCategory(widget.category);
    if (!mounted) return;
    setState(() {
      _lessons = lessons;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(categoryLabel(widget.category))),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _lessons.isEmpty
              ? const Center(child: Text('No lessons yet'))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _lessons.length,
                  itemBuilder: (context, index) {
                    final lesson = _lessons[index];

                    // Wrap each card in GestureDetector
                    return GestureDetector(
                      onTap: () {
                        // Navigate to lesson detail page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => LessonDetailPage(
                              lesson: lesson,
                              allLessons: widget.controller,
                            ),
                          ),
                        );
                      },
                      child: LessonCard(
                        lesson: lesson,
                        color: categoryCardColor(lesson.category),
                        onFavorite: () async {
                          setState(() {
                            lesson.isFavorite = !(lesson.isFavorite ?? false);
                          });
                          await widget.controller.editLesson(lesson);
                        },
                        onDelete: () async {
                          setState(() {
                            _lessons.removeAt(index);
                          });
                          await widget.controller.deleteLesson(lesson.id);
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
                    );
                  },
                ),
    );
  }
}
