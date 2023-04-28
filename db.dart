import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MyDb {
  late Database db;

  Future open() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo1.db');
    //join is from path package
    print(
        path); //output /data/user/0/com.testapp.flutter.testapp/databases/demo.db

    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute('''

                  CREATE TABLE IF NOT EXISTS employees( 
                        id primary key,
                        fname varchar(255) not null,
                        lname varchar(255) not null,
                        email varchar(255) not null,
                        mobileno int not null
                    );
                    // name varchar(255) not null,
                    // roll_no int not null,
                    // address varchar(255) not null
                    //create more table here
                
                ''');
      //table employees will be created if there is no table 'employees'
      print("Table Created");
    });
  }

  Future<Map<dynamic, dynamic>?> getEmployee(int mobileno) async {
    List<Map> maps = await db
        .query('employees', where: 'mobileno = ?', whereArgs: [mobileno]);
    //getting employee data with roll no.
    if (maps.length > 0) {
      return maps.first;
    }
    return null;
  }
}
