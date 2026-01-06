import 'package:flutter/material.dart';
import '../../model/life_lesson.dart';
import '../widget/lesson_card.dart';
import '../widget/lesson_helper.dart';

class FavoritePage extends StatelessWidget {
  final List<LifeLesson> favorites;

  const FavoritePage({
    super.key,
    required this.favorites,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFC7DEFC),
        surfaceTintColor: Colors.transparent,
        title: Text(
          'Favorite Lessons',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        leading: const BackButton(),
      ),
      body: favorites.isEmpty
          ? const Center(
              child: Text(
                'No favorite lessons yet 💔',
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final lesson = favorites[index];

                return LessonCard(
                  lesson: lesson,
                  color: categoryCardColor(lesson.category),
                  onFavorite: () {}, 
                  onDelete: () {},
                );
              },
            ),
    );
  }
}
