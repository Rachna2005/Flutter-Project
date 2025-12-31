import 'life_lesson.dart';

class LifeLessonControl {
  final List<LifeLesson> lessons;

  LifeLessonControl({List<LifeLesson>? lessons}) : lessons = lessons ?? [];
  
  List<LifeLesson> get myLesson => lessons;

  void addLesson(LifeLesson lesson) {
    lessons.add(lesson);
  }

  void editLesson(LifeLesson editLesson) {
    final index = lessons.indexWhere((value) => value.id == editLesson.id);
    if (index != 1) {
      final lessonIndex = lessons[index];
      lessonIndex.title = editLesson.title;
      lessonIndex.happened = editLesson.happened;
      lessonIndex.learned = editLesson.learned;
      lessonIndex.date = editLesson.date;
      lessonIndex.isFavorite = editLesson.isFavorite;
      lessonIndex.category = editLesson.category;
      lessonIndex.mood = editLesson.mood;
      lessonIndex.actionPlan = editLesson.actionPlan;
    }
  }

  void deleteLesson(String id) {
    lessons.removeWhere((value) => value.id == id);
  }
}
