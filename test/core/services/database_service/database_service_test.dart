import 'package:clean_architecture_assignment/core/services/database_service/database_service.dart';
import 'package:clean_architecture_assignment/core/services/database_service/database_table_schema.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class MockDatabaseTableSchema extends Mock implements DatabaseTableSchema {
  @override
  String get tableName => 'test_table';

  @override
  String createTableQuery() =>
      'CREATE TABLE test_table (id INTEGER PRIMARY KEY)';
}

void main() {
  late DatabaseService databaseService;
  late MockDatabaseTableSchema mockSchema;

  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  setUp(() {
    mockSchema = MockDatabaseTableSchema();
    databaseService = DatabaseService.instance;
  });

  group('DatabaseService', () {
    test('getInstance returns the same instance', () {
      final instance1 = DatabaseService.instance;
      final instance2 = DatabaseService.instance;
      expect(identical(instance1, instance2), true);
    });

    test('addSchema adds schema to list', () {
      databaseService.addSchema(mockSchema);
      // Since schemas is private, we can verify its behavior through database operations
      expect(databaseService.hasSchema(mockSchema.tableName), true);
    });

    test('database is initialized with correct version', () async {
      final db = await databaseService.database;
      expect(db.isOpen, true);

      final version = await db.getVersion();
      expect(version, 1); // Default version from DatabaseService
    });

    test('hasSchema returns correct value', () {
      databaseService.addSchema(mockSchema);
      expect(databaseService.hasSchema('test_table'), true);
      expect(databaseService.hasSchema('non_existent_table'), false);
    });
  });
}
