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
}
