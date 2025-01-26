import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'resto_buy_food.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE food (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        description TEXT,
        image TEXT,
        price REAL
      )
    ''');

    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT NOT NULL,
        password TEXT NOT NULL
      )
    ''');
  }

  Future<List<Map<String, dynamic>>> fetchFoods() async {
    Database db = await instance.database;
    return await db.query('food');
  }

  Future<int> insertFood(Map<String, dynamic> food) async {
    Database db = await instance.database;
    return await db.insert('food', food);
  }

  Future<int> registerUser(String username, String password) async {
    Database db = await instance.database;
    return await db.insert('users', {'username': username, 'password': password});
  }

  Future<Map<String, dynamic>?> loginUser(String username, String password) async {
    Database db = await instance.database;
    final result = await db.query('users',
        where: 'username = ? AND password = ?',
        whereArgs: [username, password]);
    return result.isNotEmpty ? result.first : null;
  }
}
