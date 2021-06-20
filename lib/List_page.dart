import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskmanager/Gcalendar.dart';

class List_page extends StatefulWidget {
  const List_page({Key key}) : super(key: key);

  @override
  _List_pageState createState() => _List_pageState();
}

class _List_pageState extends State<List_page> {
  Box<String> taskBox;
  CalendarClient calendarClient = CalendarClient();
  DateTime endTime = DateTime.now().add(Duration(days: 1));
  DateTime startTime = DateTime.now();
  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _descpController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    taskBox = Hive.box<String>("Task");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.redAccent,
          title: Center(
            child: Text(
              "TaskMaster",
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )),
      body: Column(
        children: [
          Expanded(
              child: ValueListenableBuilder(
            valueListenable: taskBox.listenable(),
            builder: (context, Box<String> tasks, _) {
              return ListView.separated(
                  itemBuilder: (context, index) {
                    final title = tasks.keys.toList()[index];
                    final descp = tasks.get(title);

                    return ListTile(
                      title: Text(
                        title,
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30),
                        ),
                      ),
                      subtitle: Text(
                        descp,
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 18)),
                      ),
                      // trailing: IconButton(
                      //     icon: Icon(
                      //       Icons.alarm,
                      //       color: Colors.redAccent,
                      //     ),
                      //     onPressed: () {
                      //       DatePicker.showDatePicker(context,
                      //           showTitleActions: true,
                      //           minTime: DateTime(2021, 1, 1),
                      //           maxTime: DateTime(2030, 6, 7),
                      //           onChanged: (date) {
                      //         print('change $date');
                      //       }, onConfirm: (date) {
                      //         setState(() {
                      //           this.startTime = date;
                      //           calendarClient.insert(
                      //               descp, startTime, endTime);
                      //         });
                      //       },
                      //           currentTime: DateTime.now(),
                      //           locale: LocaleType.en);
                      //     }),

                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (_) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(32.0))),
                                content: Container(
                                  width: 260,
                                  padding: EdgeInsets.all(32),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        title,
                                        style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30,
                                        )),
                                      ),
                                      SizedBox(height: 16),
                                      Text(
                                        descp,
                                        style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        )),
                                      ),
                                      SizedBox(height: 16),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          IconButton(
                                              icon: Icon(
                                                Icons.delete,
                                                color: Colors.redAccent,
                                              ),
                                              onPressed: () {
                                                final key = title;
                                                taskBox.delete(key);
                                                Navigator.pop(context);
                                              }),
                                          SizedBox(width: 15),
                                          IconButton(
                                              icon: Icon(
                                                Icons.alarm,
                                                color: Colors.redAccent,
                                              ),
                                              onPressed: () {
                                                DatePicker.showDatePicker(
                                                    context,
                                                    showTitleActions: true,
                                                    minTime:
                                                        DateTime(2021, 1, 1),
                                                    maxTime:
                                                        DateTime(2030, 6, 7),
                                                    onChanged: (date) {
                                                  print('change $date');
                                                }, onConfirm: (date) {
                                                  setState(() {
                                                    this.startTime = date;
                                                    calendarClient.insert(descp,
                                                        startTime, endTime);
                                                  });
                                                  Navigator.pop(context);
                                                },
                                                    currentTime: DateTime.now(),
                                                    locale: LocaleType.en);
                                              }),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                    );
                  },
                  separatorBuilder: (_, index) => Divider(
                        color: Colors.grey[800],
                      ),
                  itemCount: tasks.keys.toList().length);
            },
          )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.redAccent,
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(32.0))),
                  content: Container(
                      width: 260,
                      padding: EdgeInsets.all(32),
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                        TextField(
                          decoration: InputDecoration(labelText: "Task"),
                          controller: _taskController,
                        ),
                        SizedBox(height: 16),
                        TextField(
                          decoration: InputDecoration(labelText: "Description"),
                          controller: _descpController,
                        ),
                        SizedBox(height: 16),
                        TextButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              Colors.redAccent,
                            ),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(13.0),
                              ),
                            ),
                          ),
                          child: Text(
                            "ADD",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          onPressed: () {
                            final key = _taskController.text;
                            final value = _descpController.text;

                            taskBox.put(key, value);
                            _taskController.clear();
                            _descpController.clear();
                            Navigator.pop(context);
                          },
                        )
                      ])),
                );
              },
            );
          }),
    );
  }
}
