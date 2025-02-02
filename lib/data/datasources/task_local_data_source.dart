import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/task_model.dart';

abstract class TaskLocalDataSource {
  Future<List<TaskModel>> getTasks();
  Future<void> addTask(TaskModel task);
  Future<void> updateTask(TaskModel task);
  Future<void> deleteTask(String taskId);
  Future<void> updateTaskReview(String taskId, String review);
  Future<void> editTask(TaskModel task);
}

class TaskLocalDataSourceImpl implements TaskLocalDataSource {
  final List<TaskModel> _tasks = [];

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'tasks.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        return db.execute('''
          CREATE TABLE tasks (
            id TEXT PRIMARY KEY,
            title TEXT NOT NULL,
            isCompleted INTEGER NOT NULL,
            review TEXT
          )
        ''');
      },
    );
  }

  @override
  Future<List<TaskModel>> getTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('tasks');
    return maps.map((map) => TaskModel.fromJson(map)).toList();
  }

  @override
  Future<void> addTask(TaskModel task) async {
    final db = await database;
    await db.insert('tasks', task.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<void> editTask(TaskModel task) async {
    final db = await database;
    await db.update('tasks', task.toJson(), where: 'id = ?', whereArgs: [task.id]);
  }

  @override
  Future<void> updateTask(TaskModel task) async {
    final db = await database;
    await db.update('tasks', task.toJson(), where: 'id = ?', whereArgs: [task.id]);
  }

  @override
  Future<void> deleteTask(String taskId) async {
    final db = await database;
    await db.delete('tasks', where: 'id = ?', whereArgs: [taskId]);
  }


  @override
  Future<void> updateTaskReview(String taskId, String review) async {
    final db = await database;
    await db.update(
      'tasks',
      {'review': review},
      where: 'id = ?',
      whereArgs: [taskId],
    );
  }
}