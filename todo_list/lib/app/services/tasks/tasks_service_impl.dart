import 'package:todo_list/app/models/task_model.dart';
import 'package:todo_list/app/models/week_task_model.dart';
import 'package:todo_list/app/repositories/tasks/tasks_repository.dart';
import 'package:todo_list/app/services/tasks/tasks_service.dart';

class TasksServiceImpl implements TasksService {
  // contrutor nomeado
  final TasksRepository _tasksRepository;

  // encapsulamento
  TasksServiceImpl({
    required TasksRepository tasksRepository,
  }) : _tasksRepository = tasksRepository;

  // implentacao metodo
  // proxy para o Repository
  @override
  Future<void> save(DateTime date, String description) =>
      _tasksRepository.save(date, description);

  //regras de negocio na camada de servico
  @override
  Future<List<TaskModel>> getToday() {
    return _tasksRepository.findByPeriod(DateTime.now(), DateTime.now());
  }

  @override
  Future<List<TaskModel>> getTomorrow() {
    var tomorrowDate = DateTime.now().add(const Duration(days: 1));
    return _tasksRepository.findByPeriod(tomorrowDate, tomorrowDate);
  }
  //logica

  @override
  Future<WeekTaskModel> getWeek() async {
    final today = DateTime.now();
    var startFilter = DateTime(today.year, today.month, today.day, 0, 0, 0);
    DateTime endFilter;

    if (startFilter.weekday != DateTime.monday) {
      //subtrai para chegar na segunda- feira
      startFilter =
          startFilter.subtract(Duration(days: (startFilter.weekday - 1)));
    }
    //adicionar 7 dias na segunda feira
    endFilter = startFilter.add(const Duration(days: 7));
    final tasks = await _tasksRepository.findByPeriod(startFilter, endFilter);
    return WeekTaskModel(
        startDate: startFilter, endDate: endFilter, tasks: tasks);
  }
  
  @override
  Future<void> checkOrUnCheckTask(TaskModel task) => _tasksRepository.checkOrUnCheckTask(task);
}
