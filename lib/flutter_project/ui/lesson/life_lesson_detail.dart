//ui/life_lesson_detail.dart
import 'package:flutter/material.dart';
import '../../model/life_lesson.dart';
import 'create_lesson_page.dart';
import '../../model/life_lesson_control.dart';
import '../widget/lesson_helper.dart';

class LessonDetailPage extends StatefulWidget {
  final LifeLesson lesson;
  final LifeLessonControl allLessons;
  final ValueChanged<bool?> onAction;
  final VoidCallback onFavorite;

  const LessonDetailPage({
    super.key,
    required this.lesson,
    required this.onAction,
    required this.allLessons,
    required this.onFavorite,
  });

  @override
  State<LessonDetailPage> createState() => _LessonDetailPageState();
}

class _LessonDetailPageState extends State<LessonDetailPage> {
  @override
  Widget build(BuildContext context) {
    final categoryColors = categoryColor(widget.lesson.category);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Life lesson Detail'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CreateLifeLessonPage(
                    allLessons: widget.allLessons,
                    lesson: widget.lesson,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          color: categoryCardColor(widget.lesson.category),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '${widget.lesson.title} ${moodEmoji(widget.lesson.mood)}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          formatDate(widget.lesson.date),
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 6),
                        IconButton(
                          icon: Icon(
                            widget.lesson.isFavorite == true
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: widget.lesson.isFavorite == true
                                ? Colors.red
                                : Colors.grey,
                          ),
                          onPressed: () {
                            widget.onFavorite();
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      categoryIcon(widget.lesson.category),
                      size: 16,
                      color: categoryColors,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      categoryLabel(widget.lesson.category),
                      style: TextStyle(
                        color: categoryColors,
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),

                const Divider(height: 24),

                const Text(
                  'What happened?',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(widget.lesson.happened),

                const SizedBox(height: 16),

                const Text(
                  'What did you learn?',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(widget.lesson.learned),

                const SizedBox(height: 16),

                if (widget.lesson.actionPlan != null) ...[
                  const Text(
                    'What to do next time?',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Divider(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Checkbox(
                        value: widget.lesson.actionPlan!.isComplete,
                        // onChanged: (value) {
                        //   // setState(() {
                        //   //   lesson.actionPlan!.isComplete = value!;
                        //   // });
                        //   widget.onToggleAction(value);
                        // },
                        onChanged: widget.onAction,
                      ),
                      const SizedBox(height: 6),
                      Expanded(
                        child: Text(widget.lesson.actionPlan!.actionText),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
