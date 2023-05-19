import 'package:get/get.dart';
import 'package:taskapp/controllers/db/db_helper.dart';
import 'package:taskapp/models/Task.dart';

class TaskController extends GetxController{

  @override
  void onReady(){
    getTasks();
    super.onReady();

  
  }

  var taskList = <Task>[].obs;
    //create method for model
    Future<int> addTask({Task? task}) async {

      return await DBHelper.insert(task);
    }

    //get all the data from table
    void getTasks() async {
      List<Map<String, dynamic>> tasks =await DBHelper.query();
      taskList.assignAll(tasks.map((data) => new Task.fromJson(data)).toList());
         }

}