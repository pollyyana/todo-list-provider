import 'package:todo_list/app/core/database/sqlite_connection_factory.dart';

import './task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {

  final SqliteConnectionFactory _sqliteConnectionFactory;

  TaskRepositoryImpl({required SqliteConnectionFactory sqliteConnectionFactory}): _sqliteConnectionFactory = sqliteConnectionFactory;

  @override
  Future<void> saveTask(DateTime date, String description) async{
    //cadastro da task to do
    final conec = await _sqliteConnectionFactory.openConnection();
    await conec.insert(
      'todo', {
      'id' : null,
      'descricao' : description,
      'data_hora' : date.toIso8601String(),
      'finalizado' : 0,
    });
  }
 
}