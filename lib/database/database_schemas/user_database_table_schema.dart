import '../../core/services/database_service/database_table_schema.dart';

class UserDatabaseTableSchema extends DatabaseTableSchema {
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
