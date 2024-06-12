import 'package:path/path.dart';
import 'package:reminder_app/models/reminder_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    return await _initDatabase();
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), 'reminders.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE reminders (
        id INTEGER PRIMARY KEY,
        title TEXT,
        notes TEXT,
        time TEXT,
        latitude REAL, 
        longitude REAL
      )
    ''');
  }

  Future<int> insertReminder(Map<String, dynamic> row) async {
    Database db = await database;
    return await db.insert('reminders', row);
  }

  Future<List<ReminderModel>> queryAllReminders() async {
    Database db = await database;
    final reminders = await db.query('reminders', orderBy: 'time DESC');
    return List.generate(reminders.length, (i) {
      return ReminderModel.fromMap(reminders[i]);
    });
  }

  Future<ReminderModel?> getReminderById(int id) async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      'reminders',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return ReminderModel.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> deleteReminder(int id) async {
    Database db = await database;
    return await db.delete('reminders', where: 'id = ?', whereArgs: [id]);
  }
}
