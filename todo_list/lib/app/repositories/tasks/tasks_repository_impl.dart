import 'package:todo_list/app/core/database/sqlite_connection_factory.dart';

import 'tasks_repository.dart';

class TaskRepositoryImpl implements TasksRepository {
  final SqliteConnectionFactory _sqliteConnectionFactory;

  TaskRepositoryImpl({
    required SqliteConnectionFactory sqliteConnectionFactory,
  }): _sqliteConnectionFactory = sqliteConnectionFactory;

  @override
  Future<void> save(DateTime date, String description) async {
    //cadastro da task to do
    final conn = await _sqliteConnectionFactory.openConnection();
    await conn.insert('todo', {
      'id': null,
      'descricao': description,
      'data_hora': date.toIso8601String(),
      'finalizado': 0,
    });
  }
}
