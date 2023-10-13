import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._internal();
  factory DatabaseHelper() => instance;

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initDatabase();
    return _database;
  }

  Future<Database> initDatabase() async {
    final path = join(await getDatabasesPath(), 'tasks.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE tasks(
            id INTEGER PRIMARY KEY,
            name TEXT,
            priority TEXT,
            prioritylevel INTEGER,
            isCompleted INTEGER
          )
        ''');
      },
    );
  }

  Future<int> insertTask(Map<String, dynamic> taskData) async {
    final db = await database;
    return await db!.insert('tasks', taskData);
  }

  Future<List<Map<String, dynamic>>> retrieveTasks() async {
    final db = await database;
    return await db!.query('tasks');
  }

  Future<int> updateTask(Map<String, dynamic> taskData) async {
    final db = await database;
    return await db!.update(
      'tasks',
      taskData,
      where: 'id = ?',
      whereArgs: [taskData['id']],
    );
  }

  Future<int> deleteTask(int taskId) async {
    final db = await database;
    return await db!.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [taskId],
    );
  }
}
