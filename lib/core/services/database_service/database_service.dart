import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'database_table_schema.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  static Database? _database;
  static const _dbName = "users.database";
  static const _version = 1;
  static DatabaseService get instance => _instance;

  final List<DatabaseTableSchema> _schemas = [];

  DatabaseService._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    final dbPath = join(await getDatabasesPath(), _dbName);
    _database = await openDatabase(
      dbPath,
      version: _version,
      onCreate: _onCreate,
    );
    return _database!;
  }

  void initSchemas(List<DatabaseTableSchema> schemas) {
    _schemas.clear();
    _schemas.addAll(schemas);
  }

  Future<void> _onCreate(Database db, int version) async {
    for (final schema in _schemas) {
      await db.execute(schema.createTableQuery());
    }
  }

  void addSchema(DatabaseTableSchema schema) {
    if (!_schemas.any((s) => s.tableName == schema.tableName)) {
      _schemas.add(schema);
    }
  }

  bool hasSchema(String tableName) {
    return _schemas.any((s) => s.tableName == tableName);
  }
}
