// lib/flutter_project/ui/lesson/favorite_page.dart
import 'package:flutter/material.dart';
import '../../model/life_lesson.dart';
import '../../model/life_lesson_control.dart';
import '../widget/lesson_card.dart';
import '../widget/lesson_helper.dart';
import 'life_lesson_detail.dart';

class FavoritePage extends StatefulWidget {
  final LifeLessonControl controller;
  final bool active;

  const FavoritePage({
    super.key,
    required this.controller,
    required this.active,
  });

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List<LifeLesson> _favorites = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  @override
  void didUpdateWidget(covariant FavoritePage oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.active && !oldWidget.active) {
      _loadFavorites();
    }
  }

  Future<void> _loadFavorites() async {
    final favs = await widget.controller.favoriteLessons();
    if (!mounted) return;
    setState(() {
      _favorites = favs;
      _loading = false;
    });
  }

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
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _favorites.isEmpty
          ? const Center(
              child: Text(
                'No favorite lessons yet 💔',
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _favorites.length,
              itemBuilder: (context, index) {
                final lesson = _favorites[index];

                return LessonCard(
                  key: ValueKey(lesson.id),
                  lesson: lesson,
                  color: categoryCardColor(lesson.category),

                  onFavorite: () async {
                    setState(() {
                      lesson.isFavorite = !(lesson.isFavorite ?? false);
                      _favorites.removeWhere((l) => l.id == lesson.id);
                    });
                    await widget.controller.editLesson(lesson);
                  },

                  onDelete: () async {
                    setState(() {
                      _favorites.removeWhere((l) => l.id == lesson.id);
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
                );
              },
            ),
    );
  }
}
