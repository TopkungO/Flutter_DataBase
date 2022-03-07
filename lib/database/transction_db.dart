import 'dart:io';
import 'package:database/models/Transctions.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class TransctionDB {
  //บริการเกี่ยงกับฐานข้อมูล
  String dbName;

  TransctionDB({this.dbName});

  //dbLocation = /data/user/0/com.example.database/app_flutter/transctions.db
  Future<Database> openDatabase() async {
    //หาตำแหน่งที่เก็บข้อมูล
    Directory appDirectory = await getApplicationDocumentsDirectory();
    String dbLocation = join(appDirectory.path, dbName);
    //สร้างDB
    DatabaseFactory dbFactory = await databaseFactoryIo;
    Database db = await dbFactory.openDatabase(dbLocation);
    return db;
  }

  //บันทึกข้อมูล
  Future<int> InsertData(Transctions statement) async {
    //ฐานข้อมูล =>ข้อมูล
    //transction.db =>expense
    var db = await this.openDatabase();
    var store = intMapStoreFactory.store("expense");

    //json
    var keyID = store.add(db, {
      "title": statement.title,
      "amount": statement.amount,
      "date": statement.date.toIso8601String() //จัดfomat
    });
    db.close();
    return keyID;
  }

  //ดึงข้อมูล
  Future<List> loadAllData() async {
    var db = await this.openDatabase();
    var store = intMapStoreFactory.store("expense");

    //ใหม่=>เก่า false มาก ไป น้อย
    //เก่า=>ใหม่ true  น้อย ไป มาก
    var snapshot = await store.find(db,
        finder: Finder(sortOrders: [SortOrder(Field.key, false)]));
    
    List transactionList = List<Transctions>();
    //ดึงข้อมูลมาที่ละแถว
    for (var record in snapshot) {
      transactionList.add(Transctions(
          title: record["title"],
          amount: record["amount"],
          date: DateTime.parse(record["date"])));
    }

    return transactionList;
  }
}
