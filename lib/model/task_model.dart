import 'package:hive/hive.dart';

@HiveType()
class TaskModel {
  @HiveField(0)
  final String task_name;
  @HiveField(1)
  final String task_descp;

  TaskModel({this.task_name, this.task_descp});
}
