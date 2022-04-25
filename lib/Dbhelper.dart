import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Dbhelper {
  Future<Database> Getdatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'sshdgsahfdsafg.db');

    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'create table Contactbook (id integer primary key autoincrement, name Text , number Text)  ');
    });
    return database;
  }

  Future<void> insertdata(

      String nname, String nnumber, Database database1111) async {
    String insertqry =
        "insert into Contactbook (name,number)  values('$nname','$nnumber')";
    int cnt = await database1111.rawInsert(insertqry);
    print(cnt);
  }

  Future<List<Map>> viewdata(Database database) async {

    String viewqry = "select * from Contactbook";


 List<Map> list = await   database.rawQuery(viewqry);

 print("DATA===$list");
    return list;
  }

// Get a location using getDatabasesPath

}
