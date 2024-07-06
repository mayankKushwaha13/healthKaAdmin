import 'package:admin/models/doctor.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DoctorsDB {
  static Database? _doctorsDB;

  Future<Database?> get doctorsDB async {
    if(_doctorsDB != null){
      return _doctorsDB;
    }

    String path = join(await getDatabasesPath(), 'doctorsDatabase.db');
    _doctorsDB = await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE doctorInfo(
          adminID INT,
          docID TEXT,
          name TEXT,
          spec TEXT,
          phone TEXT,
          clinicName TEXT,
          days TEXT,
          stime time,
          etime time,
          status TEXT,
          reqDate Date,
          respDate Date
          )
          ''');
      },
    );
    return _doctorsDB!;
  }

  Future insertData(Doctor doctor) async {
    Database? db = await doctorsDB;
    db!.insert('doctorInfo', doctor.toMap());
  }

  Future<List<Doctor>> readData() async {
    Database? db = await doctorsDB;
    final list = await db!.query('doctorInfo');
    return list.map((map) => Doctor.fromMap(map)).toList();
  }

  Future updateData(
    String docID,
    Map<String, Object?> data,
  ) async {
    Database? db = await doctorsDB;
    await db!.update(
      'doctorInfo',
      data,
      where: 'docID = ?',
      whereArgs: [docID],
    );
  }

  Future deleteData(String docID) async {
    Database? db = await doctorsDB;
    await db!.delete(
      'doctorInfo',
      where: 'docID = ?',
      whereArgs: [docID],
    );
  }

  void alterTable() async {   
    Database? db = await doctorsDB;
    await db!.execute("ALTER TABLE doctorInfo ADD respDate Date"); 
    } 
}
