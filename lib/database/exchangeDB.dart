import 'package:account/exchangeProgram.dart' show ExchangeProgram;
import 'package:path/path.dart';

class ExchangeDB {
  static final ExchangeDB instance = ExchangeDB._init();
  static Database? _database;

  ExchangeDB._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('exchange.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE students (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        university TEXT NOT NULL,
        country TEXT NOT NULL,
        startDate TEXT NOT NULL,
        endDate TEXT NOT NULL
      )
    ''');
  }

  Future<void> insertStudent(ExchangeProgram student) async {
    final db = await database;
    await db.insert('students', student.toMap());
  }

  Future<List<ExchangeProgram>> getAllStudents() async {
    final db = await database;
    final result = await db.query('students');
    return result.map((e) => ExchangeProgram.fromMap(e)).toList();
  }

  Future<void> deleteStudent(String id) async {
    final db = await database;
    await db.delete('students', where: 'id = ?', whereArgs: [id]);
  }
}

getDatabasesPath() {
}

openDatabase(String path, {required int version, required Future<void> Function(Database db, int version) onCreate}) {
}

extension on Database {
  delete(String s, {required String where, required List<String> whereArgs}) {}
  
  query(String s) {}
  
  insert(String s, Map<String, dynamic> map) {}
  
  execute(String s) {}
}

mixin Database {
}
