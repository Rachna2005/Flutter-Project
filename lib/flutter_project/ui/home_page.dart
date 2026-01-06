import 'package:flutter/material.dart';
import 'home/reflection_insight_card.dart';
import 'home/total_lesson_bar.dart';
import 'home/category_grid.dart';
import 'home/favorite_section.dart';
import '../model/life_lesson_control.dart';

class HomePage extends StatelessWidget {
  final LifeLessonControl controller;
  const HomePage({super.key,required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFC7DEFC),
        title: const Text(
          'Welcome to Merein jivit',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ReflectionInsightCard(category: controller.mostFrequentCategory),
            SizedBox(height: 12),
            TotalLessonBar(total: controller.totalLessons),
            SizedBox(height: 16),
            CategoryGrid(controller: controller),
            SizedBox(height: 16),
            FavoriteSection(favorites: controller.favoriteLessons,),
          ],
        ),
      ),
    );
  }
}
