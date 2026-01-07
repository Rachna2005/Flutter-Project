// import 'package:flutter/material.dart';
// import '../../model/life_lesson.dart';
// import '../widget/lesson_card.dart';
// import '../widget/lesson_helper.dart';

// class FavoritePage extends StatelessWidget {
//   final List<LifeLesson> favorites;

//   const FavoritePage({
//     super.key,
//     required this.favorites,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color(0xFFC7DEFC),
//         surfaceTintColor: Colors.transparent,
//         title: Text(
//           'Favorite Lessons',
//           style: Theme.of(context).textTheme.titleLarge,
//         ),
//         leading: const BackButton(),
//       ),
//       body: favorites.isEmpty
//           ? const Center(
//               child: Text(
//                 'No favorite lessons yet 💔',
//                 style: TextStyle(fontSize: 16),
//               ),
//             )
//           : ListView.builder(
//               padding: const EdgeInsets.all(16),
//               itemCount: favorites.length,
//               itemBuilder: (context, index) {
//                 final lesson = favorites[index];

//                 return LessonCard(
//                   lesson: lesson,
//                   color: categoryCardColor(lesson.category),
//                   onFavorite: () {}, 
//                   onDelete: () {},
//                 );
//               },
//             ),
//     );
//   }
// }
// lib/flutter_project/ui/lesson/favorite_page.dart
import 'package:flutter/material.dart';
import '../../model/life_lesson.dart';
import '../../model/life_lesson_control.dart';
import '../widget/lesson_card.dart';
import '../widget/lesson_helper.dart';
import 'life_lesson_detail.dart';

class FavoritePage extends StatefulWidget {
  final LifeLessonControl controller;

  const FavoritePage({super.key, required this.controller});

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
        leading: const BackButton(),
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
                      lesson: lesson,
                      color: categoryCardColor(lesson.category),
                      onFavorite: () async {
                        // Toggle favorite
                        await widget.controller.toggleFavorite(lesson);
                        await _loadFavorites(); // refresh immediately
                      },
                      onDelete: () async {
                        await widget.controller.removeLesson(lesson);
                        await _loadFavorites(); // refresh immediately
                      },
                      onAction: (value) async {
                        if (lesson.actionPlan == null || value == null) return;
                        await widget.controller.tapActionPlan(
                          lesson.actionPlan!,
                          value,
                        );
                        await _loadFavorites(); // refresh if needed
                      },
                    );
                  },
                ),
    );
  }
}
