import 'package:flutter/foundation.dart';
import 'package:database/database/transction_db.dart';
import 'package:database/models/Transctions.dart';

class TransctionProvider with ChangeNotifier{
  //ชื่อรายการ,จำนวนเงิน,วันที่
  List<Transctions> transction =[];

  List<Transctions> getTransction(){
    return transction;
  }
  void initData() async{
    var db =TransctionDB(dbName: "transctions.db");
    //ดึงข้อมูลมาแสดง
    transction = await db.loadAllData();
    notifyListeners();


  }
  void addTransction(Transctions statement) async{
    
    var db =TransctionDB(dbName: "transctions.db");
    //บันทึกข้อมูล
    await db.InsertData(statement);
    //ดึงข้อมูลมาแสดง
    transction=await db.loadAllData();
    //transction.insert(0,statement);//อันเก่า
    //แจ้งเตือน consumer
    notifyListeners();
  }

}