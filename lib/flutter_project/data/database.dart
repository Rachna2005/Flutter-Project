import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AppDatabase {
  static final AppDatabase instance = AppDatabase._internal();
  static Database? _database;

  AppDatabase._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'life_lessons.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE lessons(
        id TEXT PRIMARY KEY,
        title TEXT,
        happened TEXT,
        learned TEXT,
        date TEXT,
        isFavorite INTEGER,
        category TEXT,
        mood TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE action_plans(
        id TEXT PRIMARY KEY,
        lessonId TEXT,
        actionText TEXT,
        isComplete INTEGER,
        createdAt TEXT,
        FOREIGN KEY (lessonId) REFERENCES lessons(id) ON DELETE CASCADE
      )
    ''');
  }
}
