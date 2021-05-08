import 'dart:async';
import 'dart:io';
import 'package:dexiheri/app/home/calendar/detail_event.dart';
import 'package:dexiheri/app/models/event.dart';
import 'package:dexiheri/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dexiheri/app/home/calendar/new_event.dart';
import 'package:dexiheri/app/models/job.dart';
import 'package:dexiheri/app/module/module.dart';
import 'package:dexiheri/global.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';


class CalendarPage extends StatefulWidget {
  CalendarPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  CalendarPageState createState() => CalendarPageState();
}

class CalendarPageState extends State<CalendarPage> {

  List<String> months = [];
  String selected_month = "";
  String currentDateTime = "";
  String selected_eventDate = "";
  List<String> year_list = [];
  String selected_year = "";
  int month = 01;
  int year = 0;
  List<String> category_list = [];
  List<Event> event_list = [];
  String selected_category = "ΙΣΤΟΡΙΚΟ ΕΛΕΓΧΩΝ";
  bool job_checking = false;
  bool event_checking = false;
  List<Job> job_list = [];
  Job selected_job;
  String image_file; 
  DateRangePickerController _datePickerController = DateRangePickerController ();
  List<DateTime> init_dateTime = [];


  @override
  void initState() {
    super.initState();
    initMonthList();
    initYearList();
    initCategoryList();
    // _datePickerController.displayDate = DateTime(year, DateTime.now().month);
    DateTime today = DateTime.now();
    currentDateTime = today.day.toString() + "/" + today.month.toString() + "/" + today.year.toString() + " - " + today.hour.toString() + ":" + today.minute.toString();
    job_checking = true;
    event_checking = true;
    getJobList();
    
  }
  
  Future<void> getJobList() {
     LoadsModule.getJobs().then((value){
      setState(() {
        if(value.length > 0){
          for(int i = 0; i < value.length; i++){
            print("-----${value[i].nameKatastimatos}");
            job_list.add(value[i]);
          }
          selected_job = job_list[0];
        }
        job_checking = false;
        LoadsModule.getEvents().then((events){
          setState(() {
            if(events.length > 0) {
              getEventList();
              if(event_list.length > 0){
                init_dateTime.clear();
                List<String> event_date = [];
                for(int i = 0; i < event_list.length; i++){
                  event_date = event_list[i].date.split('/');
                  init_dateTime.add(DateTime(int.parse(event_date[2]), int.parse(event_date[1]), int.parse(event_date[0])));
                }
                _datePickerController = DateRangePickerController ();
                _datePickerController.displayDate = DateTime(year, month);
                turnOnNotificationService();
              }
            }
            event_checking = false;
            
          });
        });
      });
    });
    
  }
  void turnOnNotificationService() {

    DateTime now = DateTime.now();
    DateTime currentDate = DateTime.utc(now.year, now.month, now.day);
    for(int i = 0; i < event_list.length; i++) {
      String event_date = event_list[i].date;
      int day = int.parse(event_date.split('/')[0]);
      int month = int.parse(event_date.split('/')[1]);
      int year = int.parse(event_date.split('/')[2]);
      DateTime date = DateTime.utc(year, month, day);
      int different_hours = date.difference(currentDate).inHours;
      if(different_hours >= 0 && different_hours <= 24){
        NotificationService.showNotification(i, event_list[i].title, event_list[i].date);
          
      }
      
    }
  }
  
  @override
  void dispose() {
    super.dispose();
  }

  void initCategoryList(){
    category_list.add("ΙΣΤΟΡΙΚΟ ΕΛΕΓΧΩΝ");
    category_list.add("ΗΜΕΡΟΜΗΝΙΕΣ ΔΙΚΑΣΙΜΩΝ");
    category_list.add("ΗΜΕΡΟΜΗΝΙΕΣ ΛΗΞΗΣ ΑΔΕΙΩΝ");
    selected_category = category_list[0];
  }

  void initMonthList() {
    months.add('Ιανουάριος');
    months.add('Φεβρουάριος');
    months.add('Μάρτιος');
    months.add('Απρίλιος');
    months.add('Μάιος');
    months.add('Ιούνιος');
    months.add('Ιούλιος');
    months.add('Αύγουστος');
    months.add('Σεπτέμβριος');
    months.add('Οκτώμβριος');
    months.add('Νοέμβριος');
    months.add('Δεκέμβριος');
    for(int i = 0; i < months.length; i++){
      if(i == DateTime.now().month - 1){
        selected_month = months[i];
        month = DateTime.now().month;
        break;
      }
    }
  }
  void initYearList() {
    year_list.add("2018");
    year_list.add("2019");
    year_list.add("2020");
    year_list.add("2021");
    year_list.add("2022");
    year_list.add("2023");
    year_list.add("2024");
    selected_year = year_list[3];
    year = DateTime.now().year;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(currentDateTime, style: TextStyle(color: Colors.black, fontSize: 16)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          DropdownButton(
            focusColor: Colors.white,
            dropdownColor: Colors.white,
            value: selected_year,
            onChanged: (newValue) {
              setState(() {
                selected_year = newValue;
                year = int.parse(newValue);
                getEventList();
                _datePickerController = DateRangePickerController ();
                _datePickerController.displayDate = DateTime(year, month);
              });
            },
            items: year_list.map((year) {
              return DropdownMenuItem(
                child: new Text(year, style: TextStyle(color: Colors.blue),),
                value: year,
              );
            }).toList(), 
          )
        ],
        leading: new IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.blue,
          ),
          onPressed: () {}),
          
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      for(var month in months)
                        getButton(month),
                        
                    ]
                  )
                ),
                job_checking ? CircularProgressIndicator() :
                  job_list.length > 0 ? setEventPage() : Container(),
                    
              ],
            ),
          )
        )
      )
    );
  }

  Widget getButton(String m_month) {
    return Row(
      children:[
        Padding(padding: EdgeInsets.only(left: 10),),
        Align(
          alignment: Alignment.topLeft,
          child: GestureDetector(
            onTap: () {
              setState(() {
                selected_month = m_month;
                setCalendarMonth(m_month);
                getEventList();
                _datePickerController = DateRangePickerController ();
                _datePickerController.displayDate = DateTime(year, month);
              });
            },
            child: Container(
              width: selected_month == m_month ? 140 : 100,
              height: selected_month == m_month ? 40 : 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5)
                ),
                color: selected_month == m_month ? Colors.blue : Colors.grey[200],
              ),
              child: new Align(alignment:Alignment.center, child:Text(m_month, style: TextStyle(color: selected_month == m_month ? Colors.white : Colors.grey, fontSize: selected_month == m_month ? 18 : 15),))
            )
          )
        )
      ]
    );
  }
  void setCalendarMonth(String m_month){
    if(m_month == "January"){
      month = 01;
    }
    if(m_month == "Febrary"){
      month = 02;
    }
    if(m_month == "March"){
      month = 03;
    }
    if(m_month == "April"){
      month = 04;
    }
    if(m_month == "May"){
      month = 05;
    }
    if(m_month == "June"){
      month = 06;
    }
    if(m_month == "July"){
      month = 07;
    }
    if(m_month == "August"){
      month = 08;
    }
    if(m_month == "September"){
      month = 09;
    }
    if(m_month == "Octorber"){
      month = 10;
    }
    if(m_month == "November"){
      month = 11;
    }
    if(m_month == "December"){
      month = 12;
    }
  }

  Widget setEventPage() {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.grey[200],
      padding: EdgeInsets.only(top: 10),
      child: Column(
        children:[
          Container(
            child: DropdownButton(
              focusColor: Colors.white,
              dropdownColor: Colors.white,
              value: selected_job,
              onChanged: (newValue) {
                setState(() {
                  selected_job = newValue;
                  getEventList();
                  init_dateTime.clear();
                  if(event_list.length > 0){
                    List<String> event_date = [];
                    for(int i = 0; i < event_list.length; i++){
                      event_date = event_list[i].date.split('/');
                      init_dateTime.add(DateTime(int.parse(event_date[2]), int.parse(event_date[1]), int.parse(event_date[0])));
                    }
                  }
                  _datePickerController = DateRangePickerController ();
                  _datePickerController.displayDate = DateTime(year, month);
                });
              },
              items: job_list.map((job) {
                return DropdownMenuItem(
                  child: new Text(job.nameKatastimatos, style: TextStyle(color: Colors.blue)),
                  value: job,
                );
              }).toList(), 
            )
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for(var category in category_list)
                        getCategoryButton(category),
                    ]
                  )
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                getCalendarPage(),
                
                Padding(padding: EdgeInsets.only(top: 10)),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(10.0),
                  child: RaisedButton(
                    onPressed: () => {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => EventPage(
                        job: selected_job.nameKatastimatos,
                        category: selected_category,
                      )))
                    },
                    color: Colors.blue,
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Icon(Icons.calendar_today_outlined, color: Colors.white, size: 32),
                        Expanded(
                          child: Container(
                            child: new Align(alignment:Alignment.center, child:Text('Εισαγωγή νέου ελέγχου', style: TextStyle(color: Colors.white, fontSize: 24),))
                          )
                        )
                      ],
                    ),
                  )
                ),
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: GestureDetector(
                    onTap: () { getImage();},
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: Colors.white,
                        image: DecorationImage(
                          image: image_file == null ? AssetImage('assets/images/noImage.jpg') : FileImage(new File(image_file)),
                          fit: BoxFit.fill
                        ),
                      ),
                    )
                  )
                ),
                // Padding(padding: EdgeInsets.only(top: 10)),
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  margin: EdgeInsets.only(bottom: Platform.isAndroid ? kBottomNavigationBarHeight : 60),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      new IconButton(
                      icon: Icon(
                        Icons.email_outlined,
                        color: Colors.black,
                        size: 36,
                      ),
                      onPressed: () {}),
                      new IconButton(
                      icon: Icon(
                        Icons.print_sharp,
                        color: Colors.black,
                        size: 36,
                      ),
                      onPressed: () {}),
                      new IconButton(
                      icon: Icon(
                        Icons.mark_email_read_sharp,
                        color: Colors.black,
                        size: 36,
                      ),
                      onPressed: () {}),
                      new IconButton(
                      icon: Icon(
                        Icons.share,
                        color: Colors.black,
                        size: 36,
                      ),
                      onPressed: () {}),
                    ],
                  ),
                )
              ],
            )
          )
        ]
      ),
    );
  }

  void getEventList(){
    event_list.clear();
    if(LoadsModule.event_list.length > 0){
      for(int i = 0; i < LoadsModule.event_list.length; i++){
        if(LoadsModule.event_list[i].id == selected_job.nameKatastimatos && LoadsModule.event_list[i].category == selected_category){
          event_list.add(LoadsModule.event_list[i]);
        }
      }
    }
  }

  Widget getCategoryButton(String category_name) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selected_category = category_name;
          getEventList();
          init_dateTime.clear();
          if(event_list.length > 0){
            List<String> event_date = [];
            for(int i = 0; i < event_list.length; i++){
              event_date = event_list[i].date.split('/');
              init_dateTime.add(DateTime(int.parse(event_date[2]), int.parse(event_date[1]), int.parse(event_date[0])));
            }
          }
          _datePickerController = DateRangePickerController ();
          _datePickerController.displayDate = DateTime(year, month);
        });
      },
      child: Container(
        padding: EdgeInsets.all(5.0),
        width: 130,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15)
          ),
          border: Border.all(color: Colors.grey),
          color: selected_category == category_name ? Colors.blue : Colors.white,
        ),
        child: new Align(alignment:Alignment.center, child:Text(category_name, style: TextStyle(color: selected_category == category_name ? Colors.white : Colors.black, fontSize: 15),))
      )
    );
  }

  Widget getCalendarPage() {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: SfDateRangePicker(
        view: DateRangePickerView.month,
        selectionMode: DateRangePickerSelectionMode.multiple,
        controller: _datePickerController,
        onSelectionChanged: onSelectionChanged,
        monthViewSettings: DateRangePickerMonthViewSettings(
          specialDates: init_dateTime,
          
        ),
        monthCellStyle: DateRangePickerMonthCellStyle(
          specialDatesTextStyle: TextStyle(color: Colors.white),
          specialDatesDecoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blue),
        ),
      ),
    );
  }
  void onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
      if(args.value is List<DateTime>){
        List<DateTime> date = args.value;
        Event event;
        print("----select args:${date.last}");
        if(init_dateTime.contains(date.last)){
          String event_date = date.last.day.toString() + "/" + date.last.month.toString() + "/" + date.last.year.toString();
          for(int i = 0; i < event_list.length; i++){
            if(event_date == event_list[i].date){
              event = event_list[i];
              break;
            }
          }
          Navigator.push(context, MaterialPageRoute(builder: (context) => DetailEvent(
            event: event,
          )));
          
        }
      }
    
    
  }

  Future<void> getImage() async {
    PickedFile pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      image_file = pickedFile.path;
    });
    
  }

}