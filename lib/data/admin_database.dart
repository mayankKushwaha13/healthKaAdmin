
import 'package:admin/models/admin.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AdminDatabase {
  static Database? database;

  Future<Database?> get createDatabase async {

    if(database != null){
      return database;
    }

    // Directory directory = await getApplicationDocumentsDirectory();
    String path = join(await getDatabasesPath(), 'adminDatabase.db');
    database = await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE adminInfo(
          adminID int,
          firstName TEXT,
          lastName TEXT,
          gender TEXT,
          phone TEXT,
          dob DATE,
          address TEXT
          )
          ''');
      },
    );
    return database!;
  }

  insertData(Admin admin) async {
    Database? db = await createDatabase;
    db!.insert('adminInfo', admin.toMap());
  }

  Future<List<Admin>> readData() async {
    Database? db = await createDatabase;
    final list = await db!.query('adminInfo');
    return list.map((map)=>Admin.fromMap(map)).toList();
  }

  Future updateData(int id, Map<String, Object?> data, ) async {
    Database? db = await createDatabase;
    await db!.update(
      'adminInfo', 
      data,
      where: 'adminID = ?',
      whereArgs: [id],
    );
  }
}