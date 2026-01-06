import 'package:flutter/material.dart';
import '../../model/life_lesson.dart';
import '../widget/lesson_card.dart';
import '../widget/lesson_helper.dart';

class FavoriteSection extends StatelessWidget {
  final List<LifeLesson> favorites;
  const FavoriteSection({super.key, required this.favorites});

  @override
  Widget build(BuildContext context) {
    if (favorites.isEmpty) {
      return const Text('No favorite lessons yet');
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: favorites.map((lesson) {
        return LessonCard(
          lesson: lesson,
          color: categoryCardColor(lesson.category),
          onFavorite: () {},
          onDelete: () {},
        );
      }).toList(),
    );
  }
}

