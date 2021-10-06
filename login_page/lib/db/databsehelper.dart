
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';
import 'dbmodel.dart';

abstract class DB {
  static Database? _db;

  static int get _version => 1;

  static Future<void> init() async {
    if (_db != null) {
      return;
    }

    try {
      var databasesPath = await getDatabasesPath();
      String _path = p.join(databasesPath, 'crud.db');
      _db = await openDatabase(_path, version: _version, onCreate: onCreate);
    } catch (ex) {
      print(ex);
    }
  }

  static void onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE table (id INTEGER PRIMARY KEY AUTOINCREMENT, movieName STRING,  directorName STRING, date STRING, productPic String)');

  }

  static Future<List<Map<String, dynamic>>> query(String table) async =>
      _db!.query(table);

  static Future<int> insert(String table, Model model) async =>
      await _db!.insert(table, model.toMap());

  static Future<int> update(String table, Model model) async => await _db!
      .update(table, model.toMap(), where: 'id = ?', whereArgs: [model.id]);

  static Future<int> delete(String table, Model model) async =>
      await _db!.delete(table, where: 'id = ?', whereArgs: [model.id]);

}
