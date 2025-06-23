import 'package:clean_architecture_assignment/core/services/db_service/db_service.dart';
import 'package:clean_architecture_assignment/db/db_schemas/user_schema.dart';
import 'package:clean_architecture_assignment/features/users/data/models/user_model.dart';
import 'package:clean_architecture_assignment/features/users/data/models/users_response.dart';

import 'package:sqflite/sqflite.dart';

class UserDatabase {
  UserTableSchema userTableSchema = UserTableSchema();
  final db = DBService.instance;

  Future<void> insertUsers(List<UserModel> users, int page) async {
    final database = await db.database;

    await database.transaction((txn) async {
      if (page == 1) {
        await txn.delete(userTableSchema.tableName);
      }

      final batch = txn.batch();
      for (var user in users) {
        batch.insert(
          userTableSchema.tableName,
          user.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
      await batch.commit(noResult: true);
    });
  }

  Future<UsersResponse> getUsers({
    required int page,
    required int limit,
  }) async {
    final database = await db.database;

    final offset = (page - 1) * limit;

    final List<Map<String, dynamic>> results = await database.transaction((
      txn,
    ) {
      return txn.query(userTableSchema.tableName, limit: limit, offset: offset);
    });

    final data = results.map((json) => UserModel.fromJson(json)).toList();
    return UsersResponse(
      page: 1,
      total: data.length,
      perPage: data.length,
      totalPages: 1,
      users: data,
    );
  }
}
