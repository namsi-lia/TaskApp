import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:taskapp/ui/theme.dart';
import 'package:taskapp/ui/widgets/input_field.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key?key}):super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  DateTime _selectedDate=DateTime.now();
  String _endTime="9:30PM";
  String _startTime= DateFormat("hh:mm a").format(DateTime.now()).toString();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _appBar(context),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Add Task",
              style: headingStyle,
              textAlign: TextAlign.left,
              ),
              const MyInputField(title: "Title", hint: "Enter your Tittle"),
              const MyInputField(title: "Note", hint: "Enter your note"),
              MyInputField(title: "Date", hint: DateFormat.yMd().format(_selectedDate),
              widget:IconButton(
                icon: const Icon(Icons.calendar_month_outlined,
                color: Colors.grey,
                ),
                onPressed: () {
                  print ("hi there");
                  _getDateFromUser();
                },
              )),
              Row(
                children: [
                  Expanded(child: MyInputField(
                    title: "Start Date",
                    hint: _startTime,
                    widget: IconButton(
                      onPressed: (){}, 
                      icon: const Icon(
                        Icons.access_time_outlined,
                        
                        color: Colors.grey,)),
                    
                    
                    ),),
                    const SizedBox(width: 12.0,),
                     Expanded(child: MyInputField(
                    title: "Start Date",
                    hint: _startTime,
                    widget: IconButton(
                      onPressed: (){}, 
                      icon: const Icon(
                        Icons.access_time_outlined,
                        
                        color: Colors.grey,)),
                    
                    
                    ),)
                
                ],
              )

              
            ],
          ),
        ),

      ),
    );
  }

    _appBar(BuildContext context){
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
     leading:GestureDetector(
      onTap: () {
        Get.back();
      },
      child: Icon(
        Icons.arrow_back_sharp,
        size: 20,
        color: Get.isDarkMode? Colors.white:Colors.black,


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

 _getDateFromUser() async{
  DateTime? _pickerDate =await showDatePicker(
    context: context, 
    initialDate: DateTime.now(),
     firstDate: DateTime(2022), 
     lastDate: DateTime(2050)
     );
     if (_pickerDate!=null) {
      setState(() {
        _selectedDate =_pickerDate;
      });  
     } else {
      print("Something is wrong"); 
       
     }
 }

}