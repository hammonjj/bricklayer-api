import 'package:dartomite/database/database.dart';
import 'package:dartomite/dtos/users/create_user_dto.dart';
import 'package:dartomite/dtos/users/response_user_dto.dart';
import 'package:dartomite/dtos/users/update_user_dto.dart';
import 'package:dartomite/utils/hash_password.dart';
import 'package:drift/drift.dart';

class UserRepository {
  final AppDatabase db;

  UserRepository(this.db);

  Future<List<ResponseUserDto>> getAllUsers() async {
    final query = db.select(db.users);
    final users = await query.get();

    return users
        .map((user) => ResponseUserDto(
              id: user.id,
              name: user.name,
              email: user.email,
            ))
        .toList();
  }

  Future<ResponseUserDto?> getUserById(int id) async {
    final query = db.select(db.users)..where((tbl) => tbl.id.equals(id));
    final user = await query.getSingleOrNull();

    if (user == null) return null;

    return ResponseUserDto(
      id: user.id,
      name: user.name,
      email: user.email,
    );
  }

  Future<ResponseUserDto> createUser(CreateUserDto userData) async {
    final hashedPassword = hashPassword(userData.password);

    final userCompanion = UsersCompanion(
      name: Value(userData.name),
      email: Value(userData.email),
      password: Value(hashedPassword),
    );

    await db.into(db.users).insert(userCompanion);

    return ResponseUserDto(
      id: userCompanion.id.value,
      name: userCompanion.name.value,
      email: userCompanion.email.value,
    );
  }

  Future<ResponseUserDto?> updateUser(int id, UpdateUserDto userData) async {
    final query = db.update(db.users)..where((tbl) => tbl.id.equals(id));

    final userCompanion = UsersCompanion(
      name: userData.name != null ? Value(userData.name!) : const Value.absent(),
      email: userData.email != null ? Value(userData.email!) : const Value.absent(),
      password: userData.password != null ? Value(hashPassword(userData.password!)) : const Value.absent(),
    );

    final updatedRows = await query.write(userCompanion);

    if (updatedRows == 0) {
      throw Exception('User with ID $id not found or not updated.');
    }

    return getUserById(id);
  }

  Future<void> deleteUser(int id) async {
    db.delete(db.users).where((tbl) => tbl.id.equals(id));
  }
}
