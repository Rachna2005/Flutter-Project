import 'package:flutter/material.dart';

import '../../model/life_lesson.dart';
import '../../model/life_lesson_control.dart';
import '../lesson/category_page.dart';

class CategoryGrid extends StatelessWidget {
  final LifeLessonControl controller;
  const CategoryGrid({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Categories',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        GridView.count(
          shrinkWrap: true,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          crossAxisCount: 2,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            _CategoryItem(
              title: 'Work',
              icon: Icons.person,
              color: Color(0xFFD6D8FF),
            ),
            _CategoryItem(
              title: 'Health & Well-being',
              icon: Icons.favorite,
              color: Color(0xFFDFF5EA),
            ),
            _CategoryItem(
              title: 'Mistakes / Self-Control',
              icon: Icons.school,
              color: Color(0xFFFFE5CC),
            ),
            _CategoryItem(
              title: 'Relationship',
              icon: Icons.volunteer_activism,
              color: Color(0xFFFFD6E7),
            ),
            _CategoryItem(
              title: 'Growth',
              icon: Icons.trending_up,
              color: Color(0xFFD4F1F4),
            ),
          ],
        ),
      ],
    );
  }
}

class _CategoryItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;

  const _CategoryItem({
    required this.title,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CategoryPage(
              category: LessonCategory.workStudy,
              controller: LifeLessonControl(),
            ),
          ),
        );
      }, // navigation later
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
