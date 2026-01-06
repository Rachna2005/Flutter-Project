//ui/widget/lesson_card.dart
import 'package:flutter/material.dart';
import '../../model/life_lesson.dart';
import 'lesson_helper.dart';

class LessonCard extends StatelessWidget {
  final LifeLesson lesson;
  final VoidCallback onFavorite;
  final VoidCallback onDelete;
  final Color color;
  final ValueChanged<bool?>? onAction;

  const LessonCard({
    super.key,
    required this.lesson,
    required this.onFavorite,
    required this.onDelete,
    required this.color,
    this.onAction,
  });

  @override
  @override
  Widget build(BuildContext context) {
    final categoryColors = categoryColor(lesson.category);

    return Card(
      color: color,
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${lesson.title} ${moodEmoji(lesson.mood)}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Icon(
                            categoryIcon(lesson.category),
                            size: 16,
                            color: categoryColors,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            categoryLabel(lesson.category),
                            style: TextStyle(
                              color: categoryColors,
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 2),

                      Text(
                        formatDate(lesson.date),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),

                Row(
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon: Icon(
                        lesson.isFavorite == true
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: lesson.isFavorite == true
                            ? Colors.red
                            : Colors.grey,
                        size: 22,
                      ),
                      onPressed: onFavorite,
                    ),
                    SizedBox(width: 10),
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon: const Icon(
                        Icons.delete_outlined,
                        size: 22,
                      ),
                      onPressed: onDelete,
                    ),
                  ],
                ),
              ],
            ),
            if (lesson.actionPlan != null) ...[
              const Divider(height: 20),
              Row(
                children: [
                  Checkbox(
                    value: lesson.actionPlan!.isComplete,
                    onChanged: onAction,
                  ),
                  Expanded(
                    child: Text(
                      lesson.actionPlan!.actionText,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

}
