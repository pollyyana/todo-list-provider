import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:todo_list/app/core/ui/theme_extension.dart';
import 'package:todo_list/app/models/task_filter_enum.dart';
import 'package:todo_list/app/models/total_tasks_model.dart';

class TodoCardFilter extends StatelessWidget {
  final String label;
  final TaskFilterEnum taskFilterEnum;
  final TotalTasksModel? totalTasksModel;
  final bool selected;

  const TodoCardFilter({
    super.key,
    required this.label,
    required this.taskFilterEnum,
    required this.selected,
    this.totalTasksModel,
  });

  double _getPercentfinish() {
    final total = totalTasksModel?.totalTasks ?? 0.0;
    final totalTasksFinish = totalTasksModel?.totalTasksFinish ?? 0.1;

    //VERIFICARE

    if (total == 0) {
      return 0;
    }

    final percent = (totalTasksFinish * 100) / total;
    // divide por 100 para retornar 0.1 por exemp
    return percent / 100;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 120,
        maxWidth: 150,
      ),
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: selected ? context.primaryColor : Colors.white,
          border: Border.all(
            width: 1,
            color: Colors.grey.withOpacity(.8),
          ),
          borderRadius: BorderRadius.circular(30)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            //total totaltaskmodel senao? for nulo totalTasl senao ?? valor 0
            '${totalTasksModel?.totalTasks ?? 0} TASKS',
            style: context.titleStyle.copyWith(
              fontSize: 10,
              color: selected ? Colors.white : Colors.grey,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: selected ? Colors.white : Colors.black,
            ),
          ),
          //implementar uma animacao implicita Tween
          TweenAnimationBuilder<double>(
            tween: Tween(
              begin: 0.0,
              end: _getPercentfinish(),
            ),
            duration: const Duration(seconds: 1),
            builder: (context, value, child) {
              return LinearProgressIndicator(
                backgroundColor:
                    selected ? context.primaryColorLight : Colors.grey.shade300,
                valueColor:  AlwaysStoppedAnimation<Color>(
                 selected ? Colors.white : context.primaryColor,
                ),
                value: value,
              );
            },
          ),
        ],
      ),
    );
  }
}
