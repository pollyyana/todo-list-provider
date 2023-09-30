import 'package:flutter/material.dart';
import 'package:todo_list/app/core/database/sqlite_connection_factory.dart';

//se o usuario sair do aplicativo é fechada a conexao do sqlite, já que o aplicativo nao esta rodando
//WidgetsBindingObserver vai observar o flutter como um todo
class SqliteAdmConnection with WidgetsBindingObserver {
  @override

  //metodo que diz oq o usurio fez na aplicação
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final connection = SqliteConnectionFactory();

    switch (state) {
      case AppLifecycleState.resumed:
        break;

      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
      connection.closeConnection();
      break;
    }
    super.didChangeAppLifecycleState(state);
  }
}
