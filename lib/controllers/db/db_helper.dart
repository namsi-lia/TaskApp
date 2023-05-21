// initialize database

import 'package:sqflite/sqflite.dart';
import 'package:taskapp/models/Task.dart';

class DBHelper {
  // sqflite database instance
  static Database? _db;
  static final int _version=1;
  static final String _tableName="tasks";

  //get database instance

  static Future<void> initDb()async{
    if (_db !=null) {
      return ;
      
    }try {
      String _path =await getDatabasesPath() +'task.db';
      _db =await openDatabase(
        _path,
        version: _version,
        onCreate: (db, version) {
          print("creating a new db");
          return db.execute(
            "CREATE TABLE $_tableName("
              "id INTEGER PRIMARY KEY AUTOINCREMENT,"
              "title STRING, note TEXT, date STRING,"
              "startTime STRING, endTime STRING,"
              "remind INTEGER, repeat STRING,"
              "color INTEGER,"
              "isCompleted INTEGER)",
          );
        },
      );
      
    } catch (e) {
      print(e);
      
    }

  }

  static Future<int> insert(Task? task)async {
    print("insert function called");
    return await _db?.insert(_tableName, task!.toJson())??1;
  }

  static Future<List<Map<String, dynamic>>> query(){
    print("query function called");
    return  _db!.query(_tableName);
  }

  static delete(Task task) async{
   return await  _db!.delete(_tableName, where: 'id=?', whereArgs: [task.id]);

  }
  
  
}