import 'package:sqflite/sqflite.dart';

import 'student.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> getDatabase() async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = '$dbPath/students.db';

    return openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE students (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        regno TEXT,
        cgpa REAL
      )
    ''');
  }

  Future<int> insertStudent(Student student) async {
    final db = await getDatabase();
    return db.insert(
      'students',
      student.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Student>> getStudents() async {
    final db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query(
      'students',
      orderBy: 'id ASC',
    );

    return List.generate(maps.length, (index) {
      return Student.fromMap(maps[index]);
    });
  }
}
