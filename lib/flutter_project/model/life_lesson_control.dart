import 'life_lesson.dart';

class LifeLessonControl {
  final List<LifeLesson> lessons;

  LifeLessonControl({List<LifeLesson>? lessons}) : lessons = lessons ?? [];
  
  List<LifeLesson> get myLesson => lessons;

  void addLesson(LifeLesson lesson) {
    lessons.add(lesson);
  }
  

  void editLesson(LifeLesson updatedLesson) {
  final index = lessons.indexWhere(
    (lesson) => lesson.id == updatedLesson.id,
  );

  if (index == -1) return; 
  lessons[index] = updatedLesson; 
}

  void deleteLesson(String id) {
    lessons.removeWhere((value) => value.id == id);
  }
  int get totalLessons => lessons.length;

List<LifeLesson> get favoriteLessons =>
    lessons.where((l) => l.isFavorite == true).toList();

LessonCategory? get mostFrequentCategory {
  if (lessons.isEmpty) return null;

  final Map<LessonCategory, int> count = {};

  for (var lesson in lessons) {
    count[lesson.category] = (count[lesson.category] ?? 0) + 1;
  }

  return count.entries.reduce((a, b) => a.value > b.value ? a : b).key;
}

List<LifeLesson> lessonsByCategory(LessonCategory category) {
  return lessons.where((l) => l.category == category).toList();
}
}