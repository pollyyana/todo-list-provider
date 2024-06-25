import 'package:flutter/material.dart';
import 'package:todo_list/app/core/notifier/defaul_change_notifier.dart';
import 'package:todo_list/app/models/task_filter_enum.dart';
import 'package:todo_list/app/models/task_model.dart';
import 'package:todo_list/app/models/total_tasks_model.dart';
import 'package:todo_list/app/models/week_task_model.dart';
import 'package:todo_list/app/services/tasks/tasks_service.dart';

class HomeController extends DefaulChangeNotifier {
  final TasksService _tasksService;
  var filterSelected = TaskFilterEnum.today;
  TotalTasksModel? todayTotalTasks;
  TotalTasksModel? tomorrowTotalTasks;
  TotalTasksModel? weekTotalTasks;
  List<TaskModel> allTasks = [];
  List<TaskModel> filteredTasks = [];
  DateTime? initialDateofWeek;
  DateTime? selectedDay;
// mostrar tarefa finalizada
  bool showFinishingTask = false;

  HomeController({required TasksService tasksService})
      : _tasksService = tasksService;

  Future<void> loadTotalTasks() async {
    final allTasks = await Future.wait([
      _tasksService.getToday(),
      _tasksService.getTomorrow(),
      _tasksService.getWeek(),
    ]);

    final todayTasks = allTasks[0] as List<TaskModel>;
    final tomorrowTasks = allTasks[1] as List<TaskModel>;
    final weekTasks = allTasks[2] as WeekTaskModel;

    //populando
    todayTotalTasks = TotalTasksModel(
      totalTasks: todayTasks.length,
      totalTasksFinish: todayTasks.where((task) => task.finished).length,
    );

    todayTotalTasks = TotalTasksModel(
      totalTasks: tomorrowTasks.length,
      totalTasksFinish: tomorrowTasks.where((task) => task.finished).length,
    );

    todayTotalTasks = TotalTasksModel(
      totalTasks: weekTasks.tasks.length,
      totalTasksFinish: weekTasks.tasks.where((task) => task.finished).length,
    );
    notifyListeners();
  }

  Future<void> findTasks({required TaskFilterEnum filter}) async {
    //trocar filtro selecionado
    filterSelected = filter;
    showLoading();
    notifyListeners();
    List<TaskModel> tasks;

    switch (filter) {
      case TaskFilterEnum.today:
        tasks = await _tasksService.getToday();
        break;
      case TaskFilterEnum.tomorrow:
        tasks = await _tasksService.getTomorrow();
        break;
      case TaskFilterEnum.week:
        final weekModel = await _tasksService.getWeek();
        initialDateofWeek = weekModel.startDate;
        tasks = weekModel.tasks;
        break;
    }
    //populou os DADOS
    filteredTasks = tasks;
    allTasks = tasks;
    // condicional
    if (filter == TaskFilterEnum.week) {
      if (selectedDay != null) {
        return filterByday(selectedDay!);
      } else if (initialDateofWeek != null) {
        filterByday(initialDateofWeek!);
      }
    } else {
      selectedDay = null;
    }

    if (!showFinishingTask) {
      filteredTasks = filteredTasks.where((task)=> !task.finished).toList();
    }

    hideLoading();
    notifyListeners();
  }

  void filterByday(DateTime date) {
    // selectedDay = date;
    // filteredTasks = allTasks.where((task) {
    //   return task.dateTime == date;
    // }).toList();
    filteredTasks = allTasks
        .where(
          (task) => DateUtils.isSameDay(task.dateTime, date),
        )
        .toList();
    notifyListeners();
  }

  Future<void> refreshPage() async {
    await findTasks(filter: filterSelected);
    await loadTotalTasks();
    notifyListeners();
  }

  Future<void> checkOrUnCheckTask(TaskModel task) async {
    showLoadingAndResetState();
    notifyListeners();
    final taskUpdate = task.copyWith(finished: !task.finished);
    await _tasksService.checkOrUnCheckTask(taskUpdate);
    hideLoading();
    refreshPage();
  }

  // mostrar ou ocultar tarefa de finalização
  void showOrHideFinishingTask() {
    showFinishingTask = !showFinishingTask;
    refreshPage();
  }
}
