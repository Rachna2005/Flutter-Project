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
