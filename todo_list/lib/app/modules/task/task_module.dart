// import 'package:path/path.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/app/core/modules/todo_list_module.dart';
import 'package:todo_list/app/modules/task/task_create_controller.dart';
import 'package:todo_list/app/modules/task/task_create_page.dart';
import 'package:todo_list/app/repositories/tasks/task_repository.dart';
import 'package:todo_list/app/repositories/tasks/task_repository_impl.dart';
import 'package:todo_list/app/services/tasks/tasks_service.dart';
import 'package:todo_list/app/services/tasks/tasks_service_impl.dart';

class TaskModule extends TodoListModule {
  TaskModule()
      : super(
            //configuracao de bindings
            bindings: [
              Provider<TaskRepository>(
                  create: (context) => TaskRepositoryImpl(
                      sqliteConnectionFactory: context.read())),
              Provider<TasksService>(
                  create: (context) =>
                      TasksServiceImpl(taskRepository: context.read())),
              ChangeNotifierProvider(
                  create: (context) =>
                      TaskCreateController(tasksService: context.read()))
            ],
            //configuracao de rota
            routers: {
              '/task/create': (context) => TaskCreatePage(
                    controller: context.read(),
                  )
            });
}
