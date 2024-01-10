// import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/app/core/modules/todo_list_module.dart';
import 'package:todo_list/app/modules/task/task_create_controller.dart';
import 'package:todo_list/app/modules/task/task_create_page.dart';

class TaskModule extends TodoListModule {
  TaskModule()
      : super(
            //configuracao de bindings
            bindings: [
              ChangeNotifierProvider(
                  create: (context) => TaskCreateController())
            ],
            //configuracao de rota
            routers: {
              '/task/create': (context) => TaskCreatePage(
                    controller: context.read(),
                  )
            });
}
