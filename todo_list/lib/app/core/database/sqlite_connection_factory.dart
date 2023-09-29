import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:synchronized/synchronized.dart';
import 'package:todo_list/app/core/database/sqlite_migration_factory.dart';

class SqliteConnectionFactory {
  //Fabrica de conexões

  static const _VERSION = 1;
  static const _DATABASE_NAME = 'TODO LIST PROVIDER';

  static SqliteConnectionFactory? _instance;
  //atributo de classe
  Database? _db;
  final _lock = Lock();
  SqliteConnectionFactory._();

  //instancia
  factory SqliteConnectionFactory() {
    _instance ??= SqliteConnectionFactory._();
    return _instance!;
  }
  Future<Database> openConnection() async {
    var databasePath = await getDatabasesPath();
    var databasePathFinal = join(databasePath, _DATABASE_NAME);
    if (_db == null) {
      await _lock.synchronized(() async {
        _db ??= await openDatabase(
          databasePathFinal,
          version: _VERSION,
          onConfigure: _onConfigure,
          onCreate: _onCreate,
          onUpgrade: _onUpgrade,
          onDowngrade: _onDowngrade,
        );
      });
    }
    return _db!;
  }

  void closeConnection() {
    _db?.close();
    _db = null;
  }

//metodos
  Future<void> _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys =  ON');
  }

  Future<void> _onCreate(Database db, int version) async {
    //instancia do bd
    final batch = db.batch();
    // recuperar migrations
    final migrations = SqliteMigrationFactory().getCreateMigration();
    //for vai fzr um loop e executar cada uma da versoes de migration
    for (var migration in migrations) {
      migration.create(batch);
    }

    batch.commit();
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int version) async {
    //instancia do bd
    final batch = db.batch();
    // recuperar migrations
    final migrations = SqliteMigrationFactory().getUpgradeMigration(oldVersion);
    //for vai fzr um loop e executar cada uma da versoes de migration
    for (var migration in migrations) {
      migration.update(batch);
    }

    batch.commit();
  }

  Future<void> _onDowngrade(Database db, int oldVersion, int version) async {}
}
