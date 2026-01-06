import 'package:sqflite/sqflite.dart';
import '../model/life_lesson.dart';
import 'database.dart';

class LifeLessonDB {
  final AppDatabase _db = AppDatabase.instance;

  // ---------- INSERT ----------
  Future<void> insertLesson(LifeLesson lesson) async {
    final db = await _db.database;

    await db.insert(
      'lessons',
      {
        'id': lesson.id,
        'title': lesson.title,
        'happened': lesson.happened,
        'learned': lesson.learned,
        'date': lesson.date.toIso8601String(),
        'isFavorite': lesson.isFavorite == true ? 1 : 0,
        'category': lesson.category.name,
        'mood': lesson.mood.name,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // ---------- GET ALL ----------
  Future<List<LifeLesson>> getAllLessons() async {
    final db = await _db.database;

    final maps = await db.query(
      'lessons',
      orderBy: 'date DESC',
    );

    return maps.map((map) {
      return LifeLesson(
        id: map['id'] as String,
        title: map['title'] as String,
        happened: map['happened'] as String,
        learned: map['learned'] as String,
        date: DateTime.parse(map['date'] as String),
        isFavorite: map['isFavorite'] == 1,
        category: LessonCategory.values
            .firstWhere((e) => e.name == map['category']),
        mood: Mood.values
            .firstWhere((e) => e.name == map['mood']),
      );
    }).toList();
  }

  // ---------- UPDATE ----------
  Future<void> updateLesson(LifeLesson lesson) async {
    final db = await _db.database;

    await db.update(
      'lessons',
      {
        'title': lesson.title,
        'happened': lesson.happened,
        'learned': lesson.learned,
        'date': lesson.date.toIso8601String(),
        'isFavorite': lesson.isFavorite == true ? 1 : 0,
        'category': lesson.category.name,
        'mood': lesson.mood.name,
      },
      where: 'id = ?',
      whereArgs: [lesson.id],
    );
  }

  Future<void> deleteLesson(String id) async {
    final db = await _db.database;

    await db.delete(
      'lessons',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
