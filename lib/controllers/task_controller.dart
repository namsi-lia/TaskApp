import 'package:get/get.dart';
import 'package:taskapp/controllers/db/db_helper.dart';
import 'package:taskapp/models/Task.dart';

class TaskController extends GetxController{

  @override
  void onReady(){
    super.onReady();

  
  }
    //create method for model
    Future<int> addTask({Task? task}) async {

      return await DBHelper.insert(task);
    }

}