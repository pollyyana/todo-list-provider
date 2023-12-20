import 'package:flutter/material.dart';
import 'package:todo_list/app/core/ui/theme_extension.dart';
import 'package:todo_list/app/modules/home/widgets/task.dart';

class HomeTask extends StatelessWidget {
  const HomeTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            'TASK\'S DE HOJE',
            style: context.titleStyle,
          ),
          const Column(
            children: [
              Task(),
              Task(),
              Task(),
              Task(),
              Task(),
              Task(),
              Task(),
              Task(),
            ],
          )
        ],
      ),
    );
  }
}
