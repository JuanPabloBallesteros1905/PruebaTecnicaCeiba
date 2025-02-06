import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:users/features/users/data/models/users_model.dart';

class LocalDatabase {
  static final LocalDatabase _instance = LocalDatabase._internal();
  factory LocalDatabase() => _instance;
  static Database? _database;

  LocalDatabase._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future _initDatabase() async {
    final dbPath = await getDatabasesPath();

    print('PATH DE LA BASE DE DATOOOS ${dbPath}');

    return openDatabase(
      '$dbPath/users.db',
      version: 1,
      onCreate: (db, version) => _createDataBase(db, version),
    );
  }

  Future _createDataBase(Database db, int version) async {
    await db.execute('''
       CREATE TABLE users (
        id INTEGER PRIMARY KEY,
        name TEXT,
        email TEXT,
        phone TEXT
  )
''');
  }

  //*Obtener data del usuario
  Future<List<Map<String, Object?>>?> getDataUsers() async {
    try {
      final db = await database;

      final response = await db.query('users');

      return response;
    } catch (e) {
      print('Error al traer los usuarios desde la bd $e');
      return null;
    }
  }

  //* insertar registros de usuarios
  Future insertUserData(UsersModel user) async {
    try {
      final db = await database;
      final response = await db.insert('users', {
        'name': user.name,
        'email': user.email,
        'phone': user.phone,
      });
      return response;
    } catch (e) {
      print('error al insertar en la bd $e');
      return null;
    }
  }
}
