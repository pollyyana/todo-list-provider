import 'package:todo_list/app/repositories/tasks/tasks_repository.dart';

import './tasks_service.dart';

class TasksServiceImpl implements TasksService {
  
  // contrutor nomeado
  final TasksRepository _tasksRepository;

  // encapsulamento
  TasksServiceImpl ({
    required TasksRepository tasksRepository,
  }) : _tasksRepository = tasksRepository;

  // implentacao metodo
  // proxy para o Repository
  @override
  Future<void> save(DateTime date, String description) =>
   _tasksRepository.save(date, description);


}
