import 'package:clean_architecture_assignment/core/services/db_service/database_table_schema.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  static Database? _database;
  static const _dbName = "users.database";
  static const _version = 1;
  final List<DatabaseTableSchema> _schemas = [];

  DatabaseService._internal();

  static DatabaseService get instance => _instance;

  void initSchemas(List<DatabaseTableSchema> schemas) {
    _schemas.clear();
    _schemas.addAll(schemas);
  }

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

  Future<void> _onCreate(Database db, int version) async {
    for (final schema in _schemas) {
      await db.execute(schema.createTableQuery());
    }
  }
}
