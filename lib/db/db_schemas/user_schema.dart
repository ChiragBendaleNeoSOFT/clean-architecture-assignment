import 'package:clean_architecture_assignment/core/services/db_service/table_schema.dart';

class UserTableSchema extends TableSchema {
  static const String table = "user";

  @override
  String get tableName => table;

  @override
  String createTableQuery() =>
      '''
    CREATE TABLE $table (
      id INTEGER PRIMARY KEY,
      email TEXT NOT NULL,
      first_name TEXT,
      last_name TEXT,
      avatar TEXT
    )
  ''';
}
