import 'package:sqflite/sqflite.dart';

abstract interface class Migration {
//create que recebe um batch(lote)
void create (Batch batch);
void update (Batch batch);
}