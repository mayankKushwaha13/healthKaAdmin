import 'package:admin/models/receptionist.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ReceptionistDB{
  static Database? _receptionistDB;

  Future<Database?> get receptionistDB async {

    if(_receptionistDB != null){
      return _receptionistDB;
    }
    
    String path = join(await getDatabasesPath(), 'receptionistDatabase.db');
    _receptionistDB = await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE receptionistInfo(
          adminID INT,
          recID TEXT,
          name TEXT,
          gender TEXT,
          phone TEXT,
          dob DATE,
          password TEXT
          )
          ''');
      },
    );
    return _receptionistDB!;
  }

  Future insertData(Receptionist receptionist) async {
    Database? db = await receptionistDB;
    db!.insert('receptionistInfo', receptionist.toMap());
  }

  Future<List<Receptionist>> readData() async {
    Database? db = await receptionistDB;
    final list = await db!.query('receptionistInfo');
    return list.map((map)=>Receptionist.fromMap(map)).toList();
  }

  Future updateData(String recID, Map<String, Object?> data, ) async {
    Database? db = await receptionistDB;
    await db!.update(
      'receptionistInfo', 
      data,
      where: 'recID = ?',
      whereArgs: [recID],
    );
  }

  Future deleteData(String recID) async {
    Database? db = await receptionistDB;
    await db!.delete(
      'receptionistInfo',
      where: 'recID = ?',
      whereArgs: [recID],
    );
  }
}