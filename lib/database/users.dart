import 'dart:io';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:drift/drift.dart';
import 'package:path_provider/path_provider.dart';

part 'users.g.dart';

class Users extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get firstName => text().withLength(min: 3, max: 255)();

  TextColumn get lastName => text().withLength(min: 3, max: 255)();

  TextColumn get password => text().withLength(min: 8, max: 255)();
}

class Encryptions extends Table {
  IntColumn get processId => integer().autoIncrement()();

  IntColumn get userId => integer()();

  TextColumn get algoName => text().withLength(min: 3, max: 255)();

  TextColumn get fileName => text().withLength(min: 3, max: 255)();

  TextColumn get time => text().withLength(min: 3, max: 255)();

  DateTimeColumn get date => dateTime()();
}

class Decryptions extends Table {
  IntColumn get processId => integer().autoIncrement()();

  IntColumn get userId => integer()();

  TextColumn get algoName => text().withLength(min: 3, max: 255)();

  TextColumn get fileName => text().withLength(min: 3, max: 255)();

  TextColumn get time => text().withLength(min: 3, max: 255)();

  DateTimeColumn get date => dateTime()();
}

@DriftDatabase(tables: [Users, Encryptions, Decryptions])
class Database extends _$Database {
  Database() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'database.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
