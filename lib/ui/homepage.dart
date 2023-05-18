
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:taskapp/services/notification_service.dart';
import 'package:taskapp/services/theme_service.dart';
import 'package:taskapp/ui/add_task_bar.dart';
import 'package:taskapp/ui/theme.dart';
import 'package:taskapp/ui/widgets/button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _selectedDate =DateTime.now();
  var notifyHelper;
  @override
  void initState() {
    super.initState();
    notifyHelper=NotifyHelper();
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Column(
        children: [
          _addTaskBar(),
           addDateBar(),
         
        ],

        
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
              MyButton(label: "+ Add Task", onTap: () => Get.to(AddTaskPage()))
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