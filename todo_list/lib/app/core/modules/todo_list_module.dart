import 'package:flutter/material.dart';
import 'package:provider/single_child_widget.dart';
import 'package:todo_list/app/core/modules/todo_listPage.dart';

abstract class TodoListModule {
  final Map<String, WidgetBuilder> _routers;
  final List<SingleChildWidget>? _bindings;

//construtor
  TodoListModule({
    List<SingleChildWidget>? bindings,
    required Map<String, WidgetBuilder> routers,
  })  : _routers = routers,
        _bindings = bindings;

  //metodo do tipo get para declarar no materialApp  e encapsular page e colocar na login page
  //todoListPage login page foi encapsulado encima do todo..
  Map<String, WidgetBuilder> get routers {
    return _routers.map(
      (key, pageBuilder) => MapEntry(
        key,
        (_) => TodoListPage(
          bindings: _bindings,
          page: pageBuilder,
        ),
      ),
    );
  }
}
