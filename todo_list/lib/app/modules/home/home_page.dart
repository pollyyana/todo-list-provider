import 'package:flutter/material.dart';
import 'package:todo_list/app/core/ui/theme_extension.dart';
import 'package:todo_list/app/core/widget/todo_list_icons.dart';
import 'package:todo_list/app/models/task_filter_enum.dart';
import 'package:todo_list/app/modules/home/home_controller.dart';
import 'package:todo_list/app/modules/home/widgets/home_drawer.dart';
import 'package:todo_list/app/modules/home/widgets/home_filters.dart';
import 'package:todo_list/app/modules/home/widgets/home_header.dart';
import 'package:todo_list/app/modules/home/widgets/home_task.dart';
import 'package:todo_list/app/modules/home/widgets/home_week_filter.dart';
import 'package:todo_list/app/modules/task/task_module.dart';

import '../../core/notifier/defaul_listener_notifier.dart';

class HomePage extends StatefulWidget {
  final HomeController _homeController;

  const HomePage({super.key, required HomeController homeController})
      : _homeController = homeController;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    DefaulListenerNotifier(changeNotifier: widget._homeController).listener(
      context: context,
      successCallback: (notifier, listenerInstance) {
        listenerInstance.dispose();
      },
    );
    WidgetsBinding.instance?.addPostFrameCallback(
      (timeStamp) {
        widget._homeController.loadTotalTasks();
        widget._homeController.findTasks(filter: TaskFilterEnum.today);
      },
    );
  }

  Future<void> _goToCreateTask(BuildContext context) async {
    // Navigator.of(context).pushNamed('/task/create');
    // MaterialPageRoute(
    //   builder: (_) => TaskModule().getPage('/task/create', context),
    // ),
    await Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 400),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          // substituicao do animation por curved animation
          animation =
              CurvedAnimation(parent: animation, curve: Curves.easeInQuad);
          return ScaleTransition(
            scale: animation,
            alignment: Alignment.bottomRight,
            //vai adicionar o bottom child
            child: child,
          );
        },
        pageBuilder: (context, animation, secondaryAnimation) {
          return TaskModule().getPage('/task/create', context);
        },
      ),
    );
    widget._homeController.refreshPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: context.primaryColor),
        backgroundColor: const Color(0xFFFAFBFE),
        elevation: 0,
        actions: [
          PopupMenuButton(
            icon: const Icon(TodoListIcons.filter),
            onSelected: (value) {
              widget._homeController.showOrHideFinishingTask();
            },
            itemBuilder: (_) => [
               PopupMenuItem<bool>(
                value: true,
                child: Text('${widget._homeController.showFinishingTask ? 'Esconder' : 'Mostrar'}  tarefas concluidas'),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: context.primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        onPressed: () => _goToCreateTask(context),
        child: const Icon(Icons.add),
      ),
      backgroundColor: const Color(0xFFFAFBFE),
      drawer: HomeDrawer(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
                minWidth: constraints.minWidth,
              ),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                //faz a tela ficar o tamnho exato da tela, sem ser infinito
                child: const IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HomeHeader(),
                      HomeFilters(),
                      HomeWeekFilter(),
                      HomeTask(),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
