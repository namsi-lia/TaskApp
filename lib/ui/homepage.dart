import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:taskapp/controllers/task_controller.dart';
import 'package:taskapp/models/Task.dart';
import 'package:taskapp/services/notification_service.dart';
import 'package:taskapp/services/theme_service.dart';
import 'package:taskapp/ui/add_task_bar.dart';
import 'package:taskapp/ui/theme.dart';
import 'package:taskapp/ui/widgets/button.dart';
import 'package:taskapp/ui/widgets/task_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _selectedDate =DateTime.now();
  final _taskController =Get.put(TaskController());
  var notifyHelper;
  @override
  void initState() {
    super.initState();
    notifyHelper=NotifyHelper();
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();
    setState(() {
      print("welcome");
    });
    
  }
  @override
  Widget build(BuildContext context) {
    print("Build method called");
    return Scaffold(
      appBar: _appBar(),
      
      body: Column(
        children: [
          _addTaskBar(),
           addDateBar(),
           SizedBox(height: 10,),
           _showTasks(),
         
        ],

        
      ),
    );
  }

  _showTasks(){
     return Expanded(
      child: Obx((){
        return ListView.builder(
          itemCount: _taskController.taskList.length,
          itemBuilder: (_, index) {
           print(_taskController.taskList.length);
             return AnimationConfiguration.staggeredList(
              position: index, 
              
              child: SlideAnimation(
                child: FadeInAnimation(
                  child: Row(
                    children: [
                        GestureDetector(
                          onTap: () {
                              _showBottomSheet(context, _taskController.taskList[index]);
                          },
                          child: TaskTile(_taskController.taskList[index]),
                        )
                    ],
                  ))));
            
          },
        );
      }),
     );
  }

  _showBottomSheet(BuildContext context, Task task){
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.only(top: 4),
        height:task.isCompleted==1?
        MediaQuery.of(context).size.height*0.24:
        MediaQuery.of(context).size.height*0.32,
        color: Get.isDarkMode?darkGreyClr:Colors.white,
        child: Column(
          children: [
            Container(
              height: 6,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Get.isDarkMode?Colors.grey[600]:Colors.grey[300],

              ),
            ),
            Spacer(),
            task.isCompleted==1
            ?Container()
            :  _bottomSheetButton
              (label: "Task Completed", 
              onTap: (){
                _taskController.markTaskCompleted(task.id!);
                Get.back();
              }, 
              clr: primaryClr,
              context:context
              
              ),
              _bottomSheetButton
              (label: "Delete Task", 
              onTap: (){
                _taskController.delete(task);
                Get.back();
              }, 
              clr:pinkish,
              context:context
              
              ),
              SizedBox(height: 20,),
                 _bottomSheetButton
              (label: "Close", 
              onTap: (){
                Get.back();
              }, 
              clr:pinkish,
              isClose: true,
              context:context
              
              ),
              SizedBox(height: 10,)
          ],
        ),
      )
    );

  }
  _bottomSheetButton({
    required String label,
    required Function()? onTap,
    required Color clr,
    bool isClose=false,
    required BuildContext context
  }){
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        height: 55,
        width: MediaQuery.of(context).size.width*0.9,
        
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: isClose==true?Get.isDarkMode?Colors.grey[600]!:Colors.grey[300]!:clr
          ),
          borderRadius: BorderRadius.circular(20),
          color: isClose==true?Colors.transparent:clr,
        ),
        child: Center(
          child: Text(label,
          style: isClose?titleStyle:titleStyle.copyWith(color: Colors.white),
          )),
      ),
    );
   
  }

   addDateBar(){
    return  Container(
            margin: const EdgeInsets.only(top: 20, left: 20, bottom: 20),
            child: DatePicker(
              DateTime.now(),
              height: 100,
              width: 80,
              initialSelectedDate: DateTime.now(),
              selectionColor: primaryClr,
              selectedTextColor: Colors.white,
              dateTextStyle: GoogleFonts.lato(
               textStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.grey
              ),
              ),
              dayTextStyle: GoogleFonts.lato(
               textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey
              ),
              ),
              monthTextStyle: GoogleFonts.lato(
               textStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey
              ),
              ),
              onDateChange: (date){
                  _selectedDate=date;
              },
            ),

          );
  }
  _addTaskBar(){
    return  Container(
            margin: const EdgeInsets.only(left: 10, right: 20, top:10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(DateFormat.yMMMd().format(DateTime.now()),
                    style:subHeadingStyle,
                    ),
                    Text("Today",
                     style: headingStyle,
                    )
                  ],
                )
                ),
              MyButton(label: "+ Add Task", onTap: () async{
                await Get.to(()=>const AddTaskPage());
                _taskController.getTasks();
              }          
          )
               ],
            ),
          );
                 
         
  }
  _appBar(){
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
     leading:GestureDetector(
      onTap: () {
        ThemeService().switchTheme();
        notifyHelper.displayNotification(
          title:"Theme changed",
          body:Get.isDarkMode?"Activated Light Theme":"Activated Dark Theme"
        );
        notifyHelper.scheduledNotification();
        
      },
      child: Icon(
  Get.isDarkMode ? 
    (Icons.wb_sunny_outlined) : 
    (Icons.nightlight_outlined),
  size: 20,
  color: Get.isDarkMode ? Colors.white : Colors.black,
)
     ), 
     actions: const [
      CircleAvatar(
        backgroundImage: AssetImage(
          "images/user.png"
        ),
      ),
    
      SizedBox(width: 20,)
     ],
    );
  }
}