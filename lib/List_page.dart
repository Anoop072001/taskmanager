import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class List_page extends StatefulWidget {
  const List_page({Key key}) : super(key: key);

  @override
  _List_pageState createState() => _List_pageState();
}

class _List_pageState extends State<List_page> {
  Box<String> taskBox;

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
              "Tasks",
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
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                      subtitle: Text(descp,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                      trailing: IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.redAccent,
                          ),
                          onPressed: () {
                            final key = title;
                            taskBox.delete(key);
                          }),
                    );
                  },
                  separatorBuilder: (_, index) => Divider(
                        color: Colors.grey[600],
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
                return Dialog(
                  child: Container(
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
                          child: Text("submit"),
                          onPressed: () {
                            final key = _taskController.text;
                            final value = _descpController.text;

                            taskBox.put(key, value);
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
