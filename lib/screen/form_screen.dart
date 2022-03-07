import 'package:database/models/Transctions.dart';
import 'package:database/providers/transction_provider.dart';
import 'package:database/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart';

class FormScreen extends StatelessWidget {
  FormScreen({Key key}) : super(key: key);

  final formKey = GlobalKey<FormState>();
  //controller
  final titleController = TextEditingController(); //รับค่ารายการ
  final amountController = TextEditingController(); //รับจำนวนเงิน

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("แบบฟอร์มแสดงข้อมูล"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start, //จัดwidgetให้อยุที่เริ่มต้น
            children: [
              TextFormField(
                  decoration: new InputDecoration(labelText: "ชื่อรายการ"),
                  autofocus: false, //ให้เคาเซอร์มาอยู่ที่ช่อง
                  controller: titleController,
                  validator: (str) {
                    if (str.isEmpty) {
                      return "ป้อนข้อมูลด้วย";
                    }
                    return null;
                  }),
              TextFormField(
                decoration: new InputDecoration(labelText: "จำนวนเงิน"),
                keyboardType: TextInputType.number, //กำหนดให้ป้อนได้แค่ตัวเลข
                controller: amountController,
                validator: (str) {
                  if (str.isEmpty) {
                    return "ป้อนจำวนเงิน";
                  }
                  if (double.parse(str) <= 0) {
                    return "ป้อนตัวเลขที่มากว่า 0";
                  }
                },
              ),
              FlatButton(
                child: Text("เพิ่มข้อมูล"),
                color: Colors.purple,
                textColor: Colors.white,
                onPressed: () {
                  if (formKey.currentState.validate()) {
                    var title = titleController.text;
                    var amount = amountController.text;

                    //เตรีบมข้อมูล
                    Transctions statement = Transctions(
                        title: title,
                        amount: double.parse(amount),
                        date: DateTime.now());
                    //เรียกprovider
                    var provider = Provider.of<TransctionProvider>(context, listen: false);
                    provider.addTransction(statement);

                    Navigator.push(context,MaterialPageRoute(
                      fullscreenDialog: true,
                      builder: (context) {
                        return Database();
                    })); //กดปุ่ม"เพิ่มข้อมูล" แล้วกลับไปหน้าหลัก
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
