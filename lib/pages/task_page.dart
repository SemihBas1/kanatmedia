import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:kanatmedia/model/task_model.dart';
import 'package:kanatmedia/model/user_model.dart';
import 'package:kanatmedia/utils/app_string.dart';

class TaskPage extends StatefulWidget {
  final User user;
  const TaskPage({super.key, required this.user});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  List<Task> tasks = [];

  @override
  void initState() async {
    super.initState();
    final response = await http.get(Uri.parse(
        '${AppString().apiLink}/gorev?name=${widget.user.name}&surname=${widget.user.surname}'));
    final data = jsonDecode(response.body);
    final taskList = data.map((taskData) => Task.fromJson(taskData)).toList();

    setState(() {
      tasks = taskList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Görevler'),
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return ListTile(
            title: Text(task.projectType),
            subtitle: Text(task.projectName),
          );
        },
      ),
    );
  }
}
