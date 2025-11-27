import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'task.dart';

class DBHelper {
  static final DBHelper instance = DBHelper._internal();
  factory DBHelper() => instance;
  DBHelper._internal();

  Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    return await _initDB();
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, "tasks.db");

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, _) async {
        await db.execute("""
          CREATE TABLE tasks (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            date TEXT,
            done INTEGER
          )
        """);
      },
    );
  }

  Future<int> insertTask(Task task) async {
    var database = await db;
    return await database.insert("tasks", task.toMap());
  }

  Future<List<Task>> getAllTasks() async {
    var database = await db;
    var res = await database.query("tasks");
    return res.map((t) => Task.fromMap(t)).toList();
  }

  Future<List<Task>> getTasksByDate(String date) async {
    var database = await db;
    var res =
        await database.query("tasks", where: "date = ?", whereArgs: [date]);
    return res.map((t) => Task.fromMap(t)).toList();
  }

  Future<int> updateTask(Task task) async {
    var database = await db;
    return await database.update(
      "tasks",
      task.toMap(),
      where: "id = ?",
      whereArgs: [task.id],
    );
  }

  Future<int> markDone(int id, int done) async {
    var database = await db;
    return await database.update(
      "tasks",
      {"done": done},
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<void> deleteTask(int id) async {
    var database = await db;
    await database.delete("tasks", where: "id = ?", whereArgs: [id]);
  }
}
