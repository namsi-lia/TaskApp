import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:taskapp/controllers/task_controller.dart';
import 'package:taskapp/models/Task.dart';
import 'package:taskapp/ui/theme.dart';
import 'package:taskapp/ui/widgets/button.dart';
import 'package:taskapp/ui/widgets/input_field.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key?key}):super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController _taskController =Get.put(TaskController());
   final TextEditingController _titleController =TextEditingController();
   final TextEditingController _noteController =TextEditingController();
  DateTime _selectedDate=DateTime.now();
  String _endTime="9:30PM";
  String _startTime= DateFormat("hh:mm a").format(DateTime.now()).toString();
  int _selectedRemind =5;
  List<int> remindList=[
    5,10,15,20
  ];
   String  _selectedRepeat="None";
  List<String> repeatList=[
    "None","Daily","Weekly","Monthly"
  ];
  int _selectedColor=0;
  
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
               MyInputField(title: "Title", hint: "Enter your Tittle",controller: _titleController,),
               MyInputField(title: "Note", hint: "Enter your note",controller: _noteController,),
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
                    title: "Start Time",
                    hint: _startTime,
                    widget: IconButton(
                      onPressed: (){
                        _getTimeFromUser(isStartTime: true);
                      }, 
                      icon: const Icon(
                        Icons.access_time_outlined,
                        
                        color: Colors.grey,)),
                    
                    
                    ),),
                    const SizedBox(width: 12.0,),
                     Expanded(child: MyInputField(
                    title: "End Time",
                    hint: _endTime,
                    widget: IconButton(
                      onPressed: (){
                        _getTimeFromUser(isStartTime: false);
                      }, 
                      icon: const Icon(
                        Icons.access_time_outlined,
                        
                        color: Colors.grey,)),
                    
                    
                    ),)
                
                ],
              ),

              MyInputField(title: "Remind", hint:"$_selectedRemind minutes",
              widget: DropdownButton(
                icon:const Icon(Icons.keyboard_arrow_down,
                color: Colors.grey,
                ),
                iconSize: 32,
                elevation: 4,
                style: subTitleStyle,
                underline: Container(height: 0,),
                onChanged: (String? newvalue) {  
                  setState(() {
                    _selectedRemind=int.parse(newvalue!);
                  });
                },
                items: remindList.map<DropdownMenuItem<String>>((int value){
                  return DropdownMenuItem<String>(
                    value: value.toString(),
                    child: Text(value.toString()));
                },
              ).toList(), 
              
              
              )
          ),
            
              MyInputField(title: "Repeat", hint:"$_selectedRepeat",
              widget: DropdownButton(
                icon:const Icon(Icons.keyboard_arrow_down,
                color: Colors.grey,
                ),
                iconSize: 32,
                elevation: 4,
                style: subTitleStyle,
                underline: Container(height: 0,),
                onChanged: (String? newvalue) {  
                  setState(() {
                    _selectedRepeat=newvalue!;
                  });
                },
                items: repeatList.map<DropdownMenuItem<String>>((String?  value){
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value!, style: const TextStyle(color:Colors.grey ),));
                },
              ).toList(), 
              
              
              )
          ),         
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _colorPallete(),
                  MyButton(label: "Create Task", onTap: () =>_validateData())
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

_validateData(){
  if (_titleController.text.isNotEmpty&&_noteController.text.isNotEmpty) {
    //add data to database
    _addTaskToDb();
    Get.back();
    
  }else if(_titleController.text.isEmpty ||_noteController.text.isEmpty){
    Get.snackbar("Required", "All fields should be filled",
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.white,
    icon: Icon(Icons.warning_amber_outlined,
     color: Colors.red,
    )
    
    );

  }  
}

_colorPallete(){
  return  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Color",
                      style: titleStyle,
                      ),
                      const SizedBox(height: 8.0,),
                      Wrap(
                        children: List<Widget>.generate
                        (3,
                         (int index){
                          return GestureDetector(
                            onTap: (){
                                setState(() {
                                   _selectedColor=index;
                                });
                            },
                            child: Padding(padding: const EdgeInsets.only(right: 8.0),
                            child: CircleAvatar(
                              radius: 14,
                              backgroundColor:index==0?primaryClr:index==1?indigoish:purplish,
                              child: _selectedColor==index?Icon(Icons.done,
                              color: Color.fromARGB(255, 248, 133, 133),
                              size: 15,
                              
                              ):Container(),                            
                            ),
                            ),
                          );
                         }
                        ),
                      )
                    ],
                  );

}

_addTaskToDb() async {
 int value=await  _taskController.addTask(
    task: Task(
    note:_noteController.text,
    title: _titleController.text,
    date: DateFormat.yMd().format(_selectedDate),
    startTime: _startTime,
    endTime: _endTime,
    remind: _selectedRemind,
    repeat: _selectedRepeat,
    isCompleted: 0,
    color: _selectedColor,
  )


  );
  print("My id is"+"$value");
 
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

 _getTimeFromUser({required bool isStartTime}) async {
 var pickedTime=await  _showTimePicker();
 String _formatedTime =pickedTime.format(context);
 if(pickedTime ==null){
  print("Time cancelled");

 }else if(isStartTime==true){
  setState(() {
      _startTime=_formatedTime;
  });

 }else if(isStartTime==false){
    setState(() {
      _endTime =_formatedTime;

    });
  
 }

 }

 _showTimePicker(){
  return showTimePicker(
    initialEntryMode: TimePickerEntryMode.input,
    context: context,
   initialTime: TimeOfDay(
    hour: int.parse(_startTime.split(":")[0]),
     minute: int.parse(_startTime.split(":")[1].split("")[0])));
 }

}