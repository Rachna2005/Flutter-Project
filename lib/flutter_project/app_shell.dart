import 'package:flutter/material.dart';
import 'ui/home_page.dart';
import 'ui/lesson/all_lesson_page.dart';
import 'ui/lesson/create_lesson_page.dart';

import 'model/life_lesson_control.dart';
import 'model/life_lesson.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _currentIndex = 0;

  final LifeLessonControl controller = LifeLessonControl();

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomePage(controller: controller),
      // FavoritePage(controller: controller),
      Center(child: Text('favorite page')),
      AllLessonsPage(allLessons: controller),
    ];

    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: pages),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final LifeLesson? result = await Navigator.push<LifeLesson>(
            context,
            MaterialPageRoute(
              builder: (_) => CreateLifeLessonPage(allLessons: controller),
            ),
          );

          if (result != null) {
            setState(() {
              _currentIndex = 2; 
            });
          }
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Lessons'),
        ],
      ),
    );
  }
}
