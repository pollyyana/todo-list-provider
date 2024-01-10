import 'package:todo_list/app/repositories/tasks/task_repository.dart';

import './tasks_service.dart';

class TasksServiceImpl implements TasksService {
  // contrutor nomeado

  final TaskRepository _taskRepository;

  // encapsulamento
  TasksServiceImpl ({
    required TaskRepository taskRepository,
  }) : _taskRepository = taskRepository;

  // implentacao metodo

  @override
  Future<void> save(DateTime date, String description) => _taskRepository.save(date, description);


}
