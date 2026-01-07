// lib/flutter_project/ui/home/category_grid.dart
// import 'package:flutter/material.dart';

// import '../../model/life_lesson.dart';
// import '../../model/life_lesson_control.dart';
// import '../lesson/category_page.dart';

// class CategoryGrid extends StatelessWidget {
//   final LifeLessonControl controller;
//   const CategoryGrid({super.key, required this.controller});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Categories',
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 12),
//         GridView.count(
//           shrinkWrap: true,
//           crossAxisSpacing: 12,
//           mainAxisSpacing: 12,
//           crossAxisCount: 2,
//           physics: const NeverScrollableScrollPhysics(),
//           children: const [
//             _CategoryItem(
//               title: 'Work',
//               icon: Icons.person,
//               color: Color(0xFFD6D8FF),
//             ),
//             _CategoryItem(
//               title: 'Health & Well-being',
//               icon: Icons.favorite,
//               color: Color(0xFFDFF5EA),
//             ),
//             _CategoryItem(
//               title: 'Mistakes / Self-Control',
//               icon: Icons.school,
//               color: Color(0xFFFFE5CC),
//             ),
//             _CategoryItem(
//               title: 'Relationship',
//               icon: Icons.volunteer_activism,
//               color: Color(0xFFFFD6E7),
//             ),
//             _CategoryItem(
//               title: 'Growth',
//               icon: Icons.trending_up,
//               color: Color(0xFFD4F1F4),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }

// class _CategoryItem extends StatelessWidget {
//   final String title;
//   final IconData icon;
//   final Color color;

//   const _CategoryItem({
//     required this.title,
//     required this.icon,
//     required this.color,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       borderRadius: BorderRadius.circular(12),
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (_) => CategoryPage(
//               category: LessonCategory.workStudy,
//               controller: LifeLessonControl(),
//             ),
//           ),
//         );
//       }, // navigation later
//       child: Container(
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: color,
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Row(
//           children: [
//             Icon(icon),
//             const SizedBox(width: 8),
//             Expanded(
//               child: Text(
//                 title,
//                 style: const TextStyle(fontWeight: FontWeight.w600),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// lib/flutter_project/ui/home/category_grid.dart
import 'package:flutter/material.dart';
import '../../model/life_lesson.dart';
import '../widget/lesson_helper.dart';

class CategoryGrid extends StatelessWidget {
  final void Function(LessonCategory) onTap;
  final bool thin;
  final String title;

  const CategoryGrid({
    super.key,
    required this.onTap,
    this.thin = false,
    this.title = 'Categories', // default title
  });

  @override
  Widget build(BuildContext context) {
    final categories = LessonCategory.values;

    // Use LayoutBuilder to get width of parent
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        const crossAxisCount = 2;
        const spacing = 8.0;

        // Calculate card width based on available space
        final cardWidth = (width - (crossAxisCount - 1) * spacing) / crossAxisCount;
        final cardHeight = thin ? cardWidth / 3 : cardWidth / 2;

        final iconSize = cardHeight * 0.4; // scale icon
        final fontSize = cardHeight * 0.2; // scale text

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title above grid
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            // Grid
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(), // scroll handled by parent
              shrinkWrap: true,
              itemCount: categories.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                mainAxisSpacing: spacing,
                crossAxisSpacing: spacing,
                childAspectRatio: cardWidth / cardHeight,
              ),
              itemBuilder: (context, index) {
                final category = categories[index];

                return GestureDetector(
                  onTap: () => onTap(category),
                  child: SizedBox(
                    height: cardHeight, // fix height → prevents overflow
                    child: Card(
                      color: categoryCardColor(category), // soft pastel
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                      shadowColor: Colors.black26,
                      child: Padding(
                        padding: const EdgeInsets.all(4), // smaller padding
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              categoryIcon(category),
                              size: iconSize,
                              color: categoryColor(category), // bold icon
                            ),
                            const SizedBox(height: 2),
                            Text(
                              categoryLabel(category),
                              style: TextStyle(
                                color: categoryColor(category), // bold text
                                fontWeight: FontWeight.bold,
                                fontSize: fontSize,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 2, // prevent text overflow
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
