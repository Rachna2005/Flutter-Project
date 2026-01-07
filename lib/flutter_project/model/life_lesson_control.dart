import 'life_lesson.dart';
import 'action_plan.dart';
import '../data/life_lesson_db.dart';
import '../data/action_plan_db.dart';

class LifeLessonControl {
  final LifeLessonDB _lessonDb = LifeLessonDB();
  final ActionPlanDB _actionPlanDb = ActionPlanDB();

  Future<List<LifeLesson>> getLessons() async {
    final lessons = await _lessonDb.getAllLessons();

    for (final lesson in lessons) {
      lesson.actionPlan = await _actionPlanDb.getActionPlanByLesson(lesson.id);
    }

    return lessons;
  }

  Future<LifeLesson> addLesson(LifeLesson lesson) async {
    await _lessonDb.insertLesson(lesson);

    if (lesson.actionPlan != null) {
      await _actionPlanDb.insertActionPlan(lesson.actionPlan!);
    }

    return lesson;
  }

  Future<void> editLesson(LifeLesson lesson) async {
    await _lessonDb.updateLesson(lesson);

    if (lesson.actionPlan != null) {
      await _actionPlanDb.insertActionPlan(lesson.actionPlan!);
    } else {
      await _actionPlanDb.deleteByLessonId(lesson.id);
    }
  }

  Future<void> deleteLesson(String id) async {
    await _actionPlanDb.deleteByLessonId(id);
    await _lessonDb.deleteLesson(id);
  }

  Future<void> tapActionPlan(ActionPlan plan, bool isComplete) async {
    plan.isComplete = isComplete;
    await _actionPlanDb.updateActionPlan(plan);
  }

  Future<int> totalLessons() async {
    final lessons = await getLessons();
    return lessons.length;
  }

  Future<List<LifeLesson>> favoriteLessons() async {
    final lessons = await getLessons();
    return lessons.where((l) => l.isFavorite == true).toList();
  }

  Future<LessonCategory?> mostFrequentCategory() async {
    final lessons = await getLessons();
    if (lessons.isEmpty) return null;

    final Map<LessonCategory, int> count = {};

    for (var lesson in lessons) {
      count[lesson.category] = (count[lesson.category] ?? 0) + 1;
    }

    return count.entries.reduce((a, b) => a.value > b.value ? a : b).key;
  }

  Future<List<LifeLesson>> lessonsByCategory(LessonCategory category) async {
    final lessons = await getLessons();
    return lessons.where((l) => l.category == category).toList();
  }

  Future<List<LifeLesson>> recentLessons({int limit = 5}) async {
  final lessons = await getLessons(); // already sorted DESC
  return lessons.take(limit).toList(); // take newest
  }


    Future<void> toggleFavorite(LifeLesson lesson) async {
    lesson.isFavorite = !(lesson.isFavorite ?? false);
    await editLesson(lesson);
  }

  Future<void> removeLesson(LifeLesson lesson) async {
    await deleteLesson(lesson.id);
  }

}
