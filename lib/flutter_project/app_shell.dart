//lib/flutter_project/app_shell.dart
import 'package:flutter/material.dart';
import 'ui/home_page.dart';
import 'ui/lesson/all_lesson_page.dart';
import 'ui/lesson/create_lesson_page.dart';
import 'model/life_lesson_control.dart';
import 'data/sample_data.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _currentIndex = 0;

  final LifeLessonControl controller = lifeLesson;

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomePage(controller: controller),
      AllLessonsPage(allLessons: controller),
      CreateLifeLessonPage(
        allLessons: controller,
        ),
      const Center(child: Text('Search (Later)')),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: const Color.fromARGB(255, 2, 32, 63),
        unselectedItemColor: const Color.fromARGB(223, 0, 0, 0),
        backgroundColor: const Color.fromARGB(255, 120, 177, 251), 
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorite'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        ],
      ),
    );
  }
}
