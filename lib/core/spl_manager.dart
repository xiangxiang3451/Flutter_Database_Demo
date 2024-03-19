import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;
//获取数据库对象
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await initDatabase();
    return _database!;
  }
//初始化数据库
  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'my_database.db');
    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }
//创建表
  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE my_table(
        id INTEGER PRIMARY KEY,
        content TEXT
      )
    ''');
  }
//插入数据
  Future<void> insertData(String content) async {
    final Database db = await database;
    await db.insert('my_table', {'content': content});
  }

  Future<List<Map<String, dynamic>>> getData() async {
    final Database db = await database;
    return await db.query('my_table');
  }

 //通过ID删除数据
  Future<void> deleteDataById(int id) async {
  final Database db = await database;
  await db.delete('my_table', where: 'id = ?', whereArgs: [id]);
}

}
