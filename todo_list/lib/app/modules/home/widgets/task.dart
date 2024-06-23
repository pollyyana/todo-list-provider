import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/app/models/task_model.dart';

class Task extends StatelessWidget {
  final TaskModel model;
  final dateFormat =DateFormat('dd/MM/y');
   Task({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(color: Colors.grey),
        ],
      ),
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        contentPadding: const EdgeInsets.all(8),
        leading: Checkbox(
          value: model.finished,
          onChanged: (value) {},
        ),
        title:  Text(
          model.description,
          // 'Descrição da TASK',
          style:  TextStyle(
            decoration: model.finished ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle:  Text(
          dateFormat.format(model.dateTime),
          // '20/12/2023',
          style:  TextStyle(
            decoration: model.finished ? TextDecoration.lineThrough : null,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(width: 1)
        ),
      ),
    );
  }
}
