import 'package:contactbook/Dbhelper.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'main.dart';

class savepage extends StatefulWidget {
  const savepage({Key? key}) : super(key: key);

  @override
  State<savepage> createState() => _savepageState();
}

class _savepageState extends State<savepage> {
  Database? db;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdatabase();
  }

  getdatabase() {
    Dbhelper().Getdatabase().then((value) {
      setState(() {
        db = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onback,
      child: Scaffold(
        appBar: AppBar(
            title: Text(
          "Create New Contact",
          style: TextStyle(fontSize: 25),
        )),
        body: SafeArea(
            child: Column(
          children: [
            Container(
              height: 60,
              margin: EdgeInsets.all(20),
              child: TextField(
                controller: name,
                style: TextStyle(fontSize: 20),
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.account_circle, size: 35),
                    hintText: "Enter Name",
                    labelText: "Name"),
              ),
            ),
            Container(
              height: 60,
              margin: EdgeInsets.all(20),
              child: TextField(
                controller: number,
                style: TextStyle(fontSize: 20),
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.phone, size: 35),
                    hintText: "Enter Number",
                    labelText: "Number"),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  String nname = name.text;
                  String nnumber = number.text;

                  Dbhelper().insertdata(nname, nnumber, db!).then((value) {
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        return mainpage();
                      },
                    ));
                  });
                },
                child: Text("Insert Data"))
          ],
        )),
      ),
    );
  }

  TextEditingController name = TextEditingController();
  TextEditingController number = TextEditingController();

  Future<bool> onback() {
    showDialog(
      builder: (context) {
        return AlertDialog(actions: [
          FlatButton(
              onPressed: () {
                Navigator.pop(context);

                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) {
                    return mainpage();
                  },
                ));
              },
              child: Text("Yes")), FlatButton(
              onPressed: () {
                Navigator.pop(context);


              },
              child: Text("No"))
        ], title: Text("Are Your Sure To..."));
      },
      context: context,
    );

    return Future.value(true);
  }
}
