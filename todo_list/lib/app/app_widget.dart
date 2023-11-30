import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/app/core/database/sqlite_adm_connection.dart';
import 'package:todo_list/app/core/navigator/todo_list_navigator.dart';
import 'package:todo_list/app/core/ui/todo_list_ui_config.dart';
import 'package:todo_list/app/modules/auth/auth_module.dart';
import 'package:todo_list/app/modules/home/home_module.dart';
import 'package:todo_list/app/modules/splash/splash_page.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  final sqliteAdmConnection = SqliteAdmConnection();

  @override
  void initState() {
    super.initState();
    FirebaseAuth auth = FirebaseAuth.instance;
    WidgetsBinding.instance.addObserver(sqliteAdmConnection);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List Provider',
      // initialRoute: '/login',
      theme: TodoListUiConfig.theme,
      //navegacao sem necessitar de um contexto
      navigatorKey: TodoListNavigator.navigatorKey,
      routes: {
        ...AuthModule().routers,
        ...HomeModule().routers,
      },
      home: const SplashPage(),
    );
  }
}


  // @override
  // void dispose() {
  //   WidgetsBinding.instance.removeObserver(sqliteAdmConnection);
  //   super.dispose();
  // }

// exemplo
// routes: {
      //   '/login': (_) => MultiProvider(
      //         providers: [
      //           Provider(create: (_) => 'Repository'),
      //           Provider(
      //             create: (_) => 'Service',
      //           ),
      //           ChangeNotifierProvider(create: (_)=> LoginController()),
      //         ],
      //         child: const LoginPage(),
      //       ),
      // },