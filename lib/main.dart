import 'package:contactbook/Dbhelper.dart';
import 'package:contactbook/savepage.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  runApp(MaterialApp(
    home: mainpage(),
  ));
}

class mainpage extends StatefulWidget {
  const mainpage({Key? key}) : super(key: key);

  @override
  State<mainpage> createState() => _mainpageState();
}

class _mainpageState extends State<mainpage> {


  Database? db;
  List<Map> mm = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAlldaTA();
  }

  getAlldaTA() {
    Dbhelper().Getdatabase().then((value) {
      setState(() {
        db = value;
      });
      Dbhelper().viewdata(db!).then((listofmap) {
        setState(() {
          mm = listofmap;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) {
              return savepage();
            },
          ));
        },
      ),
      appBar: AppBar(title: Center(child: Text("Contact Book"))),
      body: ListView.builder(itemCount: mm.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("${mm[index]['name']}"),
          );
        },
      ),
    );
  }
}
