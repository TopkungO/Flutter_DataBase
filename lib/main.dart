import 'package:database/providers/transction_provider.dart';
import 'package:database/screen/form_screen.dart';
import 'package:database/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) {
            return TransctionProvider();
          })
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: Database(),
        ));
  }
}

class Database extends StatefulWidget {
  Database({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _DatabaseState createState() => _DatabaseState();
}

class _DatabaseState extends State<Database> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.redAccent,
        body: TabBarView(
          children: [
            HomeScreen(),
            FormScreen(),
          ],
        ),
        bottomNavigationBar: TabBar(
          tabs: [
            Tab(text: "รายการธุรกรรม",icon: Icon(Icons.list),),
            Tab(text: "บันทึกข้อมูล",icon: Icon(Icons.add))
          ],
        ),
      ),
    );
  }
}
