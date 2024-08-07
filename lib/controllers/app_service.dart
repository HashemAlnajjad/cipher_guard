import 'package:drift/drift.dart';
import 'package:get/get.dart';
import 'package:cipher_guard/database/users.dart';

class AppService extends GetxService {
  User? currentUser;
  final Database database = Database();

  Future<int> createUser(
      {required String firstName,
      required String lastName,
      required String password}) async {
    return await database.into(database.users).insert(UsersCompanion.insert(
        firstName: firstName, lastName: lastName, password: password));
  }

  Future<List<User>> getAllUsers() async {
    return await database.select(database.users).get();
  }

  Future<User> getUserById(int id) async {
    return await (database.select(database.users)
          ..where((tbl) => tbl.id.equals(id)))
        .getSingle();
  }

  Future<bool> updateUser(User a) async {
    return await database.update(database.users).replace(a);
  }

  Future<int> deleteUser(int id) async {
    return await (database.delete(database.users)
          ..where((tbl) => tbl.id.equals(id)))
        .go();
  }

  Future<List<User>> searchUser(String pattern) async {
    return await (database.select(database.users)
          ..where((tbl) =>
              tbl.firstName.like("%$pattern%") |
              tbl.lastName.like("%$pattern%")))
        .get();
  }

  Future<User> getUser(
      {required String firstName, required String lastName}) async {
    return await (database.select(database.users)
          ..where((tbl) =>
              tbl.firstName.equals(firstName) & tbl.lastName.equals(lastName)))
        .getSingle();
  }

  Future<int> createEncrypt(
      {required int userId,
      required String algoName,
      required String fileName,
      required String time,
      required DateTime date}) async {
    return await database.into(database.encryptions).insert(
        EncryptionsCompanion.insert(
            userId: userId,
            algoName: algoName,
            fileName: fileName,
            time: time,
            date: date));
  }

  Future<int> createDecrypt(
      {required int userId,
      required String algoName,
      required String fileName,
      required String time,
      required DateTime date}) async {
    return await database.into(database.decryptions).insert(
        DecryptionsCompanion.insert(
            userId: userId,
            algoName: algoName,
            fileName: fileName,
            time: time,
            date: date));
  }

  Future<int> deleteEncrypt(int id) async {
    return await (database.delete(database.encryptions)
          ..where((tbl) => tbl.processId.equals(id)))
        .go();
  }

  Future<int> deleteDecrypt(int id) async {
    return await (database.delete(database.decryptions)
          ..where((tbl) => tbl.processId.equals(id)))
        .go();
  }

  Future<List<Encryption>> getAllEncryptions(int id) async {
    return await (database.select(database.encryptions)..where((tbl) => tbl.userId.equals(id))).get();
  }

  Future<List<Decryption>> getAllDecryptions(int id) async {
    return await (database.select(database.decryptions)..where((tbl) => tbl.userId.equals(id))).get();
  }
}
