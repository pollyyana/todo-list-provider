import 'package:sqflite_common/sqlite_api.dart';
import 'package:todo_list/app/core/database/migrations/migration.dart';

class MigrationV1 implements Migration {
  @override
  void create(Batch batch) {
    batch.execute('''
create table todo(
  id Interger primary key autoincrement,
  descriação varchar (500) not null,
  data_hora datetime,
  finalizado interger
)
''');
  }

  @override
  void update(Batch batch) {}
}
