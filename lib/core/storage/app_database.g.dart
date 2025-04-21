// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $UsuarioTableTable extends UsuarioTable
    with TableInfo<$UsuarioTableTable, UsuarioTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsuarioTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nomeMeta = const VerificationMeta('nome');
  @override
  late final GeneratedColumn<String> nome = GeneratedColumn<String>(
      'nome', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 2, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _matriculaMeta =
      const VerificationMeta('matricula');
  @override
  late final GeneratedColumn<String> matricula = GeneratedColumn<String>(
      'matricula', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _tokenMeta = const VerificationMeta('token');
  @override
  late final GeneratedColumn<String> token = GeneratedColumn<String>(
      'token', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _refreshTokenMeta =
      const VerificationMeta('refreshToken');
  @override
  late final GeneratedColumn<String> refreshToken = GeneratedColumn<String>(
      'refresh_token', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _ultimoLoginMeta =
      const VerificationMeta('ultimoLogin');
  @override
  late final GeneratedColumn<DateTime> ultimoLogin = GeneratedColumn<DateTime>(
      'ultimo_login', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, nome, matricula, token, refreshToken, ultimoLogin, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'usuario_table';
  @override
  VerificationContext validateIntegrity(Insertable<UsuarioTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nome')) {
      context.handle(
          _nomeMeta, nome.isAcceptableOrUnknown(data['nome']!, _nomeMeta));
    } else if (isInserting) {
      context.missing(_nomeMeta);
    }
    if (data.containsKey('matricula')) {
      context.handle(_matriculaMeta,
          matricula.isAcceptableOrUnknown(data['matricula']!, _matriculaMeta));
    } else if (isInserting) {
      context.missing(_matriculaMeta);
    }
    if (data.containsKey('token')) {
      context.handle(
          _tokenMeta, token.isAcceptableOrUnknown(data['token']!, _tokenMeta));
    }
    if (data.containsKey('refresh_token')) {
      context.handle(
          _refreshTokenMeta,
          refreshToken.isAcceptableOrUnknown(
              data['refresh_token']!, _refreshTokenMeta));
    }
    if (data.containsKey('ultimo_login')) {
      context.handle(
          _ultimoLoginMeta,
          ultimoLogin.isAcceptableOrUnknown(
              data['ultimo_login']!, _ultimoLoginMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UsuarioTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UsuarioTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      nome: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nome'])!,
      matricula: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}matricula'])!,
      token: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}token']),
      refreshToken: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}refresh_token']),
      ultimoLogin: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}ultimo_login']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $UsuarioTableTable createAlias(String alias) {
    return $UsuarioTableTable(attachedDatabase, alias);
  }
}

class UsuarioTableData extends DataClass
    implements Insertable<UsuarioTableData> {
  final int id;
  final String nome;
  final String matricula;
  final String? token;
  final String? refreshToken;
  final DateTime? ultimoLogin;
  final DateTime createdAt;
  const UsuarioTableData(
      {required this.id,
      required this.nome,
      required this.matricula,
      this.token,
      this.refreshToken,
      this.ultimoLogin,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nome'] = Variable<String>(nome);
    map['matricula'] = Variable<String>(matricula);
    if (!nullToAbsent || token != null) {
      map['token'] = Variable<String>(token);
    }
    if (!nullToAbsent || refreshToken != null) {
      map['refresh_token'] = Variable<String>(refreshToken);
    }
    if (!nullToAbsent || ultimoLogin != null) {
      map['ultimo_login'] = Variable<DateTime>(ultimoLogin);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  UsuarioTableCompanion toCompanion(bool nullToAbsent) {
    return UsuarioTableCompanion(
      id: Value(id),
      nome: Value(nome),
      matricula: Value(matricula),
      token:
          token == null && nullToAbsent ? const Value.absent() : Value(token),
      refreshToken: refreshToken == null && nullToAbsent
          ? const Value.absent()
          : Value(refreshToken),
      ultimoLogin: ultimoLogin == null && nullToAbsent
          ? const Value.absent()
          : Value(ultimoLogin),
      createdAt: Value(createdAt),
    );
  }

  factory UsuarioTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UsuarioTableData(
      id: serializer.fromJson<int>(json['id']),
      nome: serializer.fromJson<String>(json['nome']),
      matricula: serializer.fromJson<String>(json['matricula']),
      token: serializer.fromJson<String?>(json['token']),
      refreshToken: serializer.fromJson<String?>(json['refreshToken']),
      ultimoLogin: serializer.fromJson<DateTime?>(json['ultimoLogin']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nome': serializer.toJson<String>(nome),
      'matricula': serializer.toJson<String>(matricula),
      'token': serializer.toJson<String?>(token),
      'refreshToken': serializer.toJson<String?>(refreshToken),
      'ultimoLogin': serializer.toJson<DateTime?>(ultimoLogin),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  UsuarioTableData copyWith(
          {int? id,
          String? nome,
          String? matricula,
          Value<String?> token = const Value.absent(),
          Value<String?> refreshToken = const Value.absent(),
          Value<DateTime?> ultimoLogin = const Value.absent(),
          DateTime? createdAt}) =>
      UsuarioTableData(
        id: id ?? this.id,
        nome: nome ?? this.nome,
        matricula: matricula ?? this.matricula,
        token: token.present ? token.value : this.token,
        refreshToken:
            refreshToken.present ? refreshToken.value : this.refreshToken,
        ultimoLogin: ultimoLogin.present ? ultimoLogin.value : this.ultimoLogin,
        createdAt: createdAt ?? this.createdAt,
      );
  UsuarioTableData copyWithCompanion(UsuarioTableCompanion data) {
    return UsuarioTableData(
      id: data.id.present ? data.id.value : this.id,
      nome: data.nome.present ? data.nome.value : this.nome,
      matricula: data.matricula.present ? data.matricula.value : this.matricula,
      token: data.token.present ? data.token.value : this.token,
      refreshToken: data.refreshToken.present
          ? data.refreshToken.value
          : this.refreshToken,
      ultimoLogin:
          data.ultimoLogin.present ? data.ultimoLogin.value : this.ultimoLogin,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UsuarioTableData(')
          ..write('id: $id, ')
          ..write('nome: $nome, ')
          ..write('matricula: $matricula, ')
          ..write('token: $token, ')
          ..write('refreshToken: $refreshToken, ')
          ..write('ultimoLogin: $ultimoLogin, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, nome, matricula, token, refreshToken, ultimoLogin, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UsuarioTableData &&
          other.id == this.id &&
          other.nome == this.nome &&
          other.matricula == this.matricula &&
          other.token == this.token &&
          other.refreshToken == this.refreshToken &&
          other.ultimoLogin == this.ultimoLogin &&
          other.createdAt == this.createdAt);
}

class UsuarioTableCompanion extends UpdateCompanion<UsuarioTableData> {
  final Value<int> id;
  final Value<String> nome;
  final Value<String> matricula;
  final Value<String?> token;
  final Value<String?> refreshToken;
  final Value<DateTime?> ultimoLogin;
  final Value<DateTime> createdAt;
  const UsuarioTableCompanion({
    this.id = const Value.absent(),
    this.nome = const Value.absent(),
    this.matricula = const Value.absent(),
    this.token = const Value.absent(),
    this.refreshToken = const Value.absent(),
    this.ultimoLogin = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  UsuarioTableCompanion.insert({
    this.id = const Value.absent(),
    required String nome,
    required String matricula,
    this.token = const Value.absent(),
    this.refreshToken = const Value.absent(),
    this.ultimoLogin = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : nome = Value(nome),
        matricula = Value(matricula);
  static Insertable<UsuarioTableData> custom({
    Expression<int>? id,
    Expression<String>? nome,
    Expression<String>? matricula,
    Expression<String>? token,
    Expression<String>? refreshToken,
    Expression<DateTime>? ultimoLogin,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nome != null) 'nome': nome,
      if (matricula != null) 'matricula': matricula,
      if (token != null) 'token': token,
      if (refreshToken != null) 'refresh_token': refreshToken,
      if (ultimoLogin != null) 'ultimo_login': ultimoLogin,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  UsuarioTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? nome,
      Value<String>? matricula,
      Value<String?>? token,
      Value<String?>? refreshToken,
      Value<DateTime?>? ultimoLogin,
      Value<DateTime>? createdAt}) {
    return UsuarioTableCompanion(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      matricula: matricula ?? this.matricula,
      token: token ?? this.token,
      refreshToken: refreshToken ?? this.refreshToken,
      ultimoLogin: ultimoLogin ?? this.ultimoLogin,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nome.present) {
      map['nome'] = Variable<String>(nome.value);
    }
    if (matricula.present) {
      map['matricula'] = Variable<String>(matricula.value);
    }
    if (token.present) {
      map['token'] = Variable<String>(token.value);
    }
    if (refreshToken.present) {
      map['refresh_token'] = Variable<String>(refreshToken.value);
    }
    if (ultimoLogin.present) {
      map['ultimo_login'] = Variable<DateTime>(ultimoLogin.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsuarioTableCompanion(')
          ..write('id: $id, ')
          ..write('nome: $nome, ')
          ..write('matricula: $matricula, ')
          ..write('token: $token, ')
          ..write('refreshToken: $refreshToken, ')
          ..write('ultimoLogin: $ultimoLogin, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UsuarioTableTable usuarioTable = $UsuarioTableTable(this);
  late final UsuarioDao usuarioDao = UsuarioDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [usuarioTable];
}

typedef $$UsuarioTableTableCreateCompanionBuilder = UsuarioTableCompanion
    Function({
  Value<int> id,
  required String nome,
  required String matricula,
  Value<String?> token,
  Value<String?> refreshToken,
  Value<DateTime?> ultimoLogin,
  Value<DateTime> createdAt,
});
typedef $$UsuarioTableTableUpdateCompanionBuilder = UsuarioTableCompanion
    Function({
  Value<int> id,
  Value<String> nome,
  Value<String> matricula,
  Value<String?> token,
  Value<String?> refreshToken,
  Value<DateTime?> ultimoLogin,
  Value<DateTime> createdAt,
});

class $$UsuarioTableTableFilterComposer
    extends Composer<_$AppDatabase, $UsuarioTableTable> {
  $$UsuarioTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nome => $composableBuilder(
      column: $table.nome, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get matricula => $composableBuilder(
      column: $table.matricula, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get token => $composableBuilder(
      column: $table.token, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get refreshToken => $composableBuilder(
      column: $table.refreshToken, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get ultimoLogin => $composableBuilder(
      column: $table.ultimoLogin, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$UsuarioTableTableOrderingComposer
    extends Composer<_$AppDatabase, $UsuarioTableTable> {
  $$UsuarioTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nome => $composableBuilder(
      column: $table.nome, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get matricula => $composableBuilder(
      column: $table.matricula, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get token => $composableBuilder(
      column: $table.token, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get refreshToken => $composableBuilder(
      column: $table.refreshToken,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get ultimoLogin => $composableBuilder(
      column: $table.ultimoLogin, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$UsuarioTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsuarioTableTable> {
  $$UsuarioTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nome =>
      $composableBuilder(column: $table.nome, builder: (column) => column);

  GeneratedColumn<String> get matricula =>
      $composableBuilder(column: $table.matricula, builder: (column) => column);

  GeneratedColumn<String> get token =>
      $composableBuilder(column: $table.token, builder: (column) => column);

  GeneratedColumn<String> get refreshToken => $composableBuilder(
      column: $table.refreshToken, builder: (column) => column);

  GeneratedColumn<DateTime> get ultimoLogin => $composableBuilder(
      column: $table.ultimoLogin, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$UsuarioTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UsuarioTableTable,
    UsuarioTableData,
    $$UsuarioTableTableFilterComposer,
    $$UsuarioTableTableOrderingComposer,
    $$UsuarioTableTableAnnotationComposer,
    $$UsuarioTableTableCreateCompanionBuilder,
    $$UsuarioTableTableUpdateCompanionBuilder,
    (
      UsuarioTableData,
      BaseReferences<_$AppDatabase, $UsuarioTableTable, UsuarioTableData>
    ),
    UsuarioTableData,
    PrefetchHooks Function()> {
  $$UsuarioTableTableTableManager(_$AppDatabase db, $UsuarioTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsuarioTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsuarioTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsuarioTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> nome = const Value.absent(),
            Value<String> matricula = const Value.absent(),
            Value<String?> token = const Value.absent(),
            Value<String?> refreshToken = const Value.absent(),
            Value<DateTime?> ultimoLogin = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              UsuarioTableCompanion(
            id: id,
            nome: nome,
            matricula: matricula,
            token: token,
            refreshToken: refreshToken,
            ultimoLogin: ultimoLogin,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String nome,
            required String matricula,
            Value<String?> token = const Value.absent(),
            Value<String?> refreshToken = const Value.absent(),
            Value<DateTime?> ultimoLogin = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              UsuarioTableCompanion.insert(
            id: id,
            nome: nome,
            matricula: matricula,
            token: token,
            refreshToken: refreshToken,
            ultimoLogin: ultimoLogin,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$UsuarioTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $UsuarioTableTable,
    UsuarioTableData,
    $$UsuarioTableTableFilterComposer,
    $$UsuarioTableTableOrderingComposer,
    $$UsuarioTableTableAnnotationComposer,
    $$UsuarioTableTableCreateCompanionBuilder,
    $$UsuarioTableTableUpdateCompanionBuilder,
    (
      UsuarioTableData,
      BaseReferences<_$AppDatabase, $UsuarioTableTable, UsuarioTableData>
    ),
    UsuarioTableData,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UsuarioTableTableTableManager get usuarioTable =>
      $$UsuarioTableTableTableManager(_db, _db.usuarioTable);
}
