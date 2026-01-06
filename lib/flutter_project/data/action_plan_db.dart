import 'package:sqflite/sqflite.dart';
import '../model/action_plan.dart';
import 'database.dart';

class ActionPlanDB {
  final AppDatabase _db = AppDatabase.instance;

  Future<void> insertActionPlan(ActionPlan plan) async {
    final db = await _db.database;

    await db.insert(
      'action_plans',
      {
        'id': plan.id,
        'lessonId': plan.lessonId,
        'actionText': plan.actionText,
        'isComplete': plan.isComplete ? 1 : 0,
        'createdAt': plan.createdAt.toIso8601String(),
      },
    );
  }

  Future<ActionPlan?> getActionPlanByLesson(String lessonId) async {
    final db = await _db.database;

    final maps = await db.query(
      'action_plans',
      where: 'lessonId = ?',
      whereArgs: [lessonId],
      limit: 1,
    );

    if (maps.isEmpty) return null;

    final map = maps.first;

    return ActionPlan(
      id: map['id'] as String,
      lessonId: map['lessonId'] as String,
      actionText: map['actionText'] as String,
      isComplete: map['isComplete'] == 1,
      createdAt: DateTime.parse(map['createdAt'] as String),
    );
  }

  Future<void> updateActionPlan(ActionPlan plan) async {
    final db = await _db.database;

    await db.update(
      'action_plans',
      {
        'lessonId': plan.lessonId,
        'actionText': plan.actionText,
        'isComplete': plan.isComplete ? 1 : 0,
      },
      where: 'id = ?',
      whereArgs: [plan.id],
    );
  }

  Future<void> deleteByLessonId(String lessonId) async {
    final db = await _db.database;

    await db.delete(
      'action_plans',
      where: 'lessonId = ?',
      whereArgs: [lessonId],
    );
  }

  Future<void> deleteActionPlan(String id) async {
    final db = await _db.database;

    await db.delete(
      'action_plans',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
