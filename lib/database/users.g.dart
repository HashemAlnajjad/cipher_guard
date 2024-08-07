// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users.dart';

// ignore_for_file: type=lint
class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _firstNameMeta =
      const VerificationMeta('firstName');
  @override
  late final GeneratedColumn<String> firstName = GeneratedColumn<String>(
      'first_name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 3, maxTextLength: 255),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _lastNameMeta =
      const VerificationMeta('lastName');
  @override
  late final GeneratedColumn<String> lastName = GeneratedColumn<String>(
      'last_name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 3, maxTextLength: 255),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _passwordMeta =
      const VerificationMeta('password');
  @override
  late final GeneratedColumn<String> password = GeneratedColumn<String>(
      'password', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 8, maxTextLength: 255),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, firstName, lastName, password];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(Insertable<User> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('first_name')) {
      context.handle(_firstNameMeta,
          firstName.isAcceptableOrUnknown(data['first_name']!, _firstNameMeta));
    } else if (isInserting) {
      context.missing(_firstNameMeta);
    }
    if (data.containsKey('last_name')) {
      context.handle(_lastNameMeta,
          lastName.isAcceptableOrUnknown(data['last_name']!, _lastNameMeta));
    } else if (isInserting) {
      context.missing(_lastNameMeta);
    }
    if (data.containsKey('password')) {
      context.handle(_passwordMeta,
          password.isAcceptableOrUnknown(data['password']!, _passwordMeta));
    } else if (isInserting) {
      context.missing(_passwordMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      firstName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}first_name'])!,
      lastName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}last_name'])!,
      password: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}password'])!,
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  final int id;
  final String firstName;
  final String lastName;
  final String password;
  const User(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.password});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['first_name'] = Variable<String>(firstName);
    map['last_name'] = Variable<String>(lastName);
    map['password'] = Variable<String>(password);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      firstName: Value(firstName),
      lastName: Value(lastName),
      password: Value(password),
    );
  }

  factory User.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<int>(json['id']),
      firstName: serializer.fromJson<String>(json['firstName']),
      lastName: serializer.fromJson<String>(json['lastName']),
      password: serializer.fromJson<String>(json['password']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'firstName': serializer.toJson<String>(firstName),
      'lastName': serializer.toJson<String>(lastName),
      'password': serializer.toJson<String>(password),
    };
  }

  User copyWith(
          {int? id, String? firstName, String? lastName, String? password}) =>
      User(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        password: password ?? this.password,
      );
  User copyWithCompanion(UsersCompanion data) {
    return User(
      id: data.id.present ? data.id.value : this.id,
      firstName: data.firstName.present ? data.firstName.value : this.firstName,
      lastName: data.lastName.present ? data.lastName.value : this.lastName,
      password: data.password.present ? data.password.value : this.password,
    );
  }

  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('password: $password')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, firstName, lastName, password);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.firstName == this.firstName &&
          other.lastName == this.lastName &&
          other.password == this.password);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<int> id;
  final Value<String> firstName;
  final Value<String> lastName;
  final Value<String> password;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.password = const Value.absent(),
  });
  UsersCompanion.insert({
    this.id = const Value.absent(),
    required String firstName,
    required String lastName,
    required String password,
  })  : firstName = Value(firstName),
        lastName = Value(lastName),
        password = Value(password);
  static Insertable<User> custom({
    Expression<int>? id,
    Expression<String>? firstName,
    Expression<String>? lastName,
    Expression<String>? password,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
      if (password != null) 'password': password,
    });
  }

  UsersCompanion copyWith(
      {Value<int>? id,
      Value<String>? firstName,
      Value<String>? lastName,
      Value<String>? password}) {
    return UsersCompanion(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      password: password ?? this.password,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (firstName.present) {
      map['first_name'] = Variable<String>(firstName.value);
    }
    if (lastName.present) {
      map['last_name'] = Variable<String>(lastName.value);
    }
    if (password.present) {
      map['password'] = Variable<String>(password.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('password: $password')
          ..write(')'))
        .toString();
  }
}

class $EncryptionsTable extends Encryptions
    with TableInfo<$EncryptionsTable, Encryption> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EncryptionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _processIdMeta =
      const VerificationMeta('processId');
  @override
  late final GeneratedColumn<int> processId = GeneratedColumn<int>(
      'process_id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
      'user_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _algoNameMeta =
      const VerificationMeta('algoName');
  @override
  late final GeneratedColumn<String> algoName = GeneratedColumn<String>(
      'algo_name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 3, maxTextLength: 255),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _fileNameMeta =
      const VerificationMeta('fileName');
  @override
  late final GeneratedColumn<String> fileName = GeneratedColumn<String>(
      'file_name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 3, maxTextLength: 255),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _timeMeta = const VerificationMeta('time');
  @override
  late final GeneratedColumn<String> time = GeneratedColumn<String>(
      'time', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 3, maxTextLength: 255),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [processId, userId, algoName, fileName, time, date];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'encryptions';
  @override
  VerificationContext validateIntegrity(Insertable<Encryption> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('process_id')) {
      context.handle(_processIdMeta,
          processId.isAcceptableOrUnknown(data['process_id']!, _processIdMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('algo_name')) {
      context.handle(_algoNameMeta,
          algoName.isAcceptableOrUnknown(data['algo_name']!, _algoNameMeta));
    } else if (isInserting) {
      context.missing(_algoNameMeta);
    }
    if (data.containsKey('file_name')) {
      context.handle(_fileNameMeta,
          fileName.isAcceptableOrUnknown(data['file_name']!, _fileNameMeta));
    } else if (isInserting) {
      context.missing(_fileNameMeta);
    }
    if (data.containsKey('time')) {
      context.handle(
          _timeMeta, time.isAcceptableOrUnknown(data['time']!, _timeMeta));
    } else if (isInserting) {
      context.missing(_timeMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {processId};
  @override
  Encryption map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Encryption(
      processId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}process_id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}user_id'])!,
      algoName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}algo_name'])!,
      fileName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}file_name'])!,
      time: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}time'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
    );
  }

  @override
  $EncryptionsTable createAlias(String alias) {
    return $EncryptionsTable(attachedDatabase, alias);
  }
}

class Encryption extends DataClass implements Insertable<Encryption> {
  final int processId;
  final int userId;
  final String algoName;
  final String fileName;
  final String time;
  final DateTime date;
  const Encryption(
      {required this.processId,
      required this.userId,
      required this.algoName,
      required this.fileName,
      required this.time,
      required this.date});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['process_id'] = Variable<int>(processId);
    map['user_id'] = Variable<int>(userId);
    map['algo_name'] = Variable<String>(algoName);
    map['file_name'] = Variable<String>(fileName);
    map['time'] = Variable<String>(time);
    map['date'] = Variable<DateTime>(date);
    return map;
  }

  EncryptionsCompanion toCompanion(bool nullToAbsent) {
    return EncryptionsCompanion(
      processId: Value(processId),
      userId: Value(userId),
      algoName: Value(algoName),
      fileName: Value(fileName),
      time: Value(time),
      date: Value(date),
    );
  }

  factory Encryption.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Encryption(
      processId: serializer.fromJson<int>(json['processId']),
      userId: serializer.fromJson<int>(json['userId']),
      algoName: serializer.fromJson<String>(json['algoName']),
      fileName: serializer.fromJson<String>(json['fileName']),
      time: serializer.fromJson<String>(json['time']),
      date: serializer.fromJson<DateTime>(json['date']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'processId': serializer.toJson<int>(processId),
      'userId': serializer.toJson<int>(userId),
      'algoName': serializer.toJson<String>(algoName),
      'fileName': serializer.toJson<String>(fileName),
      'time': serializer.toJson<String>(time),
      'date': serializer.toJson<DateTime>(date),
    };
  }

  Encryption copyWith(
          {int? processId,
          int? userId,
          String? algoName,
          String? fileName,
          String? time,
          DateTime? date}) =>
      Encryption(
        processId: processId ?? this.processId,
        userId: userId ?? this.userId,
        algoName: algoName ?? this.algoName,
        fileName: fileName ?? this.fileName,
        time: time ?? this.time,
        date: date ?? this.date,
      );
  Encryption copyWithCompanion(EncryptionsCompanion data) {
    return Encryption(
      processId: data.processId.present ? data.processId.value : this.processId,
      userId: data.userId.present ? data.userId.value : this.userId,
      algoName: data.algoName.present ? data.algoName.value : this.algoName,
      fileName: data.fileName.present ? data.fileName.value : this.fileName,
      time: data.time.present ? data.time.value : this.time,
      date: data.date.present ? data.date.value : this.date,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Encryption(')
          ..write('processId: $processId, ')
          ..write('userId: $userId, ')
          ..write('algoName: $algoName, ')
          ..write('fileName: $fileName, ')
          ..write('time: $time, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(processId, userId, algoName, fileName, time, date);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Encryption &&
          other.processId == this.processId &&
          other.userId == this.userId &&
          other.algoName == this.algoName &&
          other.fileName == this.fileName &&
          other.time == this.time &&
          other.date == this.date);
}

class EncryptionsCompanion extends UpdateCompanion<Encryption> {
  final Value<int> processId;
  final Value<int> userId;
  final Value<String> algoName;
  final Value<String> fileName;
  final Value<String> time;
  final Value<DateTime> date;
  const EncryptionsCompanion({
    this.processId = const Value.absent(),
    this.userId = const Value.absent(),
    this.algoName = const Value.absent(),
    this.fileName = const Value.absent(),
    this.time = const Value.absent(),
    this.date = const Value.absent(),
  });
  EncryptionsCompanion.insert({
    this.processId = const Value.absent(),
    required int userId,
    required String algoName,
    required String fileName,
    required String time,
    required DateTime date,
  })  : userId = Value(userId),
        algoName = Value(algoName),
        fileName = Value(fileName),
        time = Value(time),
        date = Value(date);
  static Insertable<Encryption> custom({
    Expression<int>? processId,
    Expression<int>? userId,
    Expression<String>? algoName,
    Expression<String>? fileName,
    Expression<String>? time,
    Expression<DateTime>? date,
  }) {
    return RawValuesInsertable({
      if (processId != null) 'process_id': processId,
      if (userId != null) 'user_id': userId,
      if (algoName != null) 'algo_name': algoName,
      if (fileName != null) 'file_name': fileName,
      if (time != null) 'time': time,
      if (date != null) 'date': date,
    });
  }

  EncryptionsCompanion copyWith(
      {Value<int>? processId,
      Value<int>? userId,
      Value<String>? algoName,
      Value<String>? fileName,
      Value<String>? time,
      Value<DateTime>? date}) {
    return EncryptionsCompanion(
      processId: processId ?? this.processId,
      userId: userId ?? this.userId,
      algoName: algoName ?? this.algoName,
      fileName: fileName ?? this.fileName,
      time: time ?? this.time,
      date: date ?? this.date,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (processId.present) {
      map['process_id'] = Variable<int>(processId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (algoName.present) {
      map['algo_name'] = Variable<String>(algoName.value);
    }
    if (fileName.present) {
      map['file_name'] = Variable<String>(fileName.value);
    }
    if (time.present) {
      map['time'] = Variable<String>(time.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EncryptionsCompanion(')
          ..write('processId: $processId, ')
          ..write('userId: $userId, ')
          ..write('algoName: $algoName, ')
          ..write('fileName: $fileName, ')
          ..write('time: $time, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }
}

class $DecryptionsTable extends Decryptions
    with TableInfo<$DecryptionsTable, Decryption> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DecryptionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _processIdMeta =
      const VerificationMeta('processId');
  @override
  late final GeneratedColumn<int> processId = GeneratedColumn<int>(
      'process_id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
      'user_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _algoNameMeta =
      const VerificationMeta('algoName');
  @override
  late final GeneratedColumn<String> algoName = GeneratedColumn<String>(
      'algo_name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 3, maxTextLength: 255),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _fileNameMeta =
      const VerificationMeta('fileName');
  @override
  late final GeneratedColumn<String> fileName = GeneratedColumn<String>(
      'file_name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 3, maxTextLength: 255),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _timeMeta = const VerificationMeta('time');
  @override
  late final GeneratedColumn<String> time = GeneratedColumn<String>(
      'time', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 3, maxTextLength: 255),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [processId, userId, algoName, fileName, time, date];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'decryptions';
  @override
  VerificationContext validateIntegrity(Insertable<Decryption> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('process_id')) {
      context.handle(_processIdMeta,
          processId.isAcceptableOrUnknown(data['process_id']!, _processIdMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('algo_name')) {
      context.handle(_algoNameMeta,
          algoName.isAcceptableOrUnknown(data['algo_name']!, _algoNameMeta));
    } else if (isInserting) {
      context.missing(_algoNameMeta);
    }
    if (data.containsKey('file_name')) {
      context.handle(_fileNameMeta,
          fileName.isAcceptableOrUnknown(data['file_name']!, _fileNameMeta));
    } else if (isInserting) {
      context.missing(_fileNameMeta);
    }
    if (data.containsKey('time')) {
      context.handle(
          _timeMeta, time.isAcceptableOrUnknown(data['time']!, _timeMeta));
    } else if (isInserting) {
      context.missing(_timeMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {processId};
  @override
  Decryption map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Decryption(
      processId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}process_id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}user_id'])!,
      algoName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}algo_name'])!,
      fileName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}file_name'])!,
      time: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}time'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
    );
  }

  @override
  $DecryptionsTable createAlias(String alias) {
    return $DecryptionsTable(attachedDatabase, alias);
  }
}

class Decryption extends DataClass implements Insertable<Decryption> {
  final int processId;
  final int userId;
  final String algoName;
  final String fileName;
  final String time;
  final DateTime date;
  const Decryption(
      {required this.processId,
      required this.userId,
      required this.algoName,
      required this.fileName,
      required this.time,
      required this.date});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['process_id'] = Variable<int>(processId);
    map['user_id'] = Variable<int>(userId);
    map['algo_name'] = Variable<String>(algoName);
    map['file_name'] = Variable<String>(fileName);
    map['time'] = Variable<String>(time);
    map['date'] = Variable<DateTime>(date);
    return map;
  }

  DecryptionsCompanion toCompanion(bool nullToAbsent) {
    return DecryptionsCompanion(
      processId: Value(processId),
      userId: Value(userId),
      algoName: Value(algoName),
      fileName: Value(fileName),
      time: Value(time),
      date: Value(date),
    );
  }

  factory Decryption.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Decryption(
      processId: serializer.fromJson<int>(json['processId']),
      userId: serializer.fromJson<int>(json['userId']),
      algoName: serializer.fromJson<String>(json['algoName']),
      fileName: serializer.fromJson<String>(json['fileName']),
      time: serializer.fromJson<String>(json['time']),
      date: serializer.fromJson<DateTime>(json['date']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'processId': serializer.toJson<int>(processId),
      'userId': serializer.toJson<int>(userId),
      'algoName': serializer.toJson<String>(algoName),
      'fileName': serializer.toJson<String>(fileName),
      'time': serializer.toJson<String>(time),
      'date': serializer.toJson<DateTime>(date),
    };
  }

  Decryption copyWith(
          {int? processId,
          int? userId,
          String? algoName,
          String? fileName,
          String? time,
          DateTime? date}) =>
      Decryption(
        processId: processId ?? this.processId,
        userId: userId ?? this.userId,
        algoName: algoName ?? this.algoName,
        fileName: fileName ?? this.fileName,
        time: time ?? this.time,
        date: date ?? this.date,
      );
  Decryption copyWithCompanion(DecryptionsCompanion data) {
    return Decryption(
      processId: data.processId.present ? data.processId.value : this.processId,
      userId: data.userId.present ? data.userId.value : this.userId,
      algoName: data.algoName.present ? data.algoName.value : this.algoName,
      fileName: data.fileName.present ? data.fileName.value : this.fileName,
      time: data.time.present ? data.time.value : this.time,
      date: data.date.present ? data.date.value : this.date,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Decryption(')
          ..write('processId: $processId, ')
          ..write('userId: $userId, ')
          ..write('algoName: $algoName, ')
          ..write('fileName: $fileName, ')
          ..write('time: $time, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(processId, userId, algoName, fileName, time, date);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Decryption &&
          other.processId == this.processId &&
          other.userId == this.userId &&
          other.algoName == this.algoName &&
          other.fileName == this.fileName &&
          other.time == this.time &&
          other.date == this.date);
}

class DecryptionsCompanion extends UpdateCompanion<Decryption> {
  final Value<int> processId;
  final Value<int> userId;
  final Value<String> algoName;
  final Value<String> fileName;
  final Value<String> time;
  final Value<DateTime> date;
  const DecryptionsCompanion({
    this.processId = const Value.absent(),
    this.userId = const Value.absent(),
    this.algoName = const Value.absent(),
    this.fileName = const Value.absent(),
    this.time = const Value.absent(),
    this.date = const Value.absent(),
  });
  DecryptionsCompanion.insert({
    this.processId = const Value.absent(),
    required int userId,
    required String algoName,
    required String fileName,
    required String time,
    required DateTime date,
  })  : userId = Value(userId),
        algoName = Value(algoName),
        fileName = Value(fileName),
        time = Value(time),
        date = Value(date);
  static Insertable<Decryption> custom({
    Expression<int>? processId,
    Expression<int>? userId,
    Expression<String>? algoName,
    Expression<String>? fileName,
    Expression<String>? time,
    Expression<DateTime>? date,
  }) {
    return RawValuesInsertable({
      if (processId != null) 'process_id': processId,
      if (userId != null) 'user_id': userId,
      if (algoName != null) 'algo_name': algoName,
      if (fileName != null) 'file_name': fileName,
      if (time != null) 'time': time,
      if (date != null) 'date': date,
    });
  }

  DecryptionsCompanion copyWith(
      {Value<int>? processId,
      Value<int>? userId,
      Value<String>? algoName,
      Value<String>? fileName,
      Value<String>? time,
      Value<DateTime>? date}) {
    return DecryptionsCompanion(
      processId: processId ?? this.processId,
      userId: userId ?? this.userId,
      algoName: algoName ?? this.algoName,
      fileName: fileName ?? this.fileName,
      time: time ?? this.time,
      date: date ?? this.date,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (processId.present) {
      map['process_id'] = Variable<int>(processId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (algoName.present) {
      map['algo_name'] = Variable<String>(algoName.value);
    }
    if (fileName.present) {
      map['file_name'] = Variable<String>(fileName.value);
    }
    if (time.present) {
      map['time'] = Variable<String>(time.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DecryptionsCompanion(')
          ..write('processId: $processId, ')
          ..write('userId: $userId, ')
          ..write('algoName: $algoName, ')
          ..write('fileName: $fileName, ')
          ..write('time: $time, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(e);
  $DatabaseManager get managers => $DatabaseManager(this);
  late final $UsersTable users = $UsersTable(this);
  late final $EncryptionsTable encryptions = $EncryptionsTable(this);
  late final $DecryptionsTable decryptions = $DecryptionsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [users, encryptions, decryptions];
}

typedef $$UsersTableCreateCompanionBuilder = UsersCompanion Function({
  Value<int> id,
  required String firstName,
  required String lastName,
  required String password,
});
typedef $$UsersTableUpdateCompanionBuilder = UsersCompanion Function({
  Value<int> id,
  Value<String> firstName,
  Value<String> lastName,
  Value<String> password,
});

class $$UsersTableTableManager extends RootTableManager<
    _$Database,
    $UsersTable,
    User,
    $$UsersTableFilterComposer,
    $$UsersTableOrderingComposer,
    $$UsersTableCreateCompanionBuilder,
    $$UsersTableUpdateCompanionBuilder> {
  $$UsersTableTableManager(_$Database db, $UsersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$UsersTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$UsersTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> firstName = const Value.absent(),
            Value<String> lastName = const Value.absent(),
            Value<String> password = const Value.absent(),
          }) =>
              UsersCompanion(
            id: id,
            firstName: firstName,
            lastName: lastName,
            password: password,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String firstName,
            required String lastName,
            required String password,
          }) =>
              UsersCompanion.insert(
            id: id,
            firstName: firstName,
            lastName: lastName,
            password: password,
          ),
        ));
}

class $$UsersTableFilterComposer
    extends FilterComposer<_$Database, $UsersTable> {
  $$UsersTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get firstName => $state.composableBuilder(
      column: $state.table.firstName,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get lastName => $state.composableBuilder(
      column: $state.table.lastName,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get password => $state.composableBuilder(
      column: $state.table.password,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$UsersTableOrderingComposer
    extends OrderingComposer<_$Database, $UsersTable> {
  $$UsersTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get firstName => $state.composableBuilder(
      column: $state.table.firstName,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get lastName => $state.composableBuilder(
      column: $state.table.lastName,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get password => $state.composableBuilder(
      column: $state.table.password,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$EncryptionsTableCreateCompanionBuilder = EncryptionsCompanion
    Function({
  Value<int> processId,
  required int userId,
  required String algoName,
  required String fileName,
  required String time,
  required DateTime date,
});
typedef $$EncryptionsTableUpdateCompanionBuilder = EncryptionsCompanion
    Function({
  Value<int> processId,
  Value<int> userId,
  Value<String> algoName,
  Value<String> fileName,
  Value<String> time,
  Value<DateTime> date,
});

class $$EncryptionsTableTableManager extends RootTableManager<
    _$Database,
    $EncryptionsTable,
    Encryption,
    $$EncryptionsTableFilterComposer,
    $$EncryptionsTableOrderingComposer,
    $$EncryptionsTableCreateCompanionBuilder,
    $$EncryptionsTableUpdateCompanionBuilder> {
  $$EncryptionsTableTableManager(_$Database db, $EncryptionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$EncryptionsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$EncryptionsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> processId = const Value.absent(),
            Value<int> userId = const Value.absent(),
            Value<String> algoName = const Value.absent(),
            Value<String> fileName = const Value.absent(),
            Value<String> time = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
          }) =>
              EncryptionsCompanion(
            processId: processId,
            userId: userId,
            algoName: algoName,
            fileName: fileName,
            time: time,
            date: date,
          ),
          createCompanionCallback: ({
            Value<int> processId = const Value.absent(),
            required int userId,
            required String algoName,
            required String fileName,
            required String time,
            required DateTime date,
          }) =>
              EncryptionsCompanion.insert(
            processId: processId,
            userId: userId,
            algoName: algoName,
            fileName: fileName,
            time: time,
            date: date,
          ),
        ));
}

class $$EncryptionsTableFilterComposer
    extends FilterComposer<_$Database, $EncryptionsTable> {
  $$EncryptionsTableFilterComposer(super.$state);
  ColumnFilters<int> get processId => $state.composableBuilder(
      column: $state.table.processId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get userId => $state.composableBuilder(
      column: $state.table.userId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get algoName => $state.composableBuilder(
      column: $state.table.algoName,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get fileName => $state.composableBuilder(
      column: $state.table.fileName,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get time => $state.composableBuilder(
      column: $state.table.time,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get date => $state.composableBuilder(
      column: $state.table.date,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$EncryptionsTableOrderingComposer
    extends OrderingComposer<_$Database, $EncryptionsTable> {
  $$EncryptionsTableOrderingComposer(super.$state);
  ColumnOrderings<int> get processId => $state.composableBuilder(
      column: $state.table.processId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get userId => $state.composableBuilder(
      column: $state.table.userId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get algoName => $state.composableBuilder(
      column: $state.table.algoName,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get fileName => $state.composableBuilder(
      column: $state.table.fileName,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get time => $state.composableBuilder(
      column: $state.table.time,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get date => $state.composableBuilder(
      column: $state.table.date,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$DecryptionsTableCreateCompanionBuilder = DecryptionsCompanion
    Function({
  Value<int> processId,
  required int userId,
  required String algoName,
  required String fileName,
  required String time,
  required DateTime date,
});
typedef $$DecryptionsTableUpdateCompanionBuilder = DecryptionsCompanion
    Function({
  Value<int> processId,
  Value<int> userId,
  Value<String> algoName,
  Value<String> fileName,
  Value<String> time,
  Value<DateTime> date,
});

class $$DecryptionsTableTableManager extends RootTableManager<
    _$Database,
    $DecryptionsTable,
    Decryption,
    $$DecryptionsTableFilterComposer,
    $$DecryptionsTableOrderingComposer,
    $$DecryptionsTableCreateCompanionBuilder,
    $$DecryptionsTableUpdateCompanionBuilder> {
  $$DecryptionsTableTableManager(_$Database db, $DecryptionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$DecryptionsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$DecryptionsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> processId = const Value.absent(),
            Value<int> userId = const Value.absent(),
            Value<String> algoName = const Value.absent(),
            Value<String> fileName = const Value.absent(),
            Value<String> time = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
          }) =>
              DecryptionsCompanion(
            processId: processId,
            userId: userId,
            algoName: algoName,
            fileName: fileName,
            time: time,
            date: date,
          ),
          createCompanionCallback: ({
            Value<int> processId = const Value.absent(),
            required int userId,
            required String algoName,
            required String fileName,
            required String time,
            required DateTime date,
          }) =>
              DecryptionsCompanion.insert(
            processId: processId,
            userId: userId,
            algoName: algoName,
            fileName: fileName,
            time: time,
            date: date,
          ),
        ));
}

class $$DecryptionsTableFilterComposer
    extends FilterComposer<_$Database, $DecryptionsTable> {
  $$DecryptionsTableFilterComposer(super.$state);
  ColumnFilters<int> get processId => $state.composableBuilder(
      column: $state.table.processId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get userId => $state.composableBuilder(
      column: $state.table.userId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get algoName => $state.composableBuilder(
      column: $state.table.algoName,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get fileName => $state.composableBuilder(
      column: $state.table.fileName,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get time => $state.composableBuilder(
      column: $state.table.time,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get date => $state.composableBuilder(
      column: $state.table.date,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$DecryptionsTableOrderingComposer
    extends OrderingComposer<_$Database, $DecryptionsTable> {
  $$DecryptionsTableOrderingComposer(super.$state);
  ColumnOrderings<int> get processId => $state.composableBuilder(
      column: $state.table.processId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get userId => $state.composableBuilder(
      column: $state.table.userId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get algoName => $state.composableBuilder(
      column: $state.table.algoName,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get fileName => $state.composableBuilder(
      column: $state.table.fileName,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get time => $state.composableBuilder(
      column: $state.table.time,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get date => $state.composableBuilder(
      column: $state.table.date,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class $DatabaseManager {
  final _$Database _db;
  $DatabaseManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
  $$EncryptionsTableTableManager get encryptions =>
      $$EncryptionsTableTableManager(_db, _db.encryptions);
  $$DecryptionsTableTableManager get decryptions =>
      $$DecryptionsTableTableManager(_db, _db.decryptions);
}
