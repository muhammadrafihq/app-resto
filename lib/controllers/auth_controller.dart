import '../models/database_helper.dart';

class AuthController {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  Future<bool> register(String username, String password) async {
    final id = await _dbHelper.registerUser(username, password);
    return id > 0;
  }

  Future<bool> login(String username, String password) async {
    final user = await _dbHelper.loginUser(username, password);
    return user != null;
  }
}
