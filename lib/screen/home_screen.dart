import 'package:database/providers/transction_provider.dart';
import 'package:database/models/Transctions.dart';
import 'package:database/screen/form_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    Provider.of<TransctionProvider>(context,listen: false).initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("บัญชี"),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              SystemNavigator.pop();
            },
          )
        ],
      ),
      body: Consumer(
          builder: (context, TransctionProvider provider, Widget child) {
        var count = provider.transction.length; //นับจำนวนข้อมูล

        if (count <= 0) {
          return Center(
            child: Text(
              "ไม่พบข้มูล",
              style: TextStyle(fontSize: 40),
            ),
          );
        } else {
          return ListView.builder(
              itemCount: count, //ดึงข้อมูลความยาวของข้อมูลมา
              itemBuilder: (context, int index) {
                Transctions data =
                    provider.transction[index]; //ดึงข้อมูลที่ละแถว

                return Card(
                  elevation: 5,
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: FittedBox(
                        child: Text(data.amount.toString()),
                      ),
                    ),
                    title: Text(data.title),
                    subtitle:
                        Text(DateFormat("dd/mm/yyyy HH/mm").format(data.date)),
                  ),
                );
              });
        }
      }),
    );
  }
}
