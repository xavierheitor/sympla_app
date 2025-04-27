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

class $TipoAtividadeTableTable extends TipoAtividadeTable
    with TableInfo<$TipoAtividadeTableTable, TipoAtividadeTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TipoAtividadeTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
      'uuid', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _sincronizadoMeta =
      const VerificationMeta('sincronizado');
  @override
  late final GeneratedColumn<bool> sincronizado = GeneratedColumn<bool>(
      'sincronizado', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("sincronizado" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _nomeMeta = const VerificationMeta('nome');
  @override
  late final GeneratedColumn<String> nome = GeneratedColumn<String>(
      'nome', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 2, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _tipoAtividadeMobileMeta =
      const VerificationMeta('tipoAtividadeMobile');
  @override
  late final GeneratedColumnWithTypeConverter<TipoAtividadeMobile, String>
      tipoAtividadeMobile = GeneratedColumn<String>(
              'tipo_atividade_mobile', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<TipoAtividadeMobile>(
              $TipoAtividadeTableTable.$convertertipoAtividadeMobile);
  static const VerificationMeta _aprIdMeta = const VerificationMeta('aprId');
  @override
  late final GeneratedColumn<int> aprId = GeneratedColumn<int>(
      'apr_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _checklistIdMeta =
      const VerificationMeta('checklistId');
  @override
  late final GeneratedColumn<int> checklistId = GeneratedColumn<int>(
      'checklist_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        uuid,
        createdAt,
        updatedAt,
        sincronizado,
        nome,
        tipoAtividadeMobile,
        aprId,
        checklistId
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tipo_atividade_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<TipoAtividadeTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('uuid')) {
      context.handle(
          _uuidMeta, uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta));
    } else if (isInserting) {
      context.missing(_uuidMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('sincronizado')) {
      context.handle(
          _sincronizadoMeta,
          sincronizado.isAcceptableOrUnknown(
              data['sincronizado']!, _sincronizadoMeta));
    }
    if (data.containsKey('nome')) {
      context.handle(
          _nomeMeta, nome.isAcceptableOrUnknown(data['nome']!, _nomeMeta));
    } else if (isInserting) {
      context.missing(_nomeMeta);
    }
    context.handle(
        _tipoAtividadeMobileMeta, const VerificationResult.success());
    if (data.containsKey('apr_id')) {
      context.handle(
          _aprIdMeta, aprId.isAcceptableOrUnknown(data['apr_id']!, _aprIdMeta));
    } else if (isInserting) {
      context.missing(_aprIdMeta);
    }
    if (data.containsKey('checklist_id')) {
      context.handle(
          _checklistIdMeta,
          checklistId.isAcceptableOrUnknown(
              data['checklist_id']!, _checklistIdMeta));
    } else if (isInserting) {
      context.missing(_checklistIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TipoAtividadeTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TipoAtividadeTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      uuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uuid'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      sincronizado: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}sincronizado'])!,
      nome: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nome'])!,
      tipoAtividadeMobile: $TipoAtividadeTableTable
          .$convertertipoAtividadeMobile
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}tipo_atividade_mobile'])!),
      aprId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}apr_id'])!,
      checklistId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}checklist_id'])!,
    );
  }

  @override
  $TipoAtividadeTableTable createAlias(String alias) {
    return $TipoAtividadeTableTable(attachedDatabase, alias);
  }

  static TypeConverter<TipoAtividadeMobile, String>
      $convertertipoAtividadeMobile = const TipoAtividadeMobileConverter();
}

class TipoAtividadeTableData extends DataClass
    implements Insertable<TipoAtividadeTableData> {
  final int id;
  final String uuid;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool sincronizado;
  final String nome;
  final TipoAtividadeMobile tipoAtividadeMobile;
  final int aprId;
  final int checklistId;
  const TipoAtividadeTableData(
      {required this.id,
      required this.uuid,
      required this.createdAt,
      required this.updatedAt,
      required this.sincronizado,
      required this.nome,
      required this.tipoAtividadeMobile,
      required this.aprId,
      required this.checklistId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['uuid'] = Variable<String>(uuid);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['sincronizado'] = Variable<bool>(sincronizado);
    map['nome'] = Variable<String>(nome);
    {
      map['tipo_atividade_mobile'] = Variable<String>($TipoAtividadeTableTable
          .$convertertipoAtividadeMobile
          .toSql(tipoAtividadeMobile));
    }
    map['apr_id'] = Variable<int>(aprId);
    map['checklist_id'] = Variable<int>(checklistId);
    return map;
  }

  TipoAtividadeTableCompanion toCompanion(bool nullToAbsent) {
    return TipoAtividadeTableCompanion(
      id: Value(id),
      uuid: Value(uuid),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      sincronizado: Value(sincronizado),
      nome: Value(nome),
      tipoAtividadeMobile: Value(tipoAtividadeMobile),
      aprId: Value(aprId),
      checklistId: Value(checklistId),
    );
  }

  factory TipoAtividadeTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TipoAtividadeTableData(
      id: serializer.fromJson<int>(json['id']),
      uuid: serializer.fromJson<String>(json['uuid']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      sincronizado: serializer.fromJson<bool>(json['sincronizado']),
      nome: serializer.fromJson<String>(json['nome']),
      tipoAtividadeMobile:
          serializer.fromJson<TipoAtividadeMobile>(json['tipoAtividadeMobile']),
      aprId: serializer.fromJson<int>(json['aprId']),
      checklistId: serializer.fromJson<int>(json['checklistId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'uuid': serializer.toJson<String>(uuid),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'sincronizado': serializer.toJson<bool>(sincronizado),
      'nome': serializer.toJson<String>(nome),
      'tipoAtividadeMobile':
          serializer.toJson<TipoAtividadeMobile>(tipoAtividadeMobile),
      'aprId': serializer.toJson<int>(aprId),
      'checklistId': serializer.toJson<int>(checklistId),
    };
  }

  TipoAtividadeTableData copyWith(
          {int? id,
          String? uuid,
          DateTime? createdAt,
          DateTime? updatedAt,
          bool? sincronizado,
          String? nome,
          TipoAtividadeMobile? tipoAtividadeMobile,
          int? aprId,
          int? checklistId}) =>
      TipoAtividadeTableData(
        id: id ?? this.id,
        uuid: uuid ?? this.uuid,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        sincronizado: sincronizado ?? this.sincronizado,
        nome: nome ?? this.nome,
        tipoAtividadeMobile: tipoAtividadeMobile ?? this.tipoAtividadeMobile,
        aprId: aprId ?? this.aprId,
        checklistId: checklistId ?? this.checklistId,
      );
  TipoAtividadeTableData copyWithCompanion(TipoAtividadeTableCompanion data) {
    return TipoAtividadeTableData(
      id: data.id.present ? data.id.value : this.id,
      uuid: data.uuid.present ? data.uuid.value : this.uuid,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      sincronizado: data.sincronizado.present
          ? data.sincronizado.value
          : this.sincronizado,
      nome: data.nome.present ? data.nome.value : this.nome,
      tipoAtividadeMobile: data.tipoAtividadeMobile.present
          ? data.tipoAtividadeMobile.value
          : this.tipoAtividadeMobile,
      aprId: data.aprId.present ? data.aprId.value : this.aprId,
      checklistId:
          data.checklistId.present ? data.checklistId.value : this.checklistId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TipoAtividadeTableData(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('sincronizado: $sincronizado, ')
          ..write('nome: $nome, ')
          ..write('tipoAtividadeMobile: $tipoAtividadeMobile, ')
          ..write('aprId: $aprId, ')
          ..write('checklistId: $checklistId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, uuid, createdAt, updatedAt, sincronizado,
      nome, tipoAtividadeMobile, aprId, checklistId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TipoAtividadeTableData &&
          other.id == this.id &&
          other.uuid == this.uuid &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.sincronizado == this.sincronizado &&
          other.nome == this.nome &&
          other.tipoAtividadeMobile == this.tipoAtividadeMobile &&
          other.aprId == this.aprId &&
          other.checklistId == this.checklistId);
}

class TipoAtividadeTableCompanion
    extends UpdateCompanion<TipoAtividadeTableData> {
  final Value<int> id;
  final Value<String> uuid;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<bool> sincronizado;
  final Value<String> nome;
  final Value<TipoAtividadeMobile> tipoAtividadeMobile;
  final Value<int> aprId;
  final Value<int> checklistId;
  const TipoAtividadeTableCompanion({
    this.id = const Value.absent(),
    this.uuid = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.sincronizado = const Value.absent(),
    this.nome = const Value.absent(),
    this.tipoAtividadeMobile = const Value.absent(),
    this.aprId = const Value.absent(),
    this.checklistId = const Value.absent(),
  });
  TipoAtividadeTableCompanion.insert({
    this.id = const Value.absent(),
    required String uuid,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.sincronizado = const Value.absent(),
    required String nome,
    required TipoAtividadeMobile tipoAtividadeMobile,
    required int aprId,
    required int checklistId,
  })  : uuid = Value(uuid),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt),
        nome = Value(nome),
        tipoAtividadeMobile = Value(tipoAtividadeMobile),
        aprId = Value(aprId),
        checklistId = Value(checklistId);
  static Insertable<TipoAtividadeTableData> custom({
    Expression<int>? id,
    Expression<String>? uuid,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<bool>? sincronizado,
    Expression<String>? nome,
    Expression<String>? tipoAtividadeMobile,
    Expression<int>? aprId,
    Expression<int>? checklistId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uuid != null) 'uuid': uuid,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (sincronizado != null) 'sincronizado': sincronizado,
      if (nome != null) 'nome': nome,
      if (tipoAtividadeMobile != null)
        'tipo_atividade_mobile': tipoAtividadeMobile,
      if (aprId != null) 'apr_id': aprId,
      if (checklistId != null) 'checklist_id': checklistId,
    });
  }

  TipoAtividadeTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? uuid,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<bool>? sincronizado,
      Value<String>? nome,
      Value<TipoAtividadeMobile>? tipoAtividadeMobile,
      Value<int>? aprId,
      Value<int>? checklistId}) {
    return TipoAtividadeTableCompanion(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      sincronizado: sincronizado ?? this.sincronizado,
      nome: nome ?? this.nome,
      tipoAtividadeMobile: tipoAtividadeMobile ?? this.tipoAtividadeMobile,
      aprId: aprId ?? this.aprId,
      checklistId: checklistId ?? this.checklistId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (sincronizado.present) {
      map['sincronizado'] = Variable<bool>(sincronizado.value);
    }
    if (nome.present) {
      map['nome'] = Variable<String>(nome.value);
    }
    if (tipoAtividadeMobile.present) {
      map['tipo_atividade_mobile'] = Variable<String>($TipoAtividadeTableTable
          .$convertertipoAtividadeMobile
          .toSql(tipoAtividadeMobile.value));
    }
    if (aprId.present) {
      map['apr_id'] = Variable<int>(aprId.value);
    }
    if (checklistId.present) {
      map['checklist_id'] = Variable<int>(checklistId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TipoAtividadeTableCompanion(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('sincronizado: $sincronizado, ')
          ..write('nome: $nome, ')
          ..write('tipoAtividadeMobile: $tipoAtividadeMobile, ')
          ..write('aprId: $aprId, ')
          ..write('checklistId: $checklistId')
          ..write(')'))
        .toString();
  }
}

class $GrupoDefeitoEquipamentoTableTable extends GrupoDefeitoEquipamentoTable
    with
        TableInfo<$GrupoDefeitoEquipamentoTableTable,
            GrupoDefeitoEquipamentoTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GrupoDefeitoEquipamentoTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
      'uuid', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _sincronizadoMeta =
      const VerificationMeta('sincronizado');
  @override
  late final GeneratedColumn<bool> sincronizado = GeneratedColumn<bool>(
      'sincronizado', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("sincronizado" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _nomeMeta = const VerificationMeta('nome');
  @override
  late final GeneratedColumn<String> nome = GeneratedColumn<String>(
      'nome', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 2, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, uuid, createdAt, updatedAt, sincronizado, nome];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'grupo_defeito_equipamento_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<GrupoDefeitoEquipamentoTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('uuid')) {
      context.handle(
          _uuidMeta, uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta));
    } else if (isInserting) {
      context.missing(_uuidMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('sincronizado')) {
      context.handle(
          _sincronizadoMeta,
          sincronizado.isAcceptableOrUnknown(
              data['sincronizado']!, _sincronizadoMeta));
    }
    if (data.containsKey('nome')) {
      context.handle(
          _nomeMeta, nome.isAcceptableOrUnknown(data['nome']!, _nomeMeta));
    } else if (isInserting) {
      context.missing(_nomeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GrupoDefeitoEquipamentoTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GrupoDefeitoEquipamentoTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      uuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uuid'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      sincronizado: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}sincronizado'])!,
      nome: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nome'])!,
    );
  }

  @override
  $GrupoDefeitoEquipamentoTableTable createAlias(String alias) {
    return $GrupoDefeitoEquipamentoTableTable(attachedDatabase, alias);
  }
}

class GrupoDefeitoEquipamentoTableData extends DataClass
    implements Insertable<GrupoDefeitoEquipamentoTableData> {
  final int id;
  final String uuid;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool sincronizado;
  final String nome;
  const GrupoDefeitoEquipamentoTableData(
      {required this.id,
      required this.uuid,
      required this.createdAt,
      required this.updatedAt,
      required this.sincronizado,
      required this.nome});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['uuid'] = Variable<String>(uuid);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['sincronizado'] = Variable<bool>(sincronizado);
    map['nome'] = Variable<String>(nome);
    return map;
  }

  GrupoDefeitoEquipamentoTableCompanion toCompanion(bool nullToAbsent) {
    return GrupoDefeitoEquipamentoTableCompanion(
      id: Value(id),
      uuid: Value(uuid),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      sincronizado: Value(sincronizado),
      nome: Value(nome),
    );
  }

  factory GrupoDefeitoEquipamentoTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GrupoDefeitoEquipamentoTableData(
      id: serializer.fromJson<int>(json['id']),
      uuid: serializer.fromJson<String>(json['uuid']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      sincronizado: serializer.fromJson<bool>(json['sincronizado']),
      nome: serializer.fromJson<String>(json['nome']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'uuid': serializer.toJson<String>(uuid),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'sincronizado': serializer.toJson<bool>(sincronizado),
      'nome': serializer.toJson<String>(nome),
    };
  }

  GrupoDefeitoEquipamentoTableData copyWith(
          {int? id,
          String? uuid,
          DateTime? createdAt,
          DateTime? updatedAt,
          bool? sincronizado,
          String? nome}) =>
      GrupoDefeitoEquipamentoTableData(
        id: id ?? this.id,
        uuid: uuid ?? this.uuid,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        sincronizado: sincronizado ?? this.sincronizado,
        nome: nome ?? this.nome,
      );
  GrupoDefeitoEquipamentoTableData copyWithCompanion(
      GrupoDefeitoEquipamentoTableCompanion data) {
    return GrupoDefeitoEquipamentoTableData(
      id: data.id.present ? data.id.value : this.id,
      uuid: data.uuid.present ? data.uuid.value : this.uuid,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      sincronizado: data.sincronizado.present
          ? data.sincronizado.value
          : this.sincronizado,
      nome: data.nome.present ? data.nome.value : this.nome,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GrupoDefeitoEquipamentoTableData(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('sincronizado: $sincronizado, ')
          ..write('nome: $nome')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, uuid, createdAt, updatedAt, sincronizado, nome);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GrupoDefeitoEquipamentoTableData &&
          other.id == this.id &&
          other.uuid == this.uuid &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.sincronizado == this.sincronizado &&
          other.nome == this.nome);
}

class GrupoDefeitoEquipamentoTableCompanion
    extends UpdateCompanion<GrupoDefeitoEquipamentoTableData> {
  final Value<int> id;
  final Value<String> uuid;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<bool> sincronizado;
  final Value<String> nome;
  const GrupoDefeitoEquipamentoTableCompanion({
    this.id = const Value.absent(),
    this.uuid = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.sincronizado = const Value.absent(),
    this.nome = const Value.absent(),
  });
  GrupoDefeitoEquipamentoTableCompanion.insert({
    this.id = const Value.absent(),
    required String uuid,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.sincronizado = const Value.absent(),
    required String nome,
  })  : uuid = Value(uuid),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt),
        nome = Value(nome);
  static Insertable<GrupoDefeitoEquipamentoTableData> custom({
    Expression<int>? id,
    Expression<String>? uuid,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<bool>? sincronizado,
    Expression<String>? nome,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uuid != null) 'uuid': uuid,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (sincronizado != null) 'sincronizado': sincronizado,
      if (nome != null) 'nome': nome,
    });
  }

  GrupoDefeitoEquipamentoTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? uuid,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<bool>? sincronizado,
      Value<String>? nome}) {
    return GrupoDefeitoEquipamentoTableCompanion(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      sincronizado: sincronizado ?? this.sincronizado,
      nome: nome ?? this.nome,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (sincronizado.present) {
      map['sincronizado'] = Variable<bool>(sincronizado.value);
    }
    if (nome.present) {
      map['nome'] = Variable<String>(nome.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GrupoDefeitoEquipamentoTableCompanion(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('sincronizado: $sincronizado, ')
          ..write('nome: $nome')
          ..write(')'))
        .toString();
  }
}

class $SubgrupoDefeitoEquipamentoTableTable
    extends SubgrupoDefeitoEquipamentoTable
    with
        TableInfo<$SubgrupoDefeitoEquipamentoTableTable,
            SubgrupoDefeitoEquipamentoTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SubgrupoDefeitoEquipamentoTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
      'uuid', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _sincronizadoMeta =
      const VerificationMeta('sincronizado');
  @override
  late final GeneratedColumn<bool> sincronizado = GeneratedColumn<bool>(
      'sincronizado', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("sincronizado" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _nomeMeta = const VerificationMeta('nome');
  @override
  late final GeneratedColumn<String> nome = GeneratedColumn<String>(
      'nome', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 2, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, uuid, createdAt, updatedAt, sincronizado, nome];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'subgrupo_defeito_equipamento_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<SubgrupoDefeitoEquipamentoTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('uuid')) {
      context.handle(
          _uuidMeta, uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta));
    } else if (isInserting) {
      context.missing(_uuidMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('sincronizado')) {
      context.handle(
          _sincronizadoMeta,
          sincronizado.isAcceptableOrUnknown(
              data['sincronizado']!, _sincronizadoMeta));
    }
    if (data.containsKey('nome')) {
      context.handle(
          _nomeMeta, nome.isAcceptableOrUnknown(data['nome']!, _nomeMeta));
    } else if (isInserting) {
      context.missing(_nomeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SubgrupoDefeitoEquipamentoTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SubgrupoDefeitoEquipamentoTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      uuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uuid'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      sincronizado: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}sincronizado'])!,
      nome: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nome'])!,
    );
  }

  @override
  $SubgrupoDefeitoEquipamentoTableTable createAlias(String alias) {
    return $SubgrupoDefeitoEquipamentoTableTable(attachedDatabase, alias);
  }
}

class SubgrupoDefeitoEquipamentoTableData extends DataClass
    implements Insertable<SubgrupoDefeitoEquipamentoTableData> {
  final int id;
  final String uuid;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool sincronizado;
  final String nome;
  const SubgrupoDefeitoEquipamentoTableData(
      {required this.id,
      required this.uuid,
      required this.createdAt,
      required this.updatedAt,
      required this.sincronizado,
      required this.nome});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['uuid'] = Variable<String>(uuid);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['sincronizado'] = Variable<bool>(sincronizado);
    map['nome'] = Variable<String>(nome);
    return map;
  }

  SubgrupoDefeitoEquipamentoTableCompanion toCompanion(bool nullToAbsent) {
    return SubgrupoDefeitoEquipamentoTableCompanion(
      id: Value(id),
      uuid: Value(uuid),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      sincronizado: Value(sincronizado),
      nome: Value(nome),
    );
  }

  factory SubgrupoDefeitoEquipamentoTableData.fromJson(
      Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SubgrupoDefeitoEquipamentoTableData(
      id: serializer.fromJson<int>(json['id']),
      uuid: serializer.fromJson<String>(json['uuid']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      sincronizado: serializer.fromJson<bool>(json['sincronizado']),
      nome: serializer.fromJson<String>(json['nome']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'uuid': serializer.toJson<String>(uuid),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'sincronizado': serializer.toJson<bool>(sincronizado),
      'nome': serializer.toJson<String>(nome),
    };
  }

  SubgrupoDefeitoEquipamentoTableData copyWith(
          {int? id,
          String? uuid,
          DateTime? createdAt,
          DateTime? updatedAt,
          bool? sincronizado,
          String? nome}) =>
      SubgrupoDefeitoEquipamentoTableData(
        id: id ?? this.id,
        uuid: uuid ?? this.uuid,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        sincronizado: sincronizado ?? this.sincronizado,
        nome: nome ?? this.nome,
      );
  SubgrupoDefeitoEquipamentoTableData copyWithCompanion(
      SubgrupoDefeitoEquipamentoTableCompanion data) {
    return SubgrupoDefeitoEquipamentoTableData(
      id: data.id.present ? data.id.value : this.id,
      uuid: data.uuid.present ? data.uuid.value : this.uuid,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      sincronizado: data.sincronizado.present
          ? data.sincronizado.value
          : this.sincronizado,
      nome: data.nome.present ? data.nome.value : this.nome,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SubgrupoDefeitoEquipamentoTableData(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('sincronizado: $sincronizado, ')
          ..write('nome: $nome')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, uuid, createdAt, updatedAt, sincronizado, nome);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SubgrupoDefeitoEquipamentoTableData &&
          other.id == this.id &&
          other.uuid == this.uuid &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.sincronizado == this.sincronizado &&
          other.nome == this.nome);
}

class SubgrupoDefeitoEquipamentoTableCompanion
    extends UpdateCompanion<SubgrupoDefeitoEquipamentoTableData> {
  final Value<int> id;
  final Value<String> uuid;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<bool> sincronizado;
  final Value<String> nome;
  const SubgrupoDefeitoEquipamentoTableCompanion({
    this.id = const Value.absent(),
    this.uuid = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.sincronizado = const Value.absent(),
    this.nome = const Value.absent(),
  });
  SubgrupoDefeitoEquipamentoTableCompanion.insert({
    this.id = const Value.absent(),
    required String uuid,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.sincronizado = const Value.absent(),
    required String nome,
  })  : uuid = Value(uuid),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt),
        nome = Value(nome);
  static Insertable<SubgrupoDefeitoEquipamentoTableData> custom({
    Expression<int>? id,
    Expression<String>? uuid,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<bool>? sincronizado,
    Expression<String>? nome,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uuid != null) 'uuid': uuid,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (sincronizado != null) 'sincronizado': sincronizado,
      if (nome != null) 'nome': nome,
    });
  }

  SubgrupoDefeitoEquipamentoTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? uuid,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<bool>? sincronizado,
      Value<String>? nome}) {
    return SubgrupoDefeitoEquipamentoTableCompanion(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      sincronizado: sincronizado ?? this.sincronizado,
      nome: nome ?? this.nome,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (sincronizado.present) {
      map['sincronizado'] = Variable<bool>(sincronizado.value);
    }
    if (nome.present) {
      map['nome'] = Variable<String>(nome.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SubgrupoDefeitoEquipamentoTableCompanion(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('sincronizado: $sincronizado, ')
          ..write('nome: $nome')
          ..write(')'))
        .toString();
  }
}

class $EquipamentoTableTable extends EquipamentoTable
    with TableInfo<$EquipamentoTableTable, EquipamentoTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EquipamentoTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
      'uuid', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _sincronizadoMeta =
      const VerificationMeta('sincronizado');
  @override
  late final GeneratedColumn<bool> sincronizado = GeneratedColumn<bool>(
      'sincronizado', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("sincronizado" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _nomeMeta = const VerificationMeta('nome');
  @override
  late final GeneratedColumn<String> nome = GeneratedColumn<String>(
      'nome', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 2, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _descricaoMeta =
      const VerificationMeta('descricao');
  @override
  late final GeneratedColumn<String> descricao = GeneratedColumn<String>(
      'descricao', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 2, maxTextLength: 200),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _subestacaoMeta =
      const VerificationMeta('subestacao');
  @override
  late final GeneratedColumn<String> subestacao = GeneratedColumn<String>(
      'subestacao', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 3),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _grupoIdMeta =
      const VerificationMeta('grupoId');
  @override
  late final GeneratedColumn<int> grupoId = GeneratedColumn<int>(
      'grupo_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES grupo_defeito_equipamento_table (id)'));
  static const VerificationMeta _subgrupoIdMeta =
      const VerificationMeta('subgrupoId');
  @override
  late final GeneratedColumn<int> subgrupoId = GeneratedColumn<int>(
      'subgrupo_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES subgrupo_defeito_equipamento_table (id)'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        uuid,
        createdAt,
        updatedAt,
        sincronizado,
        nome,
        descricao,
        subestacao,
        grupoId,
        subgrupoId
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'equipamento_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<EquipamentoTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('uuid')) {
      context.handle(
          _uuidMeta, uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta));
    } else if (isInserting) {
      context.missing(_uuidMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('sincronizado')) {
      context.handle(
          _sincronizadoMeta,
          sincronizado.isAcceptableOrUnknown(
              data['sincronizado']!, _sincronizadoMeta));
    }
    if (data.containsKey('nome')) {
      context.handle(
          _nomeMeta, nome.isAcceptableOrUnknown(data['nome']!, _nomeMeta));
    } else if (isInserting) {
      context.missing(_nomeMeta);
    }
    if (data.containsKey('descricao')) {
      context.handle(_descricaoMeta,
          descricao.isAcceptableOrUnknown(data['descricao']!, _descricaoMeta));
    } else if (isInserting) {
      context.missing(_descricaoMeta);
    }
    if (data.containsKey('subestacao')) {
      context.handle(
          _subestacaoMeta,
          subestacao.isAcceptableOrUnknown(
              data['subestacao']!, _subestacaoMeta));
    } else if (isInserting) {
      context.missing(_subestacaoMeta);
    }
    if (data.containsKey('grupo_id')) {
      context.handle(_grupoIdMeta,
          grupoId.isAcceptableOrUnknown(data['grupo_id']!, _grupoIdMeta));
    } else if (isInserting) {
      context.missing(_grupoIdMeta);
    }
    if (data.containsKey('subgrupo_id')) {
      context.handle(
          _subgrupoIdMeta,
          subgrupoId.isAcceptableOrUnknown(
              data['subgrupo_id']!, _subgrupoIdMeta));
    } else if (isInserting) {
      context.missing(_subgrupoIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EquipamentoTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EquipamentoTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      uuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uuid'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      sincronizado: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}sincronizado'])!,
      nome: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nome'])!,
      descricao: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}descricao'])!,
      subestacao: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}subestacao'])!,
      grupoId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}grupo_id'])!,
      subgrupoId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}subgrupo_id'])!,
    );
  }

  @override
  $EquipamentoTableTable createAlias(String alias) {
    return $EquipamentoTableTable(attachedDatabase, alias);
  }
}

class EquipamentoTableData extends DataClass
    implements Insertable<EquipamentoTableData> {
  final int id;
  final String uuid;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool sincronizado;
  final String nome;
  final String descricao;
  final String subestacao;
  final int grupoId;
  final int subgrupoId;
  const EquipamentoTableData(
      {required this.id,
      required this.uuid,
      required this.createdAt,
      required this.updatedAt,
      required this.sincronizado,
      required this.nome,
      required this.descricao,
      required this.subestacao,
      required this.grupoId,
      required this.subgrupoId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['uuid'] = Variable<String>(uuid);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['sincronizado'] = Variable<bool>(sincronizado);
    map['nome'] = Variable<String>(nome);
    map['descricao'] = Variable<String>(descricao);
    map['subestacao'] = Variable<String>(subestacao);
    map['grupo_id'] = Variable<int>(grupoId);
    map['subgrupo_id'] = Variable<int>(subgrupoId);
    return map;
  }

  EquipamentoTableCompanion toCompanion(bool nullToAbsent) {
    return EquipamentoTableCompanion(
      id: Value(id),
      uuid: Value(uuid),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      sincronizado: Value(sincronizado),
      nome: Value(nome),
      descricao: Value(descricao),
      subestacao: Value(subestacao),
      grupoId: Value(grupoId),
      subgrupoId: Value(subgrupoId),
    );
  }

  factory EquipamentoTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EquipamentoTableData(
      id: serializer.fromJson<int>(json['id']),
      uuid: serializer.fromJson<String>(json['uuid']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      sincronizado: serializer.fromJson<bool>(json['sincronizado']),
      nome: serializer.fromJson<String>(json['nome']),
      descricao: serializer.fromJson<String>(json['descricao']),
      subestacao: serializer.fromJson<String>(json['subestacao']),
      grupoId: serializer.fromJson<int>(json['grupoId']),
      subgrupoId: serializer.fromJson<int>(json['subgrupoId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'uuid': serializer.toJson<String>(uuid),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'sincronizado': serializer.toJson<bool>(sincronizado),
      'nome': serializer.toJson<String>(nome),
      'descricao': serializer.toJson<String>(descricao),
      'subestacao': serializer.toJson<String>(subestacao),
      'grupoId': serializer.toJson<int>(grupoId),
      'subgrupoId': serializer.toJson<int>(subgrupoId),
    };
  }

  EquipamentoTableData copyWith(
          {int? id,
          String? uuid,
          DateTime? createdAt,
          DateTime? updatedAt,
          bool? sincronizado,
          String? nome,
          String? descricao,
          String? subestacao,
          int? grupoId,
          int? subgrupoId}) =>
      EquipamentoTableData(
        id: id ?? this.id,
        uuid: uuid ?? this.uuid,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        sincronizado: sincronizado ?? this.sincronizado,
        nome: nome ?? this.nome,
        descricao: descricao ?? this.descricao,
        subestacao: subestacao ?? this.subestacao,
        grupoId: grupoId ?? this.grupoId,
        subgrupoId: subgrupoId ?? this.subgrupoId,
      );
  EquipamentoTableData copyWithCompanion(EquipamentoTableCompanion data) {
    return EquipamentoTableData(
      id: data.id.present ? data.id.value : this.id,
      uuid: data.uuid.present ? data.uuid.value : this.uuid,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      sincronizado: data.sincronizado.present
          ? data.sincronizado.value
          : this.sincronizado,
      nome: data.nome.present ? data.nome.value : this.nome,
      descricao: data.descricao.present ? data.descricao.value : this.descricao,
      subestacao:
          data.subestacao.present ? data.subestacao.value : this.subestacao,
      grupoId: data.grupoId.present ? data.grupoId.value : this.grupoId,
      subgrupoId:
          data.subgrupoId.present ? data.subgrupoId.value : this.subgrupoId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EquipamentoTableData(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('sincronizado: $sincronizado, ')
          ..write('nome: $nome, ')
          ..write('descricao: $descricao, ')
          ..write('subestacao: $subestacao, ')
          ..write('grupoId: $grupoId, ')
          ..write('subgrupoId: $subgrupoId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, uuid, createdAt, updatedAt, sincronizado,
      nome, descricao, subestacao, grupoId, subgrupoId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EquipamentoTableData &&
          other.id == this.id &&
          other.uuid == this.uuid &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.sincronizado == this.sincronizado &&
          other.nome == this.nome &&
          other.descricao == this.descricao &&
          other.subestacao == this.subestacao &&
          other.grupoId == this.grupoId &&
          other.subgrupoId == this.subgrupoId);
}

class EquipamentoTableCompanion extends UpdateCompanion<EquipamentoTableData> {
  final Value<int> id;
  final Value<String> uuid;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<bool> sincronizado;
  final Value<String> nome;
  final Value<String> descricao;
  final Value<String> subestacao;
  final Value<int> grupoId;
  final Value<int> subgrupoId;
  const EquipamentoTableCompanion({
    this.id = const Value.absent(),
    this.uuid = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.sincronizado = const Value.absent(),
    this.nome = const Value.absent(),
    this.descricao = const Value.absent(),
    this.subestacao = const Value.absent(),
    this.grupoId = const Value.absent(),
    this.subgrupoId = const Value.absent(),
  });
  EquipamentoTableCompanion.insert({
    this.id = const Value.absent(),
    required String uuid,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.sincronizado = const Value.absent(),
    required String nome,
    required String descricao,
    required String subestacao,
    required int grupoId,
    required int subgrupoId,
  })  : uuid = Value(uuid),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt),
        nome = Value(nome),
        descricao = Value(descricao),
        subestacao = Value(subestacao),
        grupoId = Value(grupoId),
        subgrupoId = Value(subgrupoId);
  static Insertable<EquipamentoTableData> custom({
    Expression<int>? id,
    Expression<String>? uuid,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<bool>? sincronizado,
    Expression<String>? nome,
    Expression<String>? descricao,
    Expression<String>? subestacao,
    Expression<int>? grupoId,
    Expression<int>? subgrupoId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uuid != null) 'uuid': uuid,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (sincronizado != null) 'sincronizado': sincronizado,
      if (nome != null) 'nome': nome,
      if (descricao != null) 'descricao': descricao,
      if (subestacao != null) 'subestacao': subestacao,
      if (grupoId != null) 'grupo_id': grupoId,
      if (subgrupoId != null) 'subgrupo_id': subgrupoId,
    });
  }

  EquipamentoTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? uuid,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<bool>? sincronizado,
      Value<String>? nome,
      Value<String>? descricao,
      Value<String>? subestacao,
      Value<int>? grupoId,
      Value<int>? subgrupoId}) {
    return EquipamentoTableCompanion(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      sincronizado: sincronizado ?? this.sincronizado,
      nome: nome ?? this.nome,
      descricao: descricao ?? this.descricao,
      subestacao: subestacao ?? this.subestacao,
      grupoId: grupoId ?? this.grupoId,
      subgrupoId: subgrupoId ?? this.subgrupoId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (sincronizado.present) {
      map['sincronizado'] = Variable<bool>(sincronizado.value);
    }
    if (nome.present) {
      map['nome'] = Variable<String>(nome.value);
    }
    if (descricao.present) {
      map['descricao'] = Variable<String>(descricao.value);
    }
    if (subestacao.present) {
      map['subestacao'] = Variable<String>(subestacao.value);
    }
    if (grupoId.present) {
      map['grupo_id'] = Variable<int>(grupoId.value);
    }
    if (subgrupoId.present) {
      map['subgrupo_id'] = Variable<int>(subgrupoId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EquipamentoTableCompanion(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('sincronizado: $sincronizado, ')
          ..write('nome: $nome, ')
          ..write('descricao: $descricao, ')
          ..write('subestacao: $subestacao, ')
          ..write('grupoId: $grupoId, ')
          ..write('subgrupoId: $subgrupoId')
          ..write(')'))
        .toString();
  }
}

class $AtividadeTableTable extends AtividadeTable
    with TableInfo<$AtividadeTableTable, AtividadeTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AtividadeTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
      'uuid', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _sincronizadoMeta =
      const VerificationMeta('sincronizado');
  @override
  late final GeneratedColumn<bool> sincronizado = GeneratedColumn<bool>(
      'sincronizado', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("sincronizado" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _tituloMeta = const VerificationMeta('titulo');
  @override
  late final GeneratedColumn<String> titulo = GeneratedColumn<String>(
      'titulo', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 2, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _ordemServicoMeta =
      const VerificationMeta('ordemServico');
  @override
  late final GeneratedColumn<String> ordemServico = GeneratedColumn<String>(
      'ordem_servico', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 2, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _descricaoMeta =
      const VerificationMeta('descricao');
  @override
  late final GeneratedColumn<String> descricao = GeneratedColumn<String>(
      'descricao', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 2, maxTextLength: 200),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _dataLimiteMeta =
      const VerificationMeta('dataLimite');
  @override
  late final GeneratedColumn<DateTime> dataLimite = GeneratedColumn<DateTime>(
      'data_limite', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _subestacaoMeta =
      const VerificationMeta('subestacao');
  @override
  late final GeneratedColumn<String> subestacao = GeneratedColumn<String>(
      'subestacao', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 3),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _equipamentoIdMeta =
      const VerificationMeta('equipamentoId');
  @override
  late final GeneratedColumn<int> equipamentoId = GeneratedColumn<int>(
      'equipamento_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES equipamento_table (id)'));
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumnWithTypeConverter<StatusAtividade, String> status =
      GeneratedColumn<String>('status', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<StatusAtividade>(
              $AtividadeTableTable.$converterstatus);
  static const VerificationMeta _dataInicioMeta =
      const VerificationMeta('dataInicio');
  @override
  late final GeneratedColumn<DateTime> dataInicio = GeneratedColumn<DateTime>(
      'data_inicio', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _dataFimMeta =
      const VerificationMeta('dataFim');
  @override
  late final GeneratedColumn<DateTime> dataFim = GeneratedColumn<DateTime>(
      'data_fim', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _tipoAtividadeIdMeta =
      const VerificationMeta('tipoAtividadeId');
  @override
  late final GeneratedColumn<int> tipoAtividadeId = GeneratedColumn<int>(
      'tipo_atividade_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES tipo_atividade_table (id)'));
  static const VerificationMeta _tipoAtividadeMobileMeta =
      const VerificationMeta('tipoAtividadeMobile');
  @override
  late final GeneratedColumnWithTypeConverter<TipoAtividadeMobile, String>
      tipoAtividadeMobile = GeneratedColumn<String>(
              'tipo_atividade_mobile', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<TipoAtividadeMobile>(
              $AtividadeTableTable.$convertertipoAtividadeMobile);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        uuid,
        createdAt,
        updatedAt,
        sincronizado,
        titulo,
        ordemServico,
        descricao,
        dataLimite,
        subestacao,
        equipamentoId,
        status,
        dataInicio,
        dataFim,
        tipoAtividadeId,
        tipoAtividadeMobile
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'atividade_table';
  @override
  VerificationContext validateIntegrity(Insertable<AtividadeTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('uuid')) {
      context.handle(
          _uuidMeta, uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta));
    } else if (isInserting) {
      context.missing(_uuidMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('sincronizado')) {
      context.handle(
          _sincronizadoMeta,
          sincronizado.isAcceptableOrUnknown(
              data['sincronizado']!, _sincronizadoMeta));
    }
    if (data.containsKey('titulo')) {
      context.handle(_tituloMeta,
          titulo.isAcceptableOrUnknown(data['titulo']!, _tituloMeta));
    } else if (isInserting) {
      context.missing(_tituloMeta);
    }
    if (data.containsKey('ordem_servico')) {
      context.handle(
          _ordemServicoMeta,
          ordemServico.isAcceptableOrUnknown(
              data['ordem_servico']!, _ordemServicoMeta));
    } else if (isInserting) {
      context.missing(_ordemServicoMeta);
    }
    if (data.containsKey('descricao')) {
      context.handle(_descricaoMeta,
          descricao.isAcceptableOrUnknown(data['descricao']!, _descricaoMeta));
    } else if (isInserting) {
      context.missing(_descricaoMeta);
    }
    if (data.containsKey('data_limite')) {
      context.handle(
          _dataLimiteMeta,
          dataLimite.isAcceptableOrUnknown(
              data['data_limite']!, _dataLimiteMeta));
    } else if (isInserting) {
      context.missing(_dataLimiteMeta);
    }
    if (data.containsKey('subestacao')) {
      context.handle(
          _subestacaoMeta,
          subestacao.isAcceptableOrUnknown(
              data['subestacao']!, _subestacaoMeta));
    } else if (isInserting) {
      context.missing(_subestacaoMeta);
    }
    if (data.containsKey('equipamento_id')) {
      context.handle(
          _equipamentoIdMeta,
          equipamentoId.isAcceptableOrUnknown(
              data['equipamento_id']!, _equipamentoIdMeta));
    } else if (isInserting) {
      context.missing(_equipamentoIdMeta);
    }
    context.handle(_statusMeta, const VerificationResult.success());
    if (data.containsKey('data_inicio')) {
      context.handle(
          _dataInicioMeta,
          dataInicio.isAcceptableOrUnknown(
              data['data_inicio']!, _dataInicioMeta));
    }
    if (data.containsKey('data_fim')) {
      context.handle(_dataFimMeta,
          dataFim.isAcceptableOrUnknown(data['data_fim']!, _dataFimMeta));
    }
    if (data.containsKey('tipo_atividade_id')) {
      context.handle(
          _tipoAtividadeIdMeta,
          tipoAtividadeId.isAcceptableOrUnknown(
              data['tipo_atividade_id']!, _tipoAtividadeIdMeta));
    } else if (isInserting) {
      context.missing(_tipoAtividadeIdMeta);
    }
    context.handle(
        _tipoAtividadeMobileMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AtividadeTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AtividadeTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      uuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uuid'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      sincronizado: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}sincronizado'])!,
      titulo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}titulo'])!,
      ordemServico: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}ordem_servico'])!,
      descricao: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}descricao'])!,
      dataLimite: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}data_limite'])!,
      subestacao: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}subestacao'])!,
      equipamentoId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}equipamento_id'])!,
      status: $AtividadeTableTable.$converterstatus.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!),
      dataInicio: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}data_inicio']),
      dataFim: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}data_fim']),
      tipoAtividadeId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}tipo_atividade_id'])!,
      tipoAtividadeMobile: $AtividadeTableTable.$convertertipoAtividadeMobile
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}tipo_atividade_mobile'])!),
    );
  }

  @override
  $AtividadeTableTable createAlias(String alias) {
    return $AtividadeTableTable(attachedDatabase, alias);
  }

  static TypeConverter<StatusAtividade, String> $converterstatus =
      const StatusAtividadeConverter();
  static TypeConverter<TipoAtividadeMobile, String>
      $convertertipoAtividadeMobile = const TipoAtividadeMobileConverter();
}

class AtividadeTableData extends DataClass
    implements Insertable<AtividadeTableData> {
  final int id;
  final String uuid;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool sincronizado;
  final String titulo;
  final String ordemServico;
  final String descricao;
  final DateTime dataLimite;
  final String subestacao;
  final int equipamentoId;
  final StatusAtividade status;
  final DateTime? dataInicio;
  final DateTime? dataFim;
  final int tipoAtividadeId;
  final TipoAtividadeMobile tipoAtividadeMobile;
  const AtividadeTableData(
      {required this.id,
      required this.uuid,
      required this.createdAt,
      required this.updatedAt,
      required this.sincronizado,
      required this.titulo,
      required this.ordemServico,
      required this.descricao,
      required this.dataLimite,
      required this.subestacao,
      required this.equipamentoId,
      required this.status,
      this.dataInicio,
      this.dataFim,
      required this.tipoAtividadeId,
      required this.tipoAtividadeMobile});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['uuid'] = Variable<String>(uuid);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['sincronizado'] = Variable<bool>(sincronizado);
    map['titulo'] = Variable<String>(titulo);
    map['ordem_servico'] = Variable<String>(ordemServico);
    map['descricao'] = Variable<String>(descricao);
    map['data_limite'] = Variable<DateTime>(dataLimite);
    map['subestacao'] = Variable<String>(subestacao);
    map['equipamento_id'] = Variable<int>(equipamentoId);
    {
      map['status'] =
          Variable<String>($AtividadeTableTable.$converterstatus.toSql(status));
    }
    if (!nullToAbsent || dataInicio != null) {
      map['data_inicio'] = Variable<DateTime>(dataInicio);
    }
    if (!nullToAbsent || dataFim != null) {
      map['data_fim'] = Variable<DateTime>(dataFim);
    }
    map['tipo_atividade_id'] = Variable<int>(tipoAtividadeId);
    {
      map['tipo_atividade_mobile'] = Variable<String>($AtividadeTableTable
          .$convertertipoAtividadeMobile
          .toSql(tipoAtividadeMobile));
    }
    return map;
  }

  AtividadeTableCompanion toCompanion(bool nullToAbsent) {
    return AtividadeTableCompanion(
      id: Value(id),
      uuid: Value(uuid),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      sincronizado: Value(sincronizado),
      titulo: Value(titulo),
      ordemServico: Value(ordemServico),
      descricao: Value(descricao),
      dataLimite: Value(dataLimite),
      subestacao: Value(subestacao),
      equipamentoId: Value(equipamentoId),
      status: Value(status),
      dataInicio: dataInicio == null && nullToAbsent
          ? const Value.absent()
          : Value(dataInicio),
      dataFim: dataFim == null && nullToAbsent
          ? const Value.absent()
          : Value(dataFim),
      tipoAtividadeId: Value(tipoAtividadeId),
      tipoAtividadeMobile: Value(tipoAtividadeMobile),
    );
  }

  factory AtividadeTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AtividadeTableData(
      id: serializer.fromJson<int>(json['id']),
      uuid: serializer.fromJson<String>(json['uuid']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      sincronizado: serializer.fromJson<bool>(json['sincronizado']),
      titulo: serializer.fromJson<String>(json['titulo']),
      ordemServico: serializer.fromJson<String>(json['ordemServico']),
      descricao: serializer.fromJson<String>(json['descricao']),
      dataLimite: serializer.fromJson<DateTime>(json['dataLimite']),
      subestacao: serializer.fromJson<String>(json['subestacao']),
      equipamentoId: serializer.fromJson<int>(json['equipamentoId']),
      status: serializer.fromJson<StatusAtividade>(json['status']),
      dataInicio: serializer.fromJson<DateTime?>(json['dataInicio']),
      dataFim: serializer.fromJson<DateTime?>(json['dataFim']),
      tipoAtividadeId: serializer.fromJson<int>(json['tipoAtividadeId']),
      tipoAtividadeMobile:
          serializer.fromJson<TipoAtividadeMobile>(json['tipoAtividadeMobile']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'uuid': serializer.toJson<String>(uuid),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'sincronizado': serializer.toJson<bool>(sincronizado),
      'titulo': serializer.toJson<String>(titulo),
      'ordemServico': serializer.toJson<String>(ordemServico),
      'descricao': serializer.toJson<String>(descricao),
      'dataLimite': serializer.toJson<DateTime>(dataLimite),
      'subestacao': serializer.toJson<String>(subestacao),
      'equipamentoId': serializer.toJson<int>(equipamentoId),
      'status': serializer.toJson<StatusAtividade>(status),
      'dataInicio': serializer.toJson<DateTime?>(dataInicio),
      'dataFim': serializer.toJson<DateTime?>(dataFim),
      'tipoAtividadeId': serializer.toJson<int>(tipoAtividadeId),
      'tipoAtividadeMobile':
          serializer.toJson<TipoAtividadeMobile>(tipoAtividadeMobile),
    };
  }

  AtividadeTableData copyWith(
          {int? id,
          String? uuid,
          DateTime? createdAt,
          DateTime? updatedAt,
          bool? sincronizado,
          String? titulo,
          String? ordemServico,
          String? descricao,
          DateTime? dataLimite,
          String? subestacao,
          int? equipamentoId,
          StatusAtividade? status,
          Value<DateTime?> dataInicio = const Value.absent(),
          Value<DateTime?> dataFim = const Value.absent(),
          int? tipoAtividadeId,
          TipoAtividadeMobile? tipoAtividadeMobile}) =>
      AtividadeTableData(
        id: id ?? this.id,
        uuid: uuid ?? this.uuid,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        sincronizado: sincronizado ?? this.sincronizado,
        titulo: titulo ?? this.titulo,
        ordemServico: ordemServico ?? this.ordemServico,
        descricao: descricao ?? this.descricao,
        dataLimite: dataLimite ?? this.dataLimite,
        subestacao: subestacao ?? this.subestacao,
        equipamentoId: equipamentoId ?? this.equipamentoId,
        status: status ?? this.status,
        dataInicio: dataInicio.present ? dataInicio.value : this.dataInicio,
        dataFim: dataFim.present ? dataFim.value : this.dataFim,
        tipoAtividadeId: tipoAtividadeId ?? this.tipoAtividadeId,
        tipoAtividadeMobile: tipoAtividadeMobile ?? this.tipoAtividadeMobile,
      );
  AtividadeTableData copyWithCompanion(AtividadeTableCompanion data) {
    return AtividadeTableData(
      id: data.id.present ? data.id.value : this.id,
      uuid: data.uuid.present ? data.uuid.value : this.uuid,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      sincronizado: data.sincronizado.present
          ? data.sincronizado.value
          : this.sincronizado,
      titulo: data.titulo.present ? data.titulo.value : this.titulo,
      ordemServico: data.ordemServico.present
          ? data.ordemServico.value
          : this.ordemServico,
      descricao: data.descricao.present ? data.descricao.value : this.descricao,
      dataLimite:
          data.dataLimite.present ? data.dataLimite.value : this.dataLimite,
      subestacao:
          data.subestacao.present ? data.subestacao.value : this.subestacao,
      equipamentoId: data.equipamentoId.present
          ? data.equipamentoId.value
          : this.equipamentoId,
      status: data.status.present ? data.status.value : this.status,
      dataInicio:
          data.dataInicio.present ? data.dataInicio.value : this.dataInicio,
      dataFim: data.dataFim.present ? data.dataFim.value : this.dataFim,
      tipoAtividadeId: data.tipoAtividadeId.present
          ? data.tipoAtividadeId.value
          : this.tipoAtividadeId,
      tipoAtividadeMobile: data.tipoAtividadeMobile.present
          ? data.tipoAtividadeMobile.value
          : this.tipoAtividadeMobile,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AtividadeTableData(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('sincronizado: $sincronizado, ')
          ..write('titulo: $titulo, ')
          ..write('ordemServico: $ordemServico, ')
          ..write('descricao: $descricao, ')
          ..write('dataLimite: $dataLimite, ')
          ..write('subestacao: $subestacao, ')
          ..write('equipamentoId: $equipamentoId, ')
          ..write('status: $status, ')
          ..write('dataInicio: $dataInicio, ')
          ..write('dataFim: $dataFim, ')
          ..write('tipoAtividadeId: $tipoAtividadeId, ')
          ..write('tipoAtividadeMobile: $tipoAtividadeMobile')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      uuid,
      createdAt,
      updatedAt,
      sincronizado,
      titulo,
      ordemServico,
      descricao,
      dataLimite,
      subestacao,
      equipamentoId,
      status,
      dataInicio,
      dataFim,
      tipoAtividadeId,
      tipoAtividadeMobile);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AtividadeTableData &&
          other.id == this.id &&
          other.uuid == this.uuid &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.sincronizado == this.sincronizado &&
          other.titulo == this.titulo &&
          other.ordemServico == this.ordemServico &&
          other.descricao == this.descricao &&
          other.dataLimite == this.dataLimite &&
          other.subestacao == this.subestacao &&
          other.equipamentoId == this.equipamentoId &&
          other.status == this.status &&
          other.dataInicio == this.dataInicio &&
          other.dataFim == this.dataFim &&
          other.tipoAtividadeId == this.tipoAtividadeId &&
          other.tipoAtividadeMobile == this.tipoAtividadeMobile);
}

class AtividadeTableCompanion extends UpdateCompanion<AtividadeTableData> {
  final Value<int> id;
  final Value<String> uuid;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<bool> sincronizado;
  final Value<String> titulo;
  final Value<String> ordemServico;
  final Value<String> descricao;
  final Value<DateTime> dataLimite;
  final Value<String> subestacao;
  final Value<int> equipamentoId;
  final Value<StatusAtividade> status;
  final Value<DateTime?> dataInicio;
  final Value<DateTime?> dataFim;
  final Value<int> tipoAtividadeId;
  final Value<TipoAtividadeMobile> tipoAtividadeMobile;
  const AtividadeTableCompanion({
    this.id = const Value.absent(),
    this.uuid = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.sincronizado = const Value.absent(),
    this.titulo = const Value.absent(),
    this.ordemServico = const Value.absent(),
    this.descricao = const Value.absent(),
    this.dataLimite = const Value.absent(),
    this.subestacao = const Value.absent(),
    this.equipamentoId = const Value.absent(),
    this.status = const Value.absent(),
    this.dataInicio = const Value.absent(),
    this.dataFim = const Value.absent(),
    this.tipoAtividadeId = const Value.absent(),
    this.tipoAtividadeMobile = const Value.absent(),
  });
  AtividadeTableCompanion.insert({
    this.id = const Value.absent(),
    required String uuid,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.sincronizado = const Value.absent(),
    required String titulo,
    required String ordemServico,
    required String descricao,
    required DateTime dataLimite,
    required String subestacao,
    required int equipamentoId,
    required StatusAtividade status,
    this.dataInicio = const Value.absent(),
    this.dataFim = const Value.absent(),
    required int tipoAtividadeId,
    required TipoAtividadeMobile tipoAtividadeMobile,
  })  : uuid = Value(uuid),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt),
        titulo = Value(titulo),
        ordemServico = Value(ordemServico),
        descricao = Value(descricao),
        dataLimite = Value(dataLimite),
        subestacao = Value(subestacao),
        equipamentoId = Value(equipamentoId),
        status = Value(status),
        tipoAtividadeId = Value(tipoAtividadeId),
        tipoAtividadeMobile = Value(tipoAtividadeMobile);
  static Insertable<AtividadeTableData> custom({
    Expression<int>? id,
    Expression<String>? uuid,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<bool>? sincronizado,
    Expression<String>? titulo,
    Expression<String>? ordemServico,
    Expression<String>? descricao,
    Expression<DateTime>? dataLimite,
    Expression<String>? subestacao,
    Expression<int>? equipamentoId,
    Expression<String>? status,
    Expression<DateTime>? dataInicio,
    Expression<DateTime>? dataFim,
    Expression<int>? tipoAtividadeId,
    Expression<String>? tipoAtividadeMobile,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uuid != null) 'uuid': uuid,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (sincronizado != null) 'sincronizado': sincronizado,
      if (titulo != null) 'titulo': titulo,
      if (ordemServico != null) 'ordem_servico': ordemServico,
      if (descricao != null) 'descricao': descricao,
      if (dataLimite != null) 'data_limite': dataLimite,
      if (subestacao != null) 'subestacao': subestacao,
      if (equipamentoId != null) 'equipamento_id': equipamentoId,
      if (status != null) 'status': status,
      if (dataInicio != null) 'data_inicio': dataInicio,
      if (dataFim != null) 'data_fim': dataFim,
      if (tipoAtividadeId != null) 'tipo_atividade_id': tipoAtividadeId,
      if (tipoAtividadeMobile != null)
        'tipo_atividade_mobile': tipoAtividadeMobile,
    });
  }

  AtividadeTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? uuid,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<bool>? sincronizado,
      Value<String>? titulo,
      Value<String>? ordemServico,
      Value<String>? descricao,
      Value<DateTime>? dataLimite,
      Value<String>? subestacao,
      Value<int>? equipamentoId,
      Value<StatusAtividade>? status,
      Value<DateTime?>? dataInicio,
      Value<DateTime?>? dataFim,
      Value<int>? tipoAtividadeId,
      Value<TipoAtividadeMobile>? tipoAtividadeMobile}) {
    return AtividadeTableCompanion(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      sincronizado: sincronizado ?? this.sincronizado,
      titulo: titulo ?? this.titulo,
      ordemServico: ordemServico ?? this.ordemServico,
      descricao: descricao ?? this.descricao,
      dataLimite: dataLimite ?? this.dataLimite,
      subestacao: subestacao ?? this.subestacao,
      equipamentoId: equipamentoId ?? this.equipamentoId,
      status: status ?? this.status,
      dataInicio: dataInicio ?? this.dataInicio,
      dataFim: dataFim ?? this.dataFim,
      tipoAtividadeId: tipoAtividadeId ?? this.tipoAtividadeId,
      tipoAtividadeMobile: tipoAtividadeMobile ?? this.tipoAtividadeMobile,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (sincronizado.present) {
      map['sincronizado'] = Variable<bool>(sincronizado.value);
    }
    if (titulo.present) {
      map['titulo'] = Variable<String>(titulo.value);
    }
    if (ordemServico.present) {
      map['ordem_servico'] = Variable<String>(ordemServico.value);
    }
    if (descricao.present) {
      map['descricao'] = Variable<String>(descricao.value);
    }
    if (dataLimite.present) {
      map['data_limite'] = Variable<DateTime>(dataLimite.value);
    }
    if (subestacao.present) {
      map['subestacao'] = Variable<String>(subestacao.value);
    }
    if (equipamentoId.present) {
      map['equipamento_id'] = Variable<int>(equipamentoId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
          $AtividadeTableTable.$converterstatus.toSql(status.value));
    }
    if (dataInicio.present) {
      map['data_inicio'] = Variable<DateTime>(dataInicio.value);
    }
    if (dataFim.present) {
      map['data_fim'] = Variable<DateTime>(dataFim.value);
    }
    if (tipoAtividadeId.present) {
      map['tipo_atividade_id'] = Variable<int>(tipoAtividadeId.value);
    }
    if (tipoAtividadeMobile.present) {
      map['tipo_atividade_mobile'] = Variable<String>($AtividadeTableTable
          .$convertertipoAtividadeMobile
          .toSql(tipoAtividadeMobile.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AtividadeTableCompanion(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('sincronizado: $sincronizado, ')
          ..write('titulo: $titulo, ')
          ..write('ordemServico: $ordemServico, ')
          ..write('descricao: $descricao, ')
          ..write('dataLimite: $dataLimite, ')
          ..write('subestacao: $subestacao, ')
          ..write('equipamentoId: $equipamentoId, ')
          ..write('status: $status, ')
          ..write('dataInicio: $dataInicio, ')
          ..write('dataFim: $dataFim, ')
          ..write('tipoAtividadeId: $tipoAtividadeId, ')
          ..write('tipoAtividadeMobile: $tipoAtividadeMobile')
          ..write(')'))
        .toString();
  }
}

class $AprTableTable extends AprTable
    with TableInfo<$AprTableTable, AprTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AprTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
      'uuid', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _sincronizadoMeta =
      const VerificationMeta('sincronizado');
  @override
  late final GeneratedColumn<bool> sincronizado = GeneratedColumn<bool>(
      'sincronizado', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("sincronizado" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _nomeMeta = const VerificationMeta('nome');
  @override
  late final GeneratedColumn<String> nome = GeneratedColumn<String>(
      'nome', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descricaoMeta =
      const VerificationMeta('descricao');
  @override
  late final GeneratedColumn<String> descricao = GeneratedColumn<String>(
      'descricao', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, uuid, createdAt, updatedAt, sincronizado, nome, descricao];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'apr_table';
  @override
  VerificationContext validateIntegrity(Insertable<AprTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('uuid')) {
      context.handle(
          _uuidMeta, uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta));
    } else if (isInserting) {
      context.missing(_uuidMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('sincronizado')) {
      context.handle(
          _sincronizadoMeta,
          sincronizado.isAcceptableOrUnknown(
              data['sincronizado']!, _sincronizadoMeta));
    }
    if (data.containsKey('nome')) {
      context.handle(
          _nomeMeta, nome.isAcceptableOrUnknown(data['nome']!, _nomeMeta));
    } else if (isInserting) {
      context.missing(_nomeMeta);
    }
    if (data.containsKey('descricao')) {
      context.handle(_descricaoMeta,
          descricao.isAcceptableOrUnknown(data['descricao']!, _descricaoMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AprTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AprTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      uuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uuid'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      sincronizado: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}sincronizado'])!,
      nome: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nome'])!,
      descricao: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}descricao']),
    );
  }

  @override
  $AprTableTable createAlias(String alias) {
    return $AprTableTable(attachedDatabase, alias);
  }
}

class AprTableData extends DataClass implements Insertable<AprTableData> {
  final int id;
  final String uuid;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool sincronizado;
  final String nome;
  final String? descricao;
  const AprTableData(
      {required this.id,
      required this.uuid,
      required this.createdAt,
      required this.updatedAt,
      required this.sincronizado,
      required this.nome,
      this.descricao});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['uuid'] = Variable<String>(uuid);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['sincronizado'] = Variable<bool>(sincronizado);
    map['nome'] = Variable<String>(nome);
    if (!nullToAbsent || descricao != null) {
      map['descricao'] = Variable<String>(descricao);
    }
    return map;
  }

  AprTableCompanion toCompanion(bool nullToAbsent) {
    return AprTableCompanion(
      id: Value(id),
      uuid: Value(uuid),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      sincronizado: Value(sincronizado),
      nome: Value(nome),
      descricao: descricao == null && nullToAbsent
          ? const Value.absent()
          : Value(descricao),
    );
  }

  factory AprTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AprTableData(
      id: serializer.fromJson<int>(json['id']),
      uuid: serializer.fromJson<String>(json['uuid']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      sincronizado: serializer.fromJson<bool>(json['sincronizado']),
      nome: serializer.fromJson<String>(json['nome']),
      descricao: serializer.fromJson<String?>(json['descricao']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'uuid': serializer.toJson<String>(uuid),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'sincronizado': serializer.toJson<bool>(sincronizado),
      'nome': serializer.toJson<String>(nome),
      'descricao': serializer.toJson<String?>(descricao),
    };
  }

  AprTableData copyWith(
          {int? id,
          String? uuid,
          DateTime? createdAt,
          DateTime? updatedAt,
          bool? sincronizado,
          String? nome,
          Value<String?> descricao = const Value.absent()}) =>
      AprTableData(
        id: id ?? this.id,
        uuid: uuid ?? this.uuid,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        sincronizado: sincronizado ?? this.sincronizado,
        nome: nome ?? this.nome,
        descricao: descricao.present ? descricao.value : this.descricao,
      );
  AprTableData copyWithCompanion(AprTableCompanion data) {
    return AprTableData(
      id: data.id.present ? data.id.value : this.id,
      uuid: data.uuid.present ? data.uuid.value : this.uuid,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      sincronizado: data.sincronizado.present
          ? data.sincronizado.value
          : this.sincronizado,
      nome: data.nome.present ? data.nome.value : this.nome,
      descricao: data.descricao.present ? data.descricao.value : this.descricao,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AprTableData(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('sincronizado: $sincronizado, ')
          ..write('nome: $nome, ')
          ..write('descricao: $descricao')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, uuid, createdAt, updatedAt, sincronizado, nome, descricao);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AprTableData &&
          other.id == this.id &&
          other.uuid == this.uuid &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.sincronizado == this.sincronizado &&
          other.nome == this.nome &&
          other.descricao == this.descricao);
}

class AprTableCompanion extends UpdateCompanion<AprTableData> {
  final Value<int> id;
  final Value<String> uuid;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<bool> sincronizado;
  final Value<String> nome;
  final Value<String?> descricao;
  const AprTableCompanion({
    this.id = const Value.absent(),
    this.uuid = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.sincronizado = const Value.absent(),
    this.nome = const Value.absent(),
    this.descricao = const Value.absent(),
  });
  AprTableCompanion.insert({
    this.id = const Value.absent(),
    required String uuid,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.sincronizado = const Value.absent(),
    required String nome,
    this.descricao = const Value.absent(),
  })  : uuid = Value(uuid),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt),
        nome = Value(nome);
  static Insertable<AprTableData> custom({
    Expression<int>? id,
    Expression<String>? uuid,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<bool>? sincronizado,
    Expression<String>? nome,
    Expression<String>? descricao,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uuid != null) 'uuid': uuid,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (sincronizado != null) 'sincronizado': sincronizado,
      if (nome != null) 'nome': nome,
      if (descricao != null) 'descricao': descricao,
    });
  }

  AprTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? uuid,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<bool>? sincronizado,
      Value<String>? nome,
      Value<String?>? descricao}) {
    return AprTableCompanion(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      sincronizado: sincronizado ?? this.sincronizado,
      nome: nome ?? this.nome,
      descricao: descricao ?? this.descricao,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (sincronizado.present) {
      map['sincronizado'] = Variable<bool>(sincronizado.value);
    }
    if (nome.present) {
      map['nome'] = Variable<String>(nome.value);
    }
    if (descricao.present) {
      map['descricao'] = Variable<String>(descricao.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AprTableCompanion(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('sincronizado: $sincronizado, ')
          ..write('nome: $nome, ')
          ..write('descricao: $descricao')
          ..write(')'))
        .toString();
  }
}

class $AprQuestionTableTable extends AprQuestionTable
    with TableInfo<$AprQuestionTableTable, AprQuestionTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AprQuestionTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
      'uuid', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _sincronizadoMeta =
      const VerificationMeta('sincronizado');
  @override
  late final GeneratedColumn<bool> sincronizado = GeneratedColumn<bool>(
      'sincronizado', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("sincronizado" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _textoMeta = const VerificationMeta('texto');
  @override
  late final GeneratedColumn<String> texto = GeneratedColumn<String>(
      'texto', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, uuid, createdAt, updatedAt, sincronizado, texto];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'apr_question_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<AprQuestionTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('uuid')) {
      context.handle(
          _uuidMeta, uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta));
    } else if (isInserting) {
      context.missing(_uuidMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('sincronizado')) {
      context.handle(
          _sincronizadoMeta,
          sincronizado.isAcceptableOrUnknown(
              data['sincronizado']!, _sincronizadoMeta));
    }
    if (data.containsKey('texto')) {
      context.handle(
          _textoMeta, texto.isAcceptableOrUnknown(data['texto']!, _textoMeta));
    } else if (isInserting) {
      context.missing(_textoMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AprQuestionTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AprQuestionTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      uuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uuid'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      sincronizado: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}sincronizado'])!,
      texto: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}texto'])!,
    );
  }

  @override
  $AprQuestionTableTable createAlias(String alias) {
    return $AprQuestionTableTable(attachedDatabase, alias);
  }
}

class AprQuestionTableData extends DataClass
    implements Insertable<AprQuestionTableData> {
  final int id;
  final String uuid;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool sincronizado;
  final String texto;
  const AprQuestionTableData(
      {required this.id,
      required this.uuid,
      required this.createdAt,
      required this.updatedAt,
      required this.sincronizado,
      required this.texto});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['uuid'] = Variable<String>(uuid);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['sincronizado'] = Variable<bool>(sincronizado);
    map['texto'] = Variable<String>(texto);
    return map;
  }

  AprQuestionTableCompanion toCompanion(bool nullToAbsent) {
    return AprQuestionTableCompanion(
      id: Value(id),
      uuid: Value(uuid),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      sincronizado: Value(sincronizado),
      texto: Value(texto),
    );
  }

  factory AprQuestionTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AprQuestionTableData(
      id: serializer.fromJson<int>(json['id']),
      uuid: serializer.fromJson<String>(json['uuid']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      sincronizado: serializer.fromJson<bool>(json['sincronizado']),
      texto: serializer.fromJson<String>(json['texto']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'uuid': serializer.toJson<String>(uuid),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'sincronizado': serializer.toJson<bool>(sincronizado),
      'texto': serializer.toJson<String>(texto),
    };
  }

  AprQuestionTableData copyWith(
          {int? id,
          String? uuid,
          DateTime? createdAt,
          DateTime? updatedAt,
          bool? sincronizado,
          String? texto}) =>
      AprQuestionTableData(
        id: id ?? this.id,
        uuid: uuid ?? this.uuid,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        sincronizado: sincronizado ?? this.sincronizado,
        texto: texto ?? this.texto,
      );
  AprQuestionTableData copyWithCompanion(AprQuestionTableCompanion data) {
    return AprQuestionTableData(
      id: data.id.present ? data.id.value : this.id,
      uuid: data.uuid.present ? data.uuid.value : this.uuid,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      sincronizado: data.sincronizado.present
          ? data.sincronizado.value
          : this.sincronizado,
      texto: data.texto.present ? data.texto.value : this.texto,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AprQuestionTableData(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('sincronizado: $sincronizado, ')
          ..write('texto: $texto')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, uuid, createdAt, updatedAt, sincronizado, texto);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AprQuestionTableData &&
          other.id == this.id &&
          other.uuid == this.uuid &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.sincronizado == this.sincronizado &&
          other.texto == this.texto);
}

class AprQuestionTableCompanion extends UpdateCompanion<AprQuestionTableData> {
  final Value<int> id;
  final Value<String> uuid;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<bool> sincronizado;
  final Value<String> texto;
  const AprQuestionTableCompanion({
    this.id = const Value.absent(),
    this.uuid = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.sincronizado = const Value.absent(),
    this.texto = const Value.absent(),
  });
  AprQuestionTableCompanion.insert({
    this.id = const Value.absent(),
    required String uuid,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.sincronizado = const Value.absent(),
    required String texto,
  })  : uuid = Value(uuid),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt),
        texto = Value(texto);
  static Insertable<AprQuestionTableData> custom({
    Expression<int>? id,
    Expression<String>? uuid,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<bool>? sincronizado,
    Expression<String>? texto,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uuid != null) 'uuid': uuid,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (sincronizado != null) 'sincronizado': sincronizado,
      if (texto != null) 'texto': texto,
    });
  }

  AprQuestionTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? uuid,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<bool>? sincronizado,
      Value<String>? texto}) {
    return AprQuestionTableCompanion(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      sincronizado: sincronizado ?? this.sincronizado,
      texto: texto ?? this.texto,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (sincronizado.present) {
      map['sincronizado'] = Variable<bool>(sincronizado.value);
    }
    if (texto.present) {
      map['texto'] = Variable<String>(texto.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AprQuestionTableCompanion(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('sincronizado: $sincronizado, ')
          ..write('texto: $texto')
          ..write(')'))
        .toString();
  }
}

class $AprPreenchidaTableTable extends AprPreenchidaTable
    with TableInfo<$AprPreenchidaTableTable, AprPreenchidaTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AprPreenchidaTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _atividadeIdMeta =
      const VerificationMeta('atividadeId');
  @override
  late final GeneratedColumn<int> atividadeId = GeneratedColumn<int>(
      'atividade_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES atividade_table (id)'));
  static const VerificationMeta _aprIdMeta = const VerificationMeta('aprId');
  @override
  late final GeneratedColumn<int> aprId = GeneratedColumn<int>(
      'apr_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES apr_table (id)'));
  static const VerificationMeta _usuarioIdMeta =
      const VerificationMeta('usuarioId');
  @override
  late final GeneratedColumn<int> usuarioId = GeneratedColumn<int>(
      'usuario_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES usuario_table (id)'));
  static const VerificationMeta _dataPreenchimentoMeta =
      const VerificationMeta('dataPreenchimento');
  @override
  late final GeneratedColumn<DateTime> dataPreenchimento =
      GeneratedColumn<DateTime>('data_preenchimento', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, atividadeId, aprId, usuarioId, dataPreenchimento];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'apr_preenchida_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<AprPreenchidaTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('atividade_id')) {
      context.handle(
          _atividadeIdMeta,
          atividadeId.isAcceptableOrUnknown(
              data['atividade_id']!, _atividadeIdMeta));
    } else if (isInserting) {
      context.missing(_atividadeIdMeta);
    }
    if (data.containsKey('apr_id')) {
      context.handle(
          _aprIdMeta, aprId.isAcceptableOrUnknown(data['apr_id']!, _aprIdMeta));
    } else if (isInserting) {
      context.missing(_aprIdMeta);
    }
    if (data.containsKey('usuario_id')) {
      context.handle(_usuarioIdMeta,
          usuarioId.isAcceptableOrUnknown(data['usuario_id']!, _usuarioIdMeta));
    } else if (isInserting) {
      context.missing(_usuarioIdMeta);
    }
    if (data.containsKey('data_preenchimento')) {
      context.handle(
          _dataPreenchimentoMeta,
          dataPreenchimento.isAcceptableOrUnknown(
              data['data_preenchimento']!, _dataPreenchimentoMeta));
    } else if (isInserting) {
      context.missing(_dataPreenchimentoMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AprPreenchidaTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AprPreenchidaTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      atividadeId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}atividade_id'])!,
      aprId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}apr_id'])!,
      usuarioId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}usuario_id'])!,
      dataPreenchimento: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}data_preenchimento'])!,
    );
  }

  @override
  $AprPreenchidaTableTable createAlias(String alias) {
    return $AprPreenchidaTableTable(attachedDatabase, alias);
  }
}

class AprPreenchidaTableData extends DataClass
    implements Insertable<AprPreenchidaTableData> {
  final int id;
  final int atividadeId;
  final int aprId;
  final int usuarioId;
  final DateTime dataPreenchimento;
  const AprPreenchidaTableData(
      {required this.id,
      required this.atividadeId,
      required this.aprId,
      required this.usuarioId,
      required this.dataPreenchimento});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['atividade_id'] = Variable<int>(atividadeId);
    map['apr_id'] = Variable<int>(aprId);
    map['usuario_id'] = Variable<int>(usuarioId);
    map['data_preenchimento'] = Variable<DateTime>(dataPreenchimento);
    return map;
  }

  AprPreenchidaTableCompanion toCompanion(bool nullToAbsent) {
    return AprPreenchidaTableCompanion(
      id: Value(id),
      atividadeId: Value(atividadeId),
      aprId: Value(aprId),
      usuarioId: Value(usuarioId),
      dataPreenchimento: Value(dataPreenchimento),
    );
  }

  factory AprPreenchidaTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AprPreenchidaTableData(
      id: serializer.fromJson<int>(json['id']),
      atividadeId: serializer.fromJson<int>(json['atividadeId']),
      aprId: serializer.fromJson<int>(json['aprId']),
      usuarioId: serializer.fromJson<int>(json['usuarioId']),
      dataPreenchimento:
          serializer.fromJson<DateTime>(json['dataPreenchimento']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'atividadeId': serializer.toJson<int>(atividadeId),
      'aprId': serializer.toJson<int>(aprId),
      'usuarioId': serializer.toJson<int>(usuarioId),
      'dataPreenchimento': serializer.toJson<DateTime>(dataPreenchimento),
    };
  }

  AprPreenchidaTableData copyWith(
          {int? id,
          int? atividadeId,
          int? aprId,
          int? usuarioId,
          DateTime? dataPreenchimento}) =>
      AprPreenchidaTableData(
        id: id ?? this.id,
        atividadeId: atividadeId ?? this.atividadeId,
        aprId: aprId ?? this.aprId,
        usuarioId: usuarioId ?? this.usuarioId,
        dataPreenchimento: dataPreenchimento ?? this.dataPreenchimento,
      );
  AprPreenchidaTableData copyWithCompanion(AprPreenchidaTableCompanion data) {
    return AprPreenchidaTableData(
      id: data.id.present ? data.id.value : this.id,
      atividadeId:
          data.atividadeId.present ? data.atividadeId.value : this.atividadeId,
      aprId: data.aprId.present ? data.aprId.value : this.aprId,
      usuarioId: data.usuarioId.present ? data.usuarioId.value : this.usuarioId,
      dataPreenchimento: data.dataPreenchimento.present
          ? data.dataPreenchimento.value
          : this.dataPreenchimento,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AprPreenchidaTableData(')
          ..write('id: $id, ')
          ..write('atividadeId: $atividadeId, ')
          ..write('aprId: $aprId, ')
          ..write('usuarioId: $usuarioId, ')
          ..write('dataPreenchimento: $dataPreenchimento')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, atividadeId, aprId, usuarioId, dataPreenchimento);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AprPreenchidaTableData &&
          other.id == this.id &&
          other.atividadeId == this.atividadeId &&
          other.aprId == this.aprId &&
          other.usuarioId == this.usuarioId &&
          other.dataPreenchimento == this.dataPreenchimento);
}

class AprPreenchidaTableCompanion
    extends UpdateCompanion<AprPreenchidaTableData> {
  final Value<int> id;
  final Value<int> atividadeId;
  final Value<int> aprId;
  final Value<int> usuarioId;
  final Value<DateTime> dataPreenchimento;
  const AprPreenchidaTableCompanion({
    this.id = const Value.absent(),
    this.atividadeId = const Value.absent(),
    this.aprId = const Value.absent(),
    this.usuarioId = const Value.absent(),
    this.dataPreenchimento = const Value.absent(),
  });
  AprPreenchidaTableCompanion.insert({
    this.id = const Value.absent(),
    required int atividadeId,
    required int aprId,
    required int usuarioId,
    required DateTime dataPreenchimento,
  })  : atividadeId = Value(atividadeId),
        aprId = Value(aprId),
        usuarioId = Value(usuarioId),
        dataPreenchimento = Value(dataPreenchimento);
  static Insertable<AprPreenchidaTableData> custom({
    Expression<int>? id,
    Expression<int>? atividadeId,
    Expression<int>? aprId,
    Expression<int>? usuarioId,
    Expression<DateTime>? dataPreenchimento,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (atividadeId != null) 'atividade_id': atividadeId,
      if (aprId != null) 'apr_id': aprId,
      if (usuarioId != null) 'usuario_id': usuarioId,
      if (dataPreenchimento != null) 'data_preenchimento': dataPreenchimento,
    });
  }

  AprPreenchidaTableCompanion copyWith(
      {Value<int>? id,
      Value<int>? atividadeId,
      Value<int>? aprId,
      Value<int>? usuarioId,
      Value<DateTime>? dataPreenchimento}) {
    return AprPreenchidaTableCompanion(
      id: id ?? this.id,
      atividadeId: atividadeId ?? this.atividadeId,
      aprId: aprId ?? this.aprId,
      usuarioId: usuarioId ?? this.usuarioId,
      dataPreenchimento: dataPreenchimento ?? this.dataPreenchimento,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (atividadeId.present) {
      map['atividade_id'] = Variable<int>(atividadeId.value);
    }
    if (aprId.present) {
      map['apr_id'] = Variable<int>(aprId.value);
    }
    if (usuarioId.present) {
      map['usuario_id'] = Variable<int>(usuarioId.value);
    }
    if (dataPreenchimento.present) {
      map['data_preenchimento'] = Variable<DateTime>(dataPreenchimento.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AprPreenchidaTableCompanion(')
          ..write('id: $id, ')
          ..write('atividadeId: $atividadeId, ')
          ..write('aprId: $aprId, ')
          ..write('usuarioId: $usuarioId, ')
          ..write('dataPreenchimento: $dataPreenchimento')
          ..write(')'))
        .toString();
  }
}

class $AprRespostaTableTable extends AprRespostaTable
    with TableInfo<$AprRespostaTableTable, AprRespostaTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AprRespostaTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _aprPreenchidaIdMeta =
      const VerificationMeta('aprPreenchidaId');
  @override
  late final GeneratedColumn<int> aprPreenchidaId = GeneratedColumn<int>(
      'apr_preenchida_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES apr_preenchida_table (id)'));
  static const VerificationMeta _perguntaIdMeta =
      const VerificationMeta('perguntaId');
  @override
  late final GeneratedColumn<int> perguntaId = GeneratedColumn<int>(
      'pergunta_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES apr_question_table (id)'));
  static const VerificationMeta _respostaMeta =
      const VerificationMeta('resposta');
  @override
  late final GeneratedColumnWithTypeConverter<RespostaApr, String> resposta =
      GeneratedColumn<String>('resposta', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<RespostaApr>(
              $AprRespostaTableTable.$converterresposta);
  static const VerificationMeta _observacaoMeta =
      const VerificationMeta('observacao');
  @override
  late final GeneratedColumn<String> observacao = GeneratedColumn<String>(
      'observacao', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, aprPreenchidaId, perguntaId, resposta, observacao];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'apr_resposta_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<AprRespostaTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('apr_preenchida_id')) {
      context.handle(
          _aprPreenchidaIdMeta,
          aprPreenchidaId.isAcceptableOrUnknown(
              data['apr_preenchida_id']!, _aprPreenchidaIdMeta));
    } else if (isInserting) {
      context.missing(_aprPreenchidaIdMeta);
    }
    if (data.containsKey('pergunta_id')) {
      context.handle(
          _perguntaIdMeta,
          perguntaId.isAcceptableOrUnknown(
              data['pergunta_id']!, _perguntaIdMeta));
    } else if (isInserting) {
      context.missing(_perguntaIdMeta);
    }
    context.handle(_respostaMeta, const VerificationResult.success());
    if (data.containsKey('observacao')) {
      context.handle(
          _observacaoMeta,
          observacao.isAcceptableOrUnknown(
              data['observacao']!, _observacaoMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AprRespostaTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AprRespostaTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      aprPreenchidaId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}apr_preenchida_id'])!,
      perguntaId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}pergunta_id'])!,
      resposta: $AprRespostaTableTable.$converterresposta.fromSql(
          attachedDatabase.typeMapping
              .read(DriftSqlType.string, data['${effectivePrefix}resposta'])!),
      observacao: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}observacao']),
    );
  }

  @override
  $AprRespostaTableTable createAlias(String alias) {
    return $AprRespostaTableTable(attachedDatabase, alias);
  }

  static TypeConverter<RespostaApr, String> $converterresposta =
      const RespostaAprConverter();
}

class AprRespostaTableData extends DataClass
    implements Insertable<AprRespostaTableData> {
  final int id;
  final int aprPreenchidaId;
  final int perguntaId;
  final RespostaApr resposta;
  final String? observacao;
  const AprRespostaTableData(
      {required this.id,
      required this.aprPreenchidaId,
      required this.perguntaId,
      required this.resposta,
      this.observacao});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['apr_preenchida_id'] = Variable<int>(aprPreenchidaId);
    map['pergunta_id'] = Variable<int>(perguntaId);
    {
      map['resposta'] = Variable<String>(
          $AprRespostaTableTable.$converterresposta.toSql(resposta));
    }
    if (!nullToAbsent || observacao != null) {
      map['observacao'] = Variable<String>(observacao);
    }
    return map;
  }

  AprRespostaTableCompanion toCompanion(bool nullToAbsent) {
    return AprRespostaTableCompanion(
      id: Value(id),
      aprPreenchidaId: Value(aprPreenchidaId),
      perguntaId: Value(perguntaId),
      resposta: Value(resposta),
      observacao: observacao == null && nullToAbsent
          ? const Value.absent()
          : Value(observacao),
    );
  }

  factory AprRespostaTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AprRespostaTableData(
      id: serializer.fromJson<int>(json['id']),
      aprPreenchidaId: serializer.fromJson<int>(json['aprPreenchidaId']),
      perguntaId: serializer.fromJson<int>(json['perguntaId']),
      resposta: serializer.fromJson<RespostaApr>(json['resposta']),
      observacao: serializer.fromJson<String?>(json['observacao']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'aprPreenchidaId': serializer.toJson<int>(aprPreenchidaId),
      'perguntaId': serializer.toJson<int>(perguntaId),
      'resposta': serializer.toJson<RespostaApr>(resposta),
      'observacao': serializer.toJson<String?>(observacao),
    };
  }

  AprRespostaTableData copyWith(
          {int? id,
          int? aprPreenchidaId,
          int? perguntaId,
          RespostaApr? resposta,
          Value<String?> observacao = const Value.absent()}) =>
      AprRespostaTableData(
        id: id ?? this.id,
        aprPreenchidaId: aprPreenchidaId ?? this.aprPreenchidaId,
        perguntaId: perguntaId ?? this.perguntaId,
        resposta: resposta ?? this.resposta,
        observacao: observacao.present ? observacao.value : this.observacao,
      );
  AprRespostaTableData copyWithCompanion(AprRespostaTableCompanion data) {
    return AprRespostaTableData(
      id: data.id.present ? data.id.value : this.id,
      aprPreenchidaId: data.aprPreenchidaId.present
          ? data.aprPreenchidaId.value
          : this.aprPreenchidaId,
      perguntaId:
          data.perguntaId.present ? data.perguntaId.value : this.perguntaId,
      resposta: data.resposta.present ? data.resposta.value : this.resposta,
      observacao:
          data.observacao.present ? data.observacao.value : this.observacao,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AprRespostaTableData(')
          ..write('id: $id, ')
          ..write('aprPreenchidaId: $aprPreenchidaId, ')
          ..write('perguntaId: $perguntaId, ')
          ..write('resposta: $resposta, ')
          ..write('observacao: $observacao')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, aprPreenchidaId, perguntaId, resposta, observacao);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AprRespostaTableData &&
          other.id == this.id &&
          other.aprPreenchidaId == this.aprPreenchidaId &&
          other.perguntaId == this.perguntaId &&
          other.resposta == this.resposta &&
          other.observacao == this.observacao);
}

class AprRespostaTableCompanion extends UpdateCompanion<AprRespostaTableData> {
  final Value<int> id;
  final Value<int> aprPreenchidaId;
  final Value<int> perguntaId;
  final Value<RespostaApr> resposta;
  final Value<String?> observacao;
  const AprRespostaTableCompanion({
    this.id = const Value.absent(),
    this.aprPreenchidaId = const Value.absent(),
    this.perguntaId = const Value.absent(),
    this.resposta = const Value.absent(),
    this.observacao = const Value.absent(),
  });
  AprRespostaTableCompanion.insert({
    this.id = const Value.absent(),
    required int aprPreenchidaId,
    required int perguntaId,
    required RespostaApr resposta,
    this.observacao = const Value.absent(),
  })  : aprPreenchidaId = Value(aprPreenchidaId),
        perguntaId = Value(perguntaId),
        resposta = Value(resposta);
  static Insertable<AprRespostaTableData> custom({
    Expression<int>? id,
    Expression<int>? aprPreenchidaId,
    Expression<int>? perguntaId,
    Expression<String>? resposta,
    Expression<String>? observacao,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (aprPreenchidaId != null) 'apr_preenchida_id': aprPreenchidaId,
      if (perguntaId != null) 'pergunta_id': perguntaId,
      if (resposta != null) 'resposta': resposta,
      if (observacao != null) 'observacao': observacao,
    });
  }

  AprRespostaTableCompanion copyWith(
      {Value<int>? id,
      Value<int>? aprPreenchidaId,
      Value<int>? perguntaId,
      Value<RespostaApr>? resposta,
      Value<String?>? observacao}) {
    return AprRespostaTableCompanion(
      id: id ?? this.id,
      aprPreenchidaId: aprPreenchidaId ?? this.aprPreenchidaId,
      perguntaId: perguntaId ?? this.perguntaId,
      resposta: resposta ?? this.resposta,
      observacao: observacao ?? this.observacao,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (aprPreenchidaId.present) {
      map['apr_preenchida_id'] = Variable<int>(aprPreenchidaId.value);
    }
    if (perguntaId.present) {
      map['pergunta_id'] = Variable<int>(perguntaId.value);
    }
    if (resposta.present) {
      map['resposta'] = Variable<String>(
          $AprRespostaTableTable.$converterresposta.toSql(resposta.value));
    }
    if (observacao.present) {
      map['observacao'] = Variable<String>(observacao.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AprRespostaTableCompanion(')
          ..write('id: $id, ')
          ..write('aprPreenchidaId: $aprPreenchidaId, ')
          ..write('perguntaId: $perguntaId, ')
          ..write('resposta: $resposta, ')
          ..write('observacao: $observacao')
          ..write(')'))
        .toString();
  }
}

class $AprPerguntaRelacionamentoTableTable
    extends AprPerguntaRelacionamentoTable
    with
        TableInfo<$AprPerguntaRelacionamentoTableTable,
            AprPerguntaRelacionamentoTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AprPerguntaRelacionamentoTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
      'uuid', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _sincronizadoMeta =
      const VerificationMeta('sincronizado');
  @override
  late final GeneratedColumn<bool> sincronizado = GeneratedColumn<bool>(
      'sincronizado', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("sincronizado" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _aprIdMeta = const VerificationMeta('aprId');
  @override
  late final GeneratedColumn<int> aprId = GeneratedColumn<int>(
      'apr_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES apr_table (id)'));
  static const VerificationMeta _perguntaIdMeta =
      const VerificationMeta('perguntaId');
  @override
  late final GeneratedColumn<int> perguntaId = GeneratedColumn<int>(
      'pergunta_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES apr_question_table (id)'));
  static const VerificationMeta _ordemMeta = const VerificationMeta('ordem');
  @override
  late final GeneratedColumn<int> ordem = GeneratedColumn<int>(
      'ordem', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, uuid, createdAt, updatedAt, sincronizado, aprId, perguntaId, ordem];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'apr_pergunta_relacionamento_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<AprPerguntaRelacionamentoTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('uuid')) {
      context.handle(
          _uuidMeta, uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta));
    } else if (isInserting) {
      context.missing(_uuidMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('sincronizado')) {
      context.handle(
          _sincronizadoMeta,
          sincronizado.isAcceptableOrUnknown(
              data['sincronizado']!, _sincronizadoMeta));
    }
    if (data.containsKey('apr_id')) {
      context.handle(
          _aprIdMeta, aprId.isAcceptableOrUnknown(data['apr_id']!, _aprIdMeta));
    } else if (isInserting) {
      context.missing(_aprIdMeta);
    }
    if (data.containsKey('pergunta_id')) {
      context.handle(
          _perguntaIdMeta,
          perguntaId.isAcceptableOrUnknown(
              data['pergunta_id']!, _perguntaIdMeta));
    } else if (isInserting) {
      context.missing(_perguntaIdMeta);
    }
    if (data.containsKey('ordem')) {
      context.handle(
          _ordemMeta, ordem.isAcceptableOrUnknown(data['ordem']!, _ordemMeta));
    } else if (isInserting) {
      context.missing(_ordemMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AprPerguntaRelacionamentoTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AprPerguntaRelacionamentoTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      uuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uuid'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      sincronizado: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}sincronizado'])!,
      aprId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}apr_id'])!,
      perguntaId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}pergunta_id'])!,
      ordem: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}ordem'])!,
    );
  }

  @override
  $AprPerguntaRelacionamentoTableTable createAlias(String alias) {
    return $AprPerguntaRelacionamentoTableTable(attachedDatabase, alias);
  }
}

class AprPerguntaRelacionamentoTableData extends DataClass
    implements Insertable<AprPerguntaRelacionamentoTableData> {
  final int id;
  final String uuid;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool sincronizado;
  final int aprId;
  final int perguntaId;
  final int ordem;
  const AprPerguntaRelacionamentoTableData(
      {required this.id,
      required this.uuid,
      required this.createdAt,
      required this.updatedAt,
      required this.sincronizado,
      required this.aprId,
      required this.perguntaId,
      required this.ordem});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['uuid'] = Variable<String>(uuid);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['sincronizado'] = Variable<bool>(sincronizado);
    map['apr_id'] = Variable<int>(aprId);
    map['pergunta_id'] = Variable<int>(perguntaId);
    map['ordem'] = Variable<int>(ordem);
    return map;
  }

  AprPerguntaRelacionamentoTableCompanion toCompanion(bool nullToAbsent) {
    return AprPerguntaRelacionamentoTableCompanion(
      id: Value(id),
      uuid: Value(uuid),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      sincronizado: Value(sincronizado),
      aprId: Value(aprId),
      perguntaId: Value(perguntaId),
      ordem: Value(ordem),
    );
  }

  factory AprPerguntaRelacionamentoTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AprPerguntaRelacionamentoTableData(
      id: serializer.fromJson<int>(json['id']),
      uuid: serializer.fromJson<String>(json['uuid']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      sincronizado: serializer.fromJson<bool>(json['sincronizado']),
      aprId: serializer.fromJson<int>(json['aprId']),
      perguntaId: serializer.fromJson<int>(json['perguntaId']),
      ordem: serializer.fromJson<int>(json['ordem']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'uuid': serializer.toJson<String>(uuid),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'sincronizado': serializer.toJson<bool>(sincronizado),
      'aprId': serializer.toJson<int>(aprId),
      'perguntaId': serializer.toJson<int>(perguntaId),
      'ordem': serializer.toJson<int>(ordem),
    };
  }

  AprPerguntaRelacionamentoTableData copyWith(
          {int? id,
          String? uuid,
          DateTime? createdAt,
          DateTime? updatedAt,
          bool? sincronizado,
          int? aprId,
          int? perguntaId,
          int? ordem}) =>
      AprPerguntaRelacionamentoTableData(
        id: id ?? this.id,
        uuid: uuid ?? this.uuid,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        sincronizado: sincronizado ?? this.sincronizado,
        aprId: aprId ?? this.aprId,
        perguntaId: perguntaId ?? this.perguntaId,
        ordem: ordem ?? this.ordem,
      );
  AprPerguntaRelacionamentoTableData copyWithCompanion(
      AprPerguntaRelacionamentoTableCompanion data) {
    return AprPerguntaRelacionamentoTableData(
      id: data.id.present ? data.id.value : this.id,
      uuid: data.uuid.present ? data.uuid.value : this.uuid,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      sincronizado: data.sincronizado.present
          ? data.sincronizado.value
          : this.sincronizado,
      aprId: data.aprId.present ? data.aprId.value : this.aprId,
      perguntaId:
          data.perguntaId.present ? data.perguntaId.value : this.perguntaId,
      ordem: data.ordem.present ? data.ordem.value : this.ordem,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AprPerguntaRelacionamentoTableData(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('sincronizado: $sincronizado, ')
          ..write('aprId: $aprId, ')
          ..write('perguntaId: $perguntaId, ')
          ..write('ordem: $ordem')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, uuid, createdAt, updatedAt, sincronizado, aprId, perguntaId, ordem);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AprPerguntaRelacionamentoTableData &&
          other.id == this.id &&
          other.uuid == this.uuid &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.sincronizado == this.sincronizado &&
          other.aprId == this.aprId &&
          other.perguntaId == this.perguntaId &&
          other.ordem == this.ordem);
}

class AprPerguntaRelacionamentoTableCompanion
    extends UpdateCompanion<AprPerguntaRelacionamentoTableData> {
  final Value<int> id;
  final Value<String> uuid;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<bool> sincronizado;
  final Value<int> aprId;
  final Value<int> perguntaId;
  final Value<int> ordem;
  const AprPerguntaRelacionamentoTableCompanion({
    this.id = const Value.absent(),
    this.uuid = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.sincronizado = const Value.absent(),
    this.aprId = const Value.absent(),
    this.perguntaId = const Value.absent(),
    this.ordem = const Value.absent(),
  });
  AprPerguntaRelacionamentoTableCompanion.insert({
    this.id = const Value.absent(),
    required String uuid,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.sincronizado = const Value.absent(),
    required int aprId,
    required int perguntaId,
    required int ordem,
  })  : uuid = Value(uuid),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt),
        aprId = Value(aprId),
        perguntaId = Value(perguntaId),
        ordem = Value(ordem);
  static Insertable<AprPerguntaRelacionamentoTableData> custom({
    Expression<int>? id,
    Expression<String>? uuid,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<bool>? sincronizado,
    Expression<int>? aprId,
    Expression<int>? perguntaId,
    Expression<int>? ordem,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uuid != null) 'uuid': uuid,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (sincronizado != null) 'sincronizado': sincronizado,
      if (aprId != null) 'apr_id': aprId,
      if (perguntaId != null) 'pergunta_id': perguntaId,
      if (ordem != null) 'ordem': ordem,
    });
  }

  AprPerguntaRelacionamentoTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? uuid,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<bool>? sincronizado,
      Value<int>? aprId,
      Value<int>? perguntaId,
      Value<int>? ordem}) {
    return AprPerguntaRelacionamentoTableCompanion(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      sincronizado: sincronizado ?? this.sincronizado,
      aprId: aprId ?? this.aprId,
      perguntaId: perguntaId ?? this.perguntaId,
      ordem: ordem ?? this.ordem,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (sincronizado.present) {
      map['sincronizado'] = Variable<bool>(sincronizado.value);
    }
    if (aprId.present) {
      map['apr_id'] = Variable<int>(aprId.value);
    }
    if (perguntaId.present) {
      map['pergunta_id'] = Variable<int>(perguntaId.value);
    }
    if (ordem.present) {
      map['ordem'] = Variable<int>(ordem.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AprPerguntaRelacionamentoTableCompanion(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('sincronizado: $sincronizado, ')
          ..write('aprId: $aprId, ')
          ..write('perguntaId: $perguntaId, ')
          ..write('ordem: $ordem')
          ..write(')'))
        .toString();
  }
}

class $TecnicosTableTable extends TecnicosTable
    with TableInfo<$TecnicosTableTable, TecnicosTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TecnicosTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
      'uuid', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _sincronizadoMeta =
      const VerificationMeta('sincronizado');
  @override
  late final GeneratedColumn<bool> sincronizado = GeneratedColumn<bool>(
      'sincronizado', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("sincronizado" IN (0, 1))'),
      defaultValue: const Constant(false));
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
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 2, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, uuid, createdAt, updatedAt, sincronizado, nome, matricula];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tecnicos_table';
  @override
  VerificationContext validateIntegrity(Insertable<TecnicosTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('uuid')) {
      context.handle(
          _uuidMeta, uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta));
    } else if (isInserting) {
      context.missing(_uuidMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('sincronizado')) {
      context.handle(
          _sincronizadoMeta,
          sincronizado.isAcceptableOrUnknown(
              data['sincronizado']!, _sincronizadoMeta));
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TecnicosTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TecnicosTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      uuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uuid'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      sincronizado: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}sincronizado'])!,
      nome: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nome'])!,
      matricula: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}matricula'])!,
    );
  }

  @override
  $TecnicosTableTable createAlias(String alias) {
    return $TecnicosTableTable(attachedDatabase, alias);
  }
}

class TecnicosTableData extends DataClass
    implements Insertable<TecnicosTableData> {
  final int id;
  final String uuid;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool sincronizado;
  final String nome;
  final String matricula;
  const TecnicosTableData(
      {required this.id,
      required this.uuid,
      required this.createdAt,
      required this.updatedAt,
      required this.sincronizado,
      required this.nome,
      required this.matricula});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['uuid'] = Variable<String>(uuid);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['sincronizado'] = Variable<bool>(sincronizado);
    map['nome'] = Variable<String>(nome);
    map['matricula'] = Variable<String>(matricula);
    return map;
  }

  TecnicosTableCompanion toCompanion(bool nullToAbsent) {
    return TecnicosTableCompanion(
      id: Value(id),
      uuid: Value(uuid),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      sincronizado: Value(sincronizado),
      nome: Value(nome),
      matricula: Value(matricula),
    );
  }

  factory TecnicosTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TecnicosTableData(
      id: serializer.fromJson<int>(json['id']),
      uuid: serializer.fromJson<String>(json['uuid']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      sincronizado: serializer.fromJson<bool>(json['sincronizado']),
      nome: serializer.fromJson<String>(json['nome']),
      matricula: serializer.fromJson<String>(json['matricula']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'uuid': serializer.toJson<String>(uuid),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'sincronizado': serializer.toJson<bool>(sincronizado),
      'nome': serializer.toJson<String>(nome),
      'matricula': serializer.toJson<String>(matricula),
    };
  }

  TecnicosTableData copyWith(
          {int? id,
          String? uuid,
          DateTime? createdAt,
          DateTime? updatedAt,
          bool? sincronizado,
          String? nome,
          String? matricula}) =>
      TecnicosTableData(
        id: id ?? this.id,
        uuid: uuid ?? this.uuid,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        sincronizado: sincronizado ?? this.sincronizado,
        nome: nome ?? this.nome,
        matricula: matricula ?? this.matricula,
      );
  TecnicosTableData copyWithCompanion(TecnicosTableCompanion data) {
    return TecnicosTableData(
      id: data.id.present ? data.id.value : this.id,
      uuid: data.uuid.present ? data.uuid.value : this.uuid,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      sincronizado: data.sincronizado.present
          ? data.sincronizado.value
          : this.sincronizado,
      nome: data.nome.present ? data.nome.value : this.nome,
      matricula: data.matricula.present ? data.matricula.value : this.matricula,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TecnicosTableData(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('sincronizado: $sincronizado, ')
          ..write('nome: $nome, ')
          ..write('matricula: $matricula')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, uuid, createdAt, updatedAt, sincronizado, nome, matricula);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TecnicosTableData &&
          other.id == this.id &&
          other.uuid == this.uuid &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.sincronizado == this.sincronizado &&
          other.nome == this.nome &&
          other.matricula == this.matricula);
}

class TecnicosTableCompanion extends UpdateCompanion<TecnicosTableData> {
  final Value<int> id;
  final Value<String> uuid;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<bool> sincronizado;
  final Value<String> nome;
  final Value<String> matricula;
  const TecnicosTableCompanion({
    this.id = const Value.absent(),
    this.uuid = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.sincronizado = const Value.absent(),
    this.nome = const Value.absent(),
    this.matricula = const Value.absent(),
  });
  TecnicosTableCompanion.insert({
    this.id = const Value.absent(),
    required String uuid,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.sincronizado = const Value.absent(),
    required String nome,
    required String matricula,
  })  : uuid = Value(uuid),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt),
        nome = Value(nome),
        matricula = Value(matricula);
  static Insertable<TecnicosTableData> custom({
    Expression<int>? id,
    Expression<String>? uuid,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<bool>? sincronizado,
    Expression<String>? nome,
    Expression<String>? matricula,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uuid != null) 'uuid': uuid,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (sincronizado != null) 'sincronizado': sincronizado,
      if (nome != null) 'nome': nome,
      if (matricula != null) 'matricula': matricula,
    });
  }

  TecnicosTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? uuid,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<bool>? sincronizado,
      Value<String>? nome,
      Value<String>? matricula}) {
    return TecnicosTableCompanion(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      sincronizado: sincronizado ?? this.sincronizado,
      nome: nome ?? this.nome,
      matricula: matricula ?? this.matricula,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (sincronizado.present) {
      map['sincronizado'] = Variable<bool>(sincronizado.value);
    }
    if (nome.present) {
      map['nome'] = Variable<String>(nome.value);
    }
    if (matricula.present) {
      map['matricula'] = Variable<String>(matricula.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TecnicosTableCompanion(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('sincronizado: $sincronizado, ')
          ..write('nome: $nome, ')
          ..write('matricula: $matricula')
          ..write(')'))
        .toString();
  }
}

class $AprAssinaturaTableTable extends AprAssinaturaTable
    with TableInfo<$AprAssinaturaTableTable, AprAssinaturaTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AprAssinaturaTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _aprPreenchidaIdMeta =
      const VerificationMeta('aprPreenchidaId');
  @override
  late final GeneratedColumn<int> aprPreenchidaId = GeneratedColumn<int>(
      'apr_preenchida_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES apr_preenchida_table (id)'));
  static const VerificationMeta _usuarioIdMeta =
      const VerificationMeta('usuarioId');
  @override
  late final GeneratedColumn<int> usuarioId = GeneratedColumn<int>(
      'usuario_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES usuario_table (id)'));
  static const VerificationMeta _dataAssinaturaMeta =
      const VerificationMeta('dataAssinatura');
  @override
  late final GeneratedColumn<DateTime> dataAssinatura =
      GeneratedColumn<DateTime>('data_assinatura', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _tecnicoIdMeta =
      const VerificationMeta('tecnicoId');
  @override
  late final GeneratedColumn<int> tecnicoId = GeneratedColumn<int>(
      'tecnico_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES tecnicos_table (id)'));
  static const VerificationMeta _assinaturaMeta =
      const VerificationMeta('assinatura');
  @override
  late final GeneratedColumn<String> assinatura = GeneratedColumn<String>(
      'assinatura', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _assinaturaPathMeta =
      const VerificationMeta('assinaturaPath');
  @override
  late final GeneratedColumn<String> assinaturaPath = GeneratedColumn<String>(
      'assinatura_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        aprPreenchidaId,
        usuarioId,
        dataAssinatura,
        tecnicoId,
        assinatura,
        assinaturaPath
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'apr_assinatura_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<AprAssinaturaTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('apr_preenchida_id')) {
      context.handle(
          _aprPreenchidaIdMeta,
          aprPreenchidaId.isAcceptableOrUnknown(
              data['apr_preenchida_id']!, _aprPreenchidaIdMeta));
    } else if (isInserting) {
      context.missing(_aprPreenchidaIdMeta);
    }
    if (data.containsKey('usuario_id')) {
      context.handle(_usuarioIdMeta,
          usuarioId.isAcceptableOrUnknown(data['usuario_id']!, _usuarioIdMeta));
    } else if (isInserting) {
      context.missing(_usuarioIdMeta);
    }
    if (data.containsKey('data_assinatura')) {
      context.handle(
          _dataAssinaturaMeta,
          dataAssinatura.isAcceptableOrUnknown(
              data['data_assinatura']!, _dataAssinaturaMeta));
    } else if (isInserting) {
      context.missing(_dataAssinaturaMeta);
    }
    if (data.containsKey('tecnico_id')) {
      context.handle(_tecnicoIdMeta,
          tecnicoId.isAcceptableOrUnknown(data['tecnico_id']!, _tecnicoIdMeta));
    } else if (isInserting) {
      context.missing(_tecnicoIdMeta);
    }
    if (data.containsKey('assinatura')) {
      context.handle(
          _assinaturaMeta,
          assinatura.isAcceptableOrUnknown(
              data['assinatura']!, _assinaturaMeta));
    } else if (isInserting) {
      context.missing(_assinaturaMeta);
    }
    if (data.containsKey('assinatura_path')) {
      context.handle(
          _assinaturaPathMeta,
          assinaturaPath.isAcceptableOrUnknown(
              data['assinatura_path']!, _assinaturaPathMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AprAssinaturaTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AprAssinaturaTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      aprPreenchidaId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}apr_preenchida_id'])!,
      usuarioId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}usuario_id'])!,
      dataAssinatura: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}data_assinatura'])!,
      tecnicoId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}tecnico_id'])!,
      assinatura: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}assinatura'])!,
      assinaturaPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}assinatura_path']),
    );
  }

  @override
  $AprAssinaturaTableTable createAlias(String alias) {
    return $AprAssinaturaTableTable(attachedDatabase, alias);
  }
}

class AprAssinaturaTableData extends DataClass
    implements Insertable<AprAssinaturaTableData> {
  final int id;
  final int aprPreenchidaId;
  final int usuarioId;
  final DateTime dataAssinatura;
  final int tecnicoId;
  final String assinatura;
  final String? assinaturaPath;
  const AprAssinaturaTableData(
      {required this.id,
      required this.aprPreenchidaId,
      required this.usuarioId,
      required this.dataAssinatura,
      required this.tecnicoId,
      required this.assinatura,
      this.assinaturaPath});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['apr_preenchida_id'] = Variable<int>(aprPreenchidaId);
    map['usuario_id'] = Variable<int>(usuarioId);
    map['data_assinatura'] = Variable<DateTime>(dataAssinatura);
    map['tecnico_id'] = Variable<int>(tecnicoId);
    map['assinatura'] = Variable<String>(assinatura);
    if (!nullToAbsent || assinaturaPath != null) {
      map['assinatura_path'] = Variable<String>(assinaturaPath);
    }
    return map;
  }

  AprAssinaturaTableCompanion toCompanion(bool nullToAbsent) {
    return AprAssinaturaTableCompanion(
      id: Value(id),
      aprPreenchidaId: Value(aprPreenchidaId),
      usuarioId: Value(usuarioId),
      dataAssinatura: Value(dataAssinatura),
      tecnicoId: Value(tecnicoId),
      assinatura: Value(assinatura),
      assinaturaPath: assinaturaPath == null && nullToAbsent
          ? const Value.absent()
          : Value(assinaturaPath),
    );
  }

  factory AprAssinaturaTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AprAssinaturaTableData(
      id: serializer.fromJson<int>(json['id']),
      aprPreenchidaId: serializer.fromJson<int>(json['aprPreenchidaId']),
      usuarioId: serializer.fromJson<int>(json['usuarioId']),
      dataAssinatura: serializer.fromJson<DateTime>(json['dataAssinatura']),
      tecnicoId: serializer.fromJson<int>(json['tecnicoId']),
      assinatura: serializer.fromJson<String>(json['assinatura']),
      assinaturaPath: serializer.fromJson<String?>(json['assinaturaPath']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'aprPreenchidaId': serializer.toJson<int>(aprPreenchidaId),
      'usuarioId': serializer.toJson<int>(usuarioId),
      'dataAssinatura': serializer.toJson<DateTime>(dataAssinatura),
      'tecnicoId': serializer.toJson<int>(tecnicoId),
      'assinatura': serializer.toJson<String>(assinatura),
      'assinaturaPath': serializer.toJson<String?>(assinaturaPath),
    };
  }

  AprAssinaturaTableData copyWith(
          {int? id,
          int? aprPreenchidaId,
          int? usuarioId,
          DateTime? dataAssinatura,
          int? tecnicoId,
          String? assinatura,
          Value<String?> assinaturaPath = const Value.absent()}) =>
      AprAssinaturaTableData(
        id: id ?? this.id,
        aprPreenchidaId: aprPreenchidaId ?? this.aprPreenchidaId,
        usuarioId: usuarioId ?? this.usuarioId,
        dataAssinatura: dataAssinatura ?? this.dataAssinatura,
        tecnicoId: tecnicoId ?? this.tecnicoId,
        assinatura: assinatura ?? this.assinatura,
        assinaturaPath:
            assinaturaPath.present ? assinaturaPath.value : this.assinaturaPath,
      );
  AprAssinaturaTableData copyWithCompanion(AprAssinaturaTableCompanion data) {
    return AprAssinaturaTableData(
      id: data.id.present ? data.id.value : this.id,
      aprPreenchidaId: data.aprPreenchidaId.present
          ? data.aprPreenchidaId.value
          : this.aprPreenchidaId,
      usuarioId: data.usuarioId.present ? data.usuarioId.value : this.usuarioId,
      dataAssinatura: data.dataAssinatura.present
          ? data.dataAssinatura.value
          : this.dataAssinatura,
      tecnicoId: data.tecnicoId.present ? data.tecnicoId.value : this.tecnicoId,
      assinatura:
          data.assinatura.present ? data.assinatura.value : this.assinatura,
      assinaturaPath: data.assinaturaPath.present
          ? data.assinaturaPath.value
          : this.assinaturaPath,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AprAssinaturaTableData(')
          ..write('id: $id, ')
          ..write('aprPreenchidaId: $aprPreenchidaId, ')
          ..write('usuarioId: $usuarioId, ')
          ..write('dataAssinatura: $dataAssinatura, ')
          ..write('tecnicoId: $tecnicoId, ')
          ..write('assinatura: $assinatura, ')
          ..write('assinaturaPath: $assinaturaPath')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, aprPreenchidaId, usuarioId,
      dataAssinatura, tecnicoId, assinatura, assinaturaPath);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AprAssinaturaTableData &&
          other.id == this.id &&
          other.aprPreenchidaId == this.aprPreenchidaId &&
          other.usuarioId == this.usuarioId &&
          other.dataAssinatura == this.dataAssinatura &&
          other.tecnicoId == this.tecnicoId &&
          other.assinatura == this.assinatura &&
          other.assinaturaPath == this.assinaturaPath);
}

class AprAssinaturaTableCompanion
    extends UpdateCompanion<AprAssinaturaTableData> {
  final Value<int> id;
  final Value<int> aprPreenchidaId;
  final Value<int> usuarioId;
  final Value<DateTime> dataAssinatura;
  final Value<int> tecnicoId;
  final Value<String> assinatura;
  final Value<String?> assinaturaPath;
  const AprAssinaturaTableCompanion({
    this.id = const Value.absent(),
    this.aprPreenchidaId = const Value.absent(),
    this.usuarioId = const Value.absent(),
    this.dataAssinatura = const Value.absent(),
    this.tecnicoId = const Value.absent(),
    this.assinatura = const Value.absent(),
    this.assinaturaPath = const Value.absent(),
  });
  AprAssinaturaTableCompanion.insert({
    this.id = const Value.absent(),
    required int aprPreenchidaId,
    required int usuarioId,
    required DateTime dataAssinatura,
    required int tecnicoId,
    required String assinatura,
    this.assinaturaPath = const Value.absent(),
  })  : aprPreenchidaId = Value(aprPreenchidaId),
        usuarioId = Value(usuarioId),
        dataAssinatura = Value(dataAssinatura),
        tecnicoId = Value(tecnicoId),
        assinatura = Value(assinatura);
  static Insertable<AprAssinaturaTableData> custom({
    Expression<int>? id,
    Expression<int>? aprPreenchidaId,
    Expression<int>? usuarioId,
    Expression<DateTime>? dataAssinatura,
    Expression<int>? tecnicoId,
    Expression<String>? assinatura,
    Expression<String>? assinaturaPath,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (aprPreenchidaId != null) 'apr_preenchida_id': aprPreenchidaId,
      if (usuarioId != null) 'usuario_id': usuarioId,
      if (dataAssinatura != null) 'data_assinatura': dataAssinatura,
      if (tecnicoId != null) 'tecnico_id': tecnicoId,
      if (assinatura != null) 'assinatura': assinatura,
      if (assinaturaPath != null) 'assinatura_path': assinaturaPath,
    });
  }

  AprAssinaturaTableCompanion copyWith(
      {Value<int>? id,
      Value<int>? aprPreenchidaId,
      Value<int>? usuarioId,
      Value<DateTime>? dataAssinatura,
      Value<int>? tecnicoId,
      Value<String>? assinatura,
      Value<String?>? assinaturaPath}) {
    return AprAssinaturaTableCompanion(
      id: id ?? this.id,
      aprPreenchidaId: aprPreenchidaId ?? this.aprPreenchidaId,
      usuarioId: usuarioId ?? this.usuarioId,
      dataAssinatura: dataAssinatura ?? this.dataAssinatura,
      tecnicoId: tecnicoId ?? this.tecnicoId,
      assinatura: assinatura ?? this.assinatura,
      assinaturaPath: assinaturaPath ?? this.assinaturaPath,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (aprPreenchidaId.present) {
      map['apr_preenchida_id'] = Variable<int>(aprPreenchidaId.value);
    }
    if (usuarioId.present) {
      map['usuario_id'] = Variable<int>(usuarioId.value);
    }
    if (dataAssinatura.present) {
      map['data_assinatura'] = Variable<DateTime>(dataAssinatura.value);
    }
    if (tecnicoId.present) {
      map['tecnico_id'] = Variable<int>(tecnicoId.value);
    }
    if (assinatura.present) {
      map['assinatura'] = Variable<String>(assinatura.value);
    }
    if (assinaturaPath.present) {
      map['assinatura_path'] = Variable<String>(assinaturaPath.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AprAssinaturaTableCompanion(')
          ..write('id: $id, ')
          ..write('aprPreenchidaId: $aprPreenchidaId, ')
          ..write('usuarioId: $usuarioId, ')
          ..write('dataAssinatura: $dataAssinatura, ')
          ..write('tecnicoId: $tecnicoId, ')
          ..write('assinatura: $assinatura, ')
          ..write('assinaturaPath: $assinaturaPath')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UsuarioTableTable usuarioTable = $UsuarioTableTable(this);
  late final $TipoAtividadeTableTable tipoAtividadeTable =
      $TipoAtividadeTableTable(this);
  late final $GrupoDefeitoEquipamentoTableTable grupoDefeitoEquipamentoTable =
      $GrupoDefeitoEquipamentoTableTable(this);
  late final $SubgrupoDefeitoEquipamentoTableTable
      subgrupoDefeitoEquipamentoTable =
      $SubgrupoDefeitoEquipamentoTableTable(this);
  late final $EquipamentoTableTable equipamentoTable =
      $EquipamentoTableTable(this);
  late final $AtividadeTableTable atividadeTable = $AtividadeTableTable(this);
  late final $AprTableTable aprTable = $AprTableTable(this);
  late final $AprQuestionTableTable aprQuestionTable =
      $AprQuestionTableTable(this);
  late final $AprPreenchidaTableTable aprPreenchidaTable =
      $AprPreenchidaTableTable(this);
  late final $AprRespostaTableTable aprRespostaTable =
      $AprRespostaTableTable(this);
  late final $AprPerguntaRelacionamentoTableTable
      aprPerguntaRelacionamentoTable =
      $AprPerguntaRelacionamentoTableTable(this);
  late final $TecnicosTableTable tecnicosTable = $TecnicosTableTable(this);
  late final $AprAssinaturaTableTable aprAssinaturaTable =
      $AprAssinaturaTableTable(this);
  late final UsuarioDao usuarioDao = UsuarioDao(this as AppDatabase);
  late final TipoAtividadeDao tipoAtividadeDao =
      TipoAtividadeDao(this as AppDatabase);
  late final AtividadeDao atividadeDao = AtividadeDao(this as AppDatabase);
  late final EquipamentoDao equipamentoDao =
      EquipamentoDao(this as AppDatabase);
  late final GrupoDefeitoEquipamentoDao grupoDefeitoEquipamentoDao =
      GrupoDefeitoEquipamentoDao(this as AppDatabase);
  late final SubgrupoDefeitoEquipamentoDao subgrupoDefeitoEquipamentoDao =
      SubgrupoDefeitoEquipamentoDao(this as AppDatabase);
  late final AprDao aprDao = AprDao(this as AppDatabase);
  late final AprPerguntaDao aprPerguntaDao =
      AprPerguntaDao(this as AppDatabase);
  late final AprRespostaDao aprRespostaDao =
      AprRespostaDao(this as AppDatabase);
  late final AprPreenchidaDao aprPreenchidaDao =
      AprPreenchidaDao(this as AppDatabase);
  late final AprAssinaturaDao aprAssinaturaDao =
      AprAssinaturaDao(this as AppDatabase);
  late final TecnicosDao tecnicosDao = TecnicosDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        usuarioTable,
        tipoAtividadeTable,
        grupoDefeitoEquipamentoTable,
        subgrupoDefeitoEquipamentoTable,
        equipamentoTable,
        atividadeTable,
        aprTable,
        aprQuestionTable,
        aprPreenchidaTable,
        aprRespostaTable,
        aprPerguntaRelacionamentoTable,
        tecnicosTable,
        aprAssinaturaTable
      ];
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

final class $$UsuarioTableTableReferences extends BaseReferences<_$AppDatabase,
    $UsuarioTableTable, UsuarioTableData> {
  $$UsuarioTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$AprPreenchidaTableTable,
      List<AprPreenchidaTableData>> _aprPreenchidaTableRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.aprPreenchidaTable,
          aliasName: $_aliasNameGenerator(
              db.usuarioTable.id, db.aprPreenchidaTable.usuarioId));

  $$AprPreenchidaTableTableProcessedTableManager get aprPreenchidaTableRefs {
    final manager =
        $$AprPreenchidaTableTableTableManager($_db, $_db.aprPreenchidaTable)
            .filter((f) => f.usuarioId.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_aprPreenchidaTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$AprAssinaturaTableTable,
      List<AprAssinaturaTableData>> _aprAssinaturaTableRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.aprAssinaturaTable,
          aliasName: $_aliasNameGenerator(
              db.usuarioTable.id, db.aprAssinaturaTable.usuarioId));

  $$AprAssinaturaTableTableProcessedTableManager get aprAssinaturaTableRefs {
    final manager =
        $$AprAssinaturaTableTableTableManager($_db, $_db.aprAssinaturaTable)
            .filter((f) => f.usuarioId.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_aprAssinaturaTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

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

  Expression<bool> aprPreenchidaTableRefs(
      Expression<bool> Function($$AprPreenchidaTableTableFilterComposer f) f) {
    final $$AprPreenchidaTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.aprPreenchidaTable,
        getReferencedColumn: (t) => t.usuarioId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AprPreenchidaTableTableFilterComposer(
              $db: $db,
              $table: $db.aprPreenchidaTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> aprAssinaturaTableRefs(
      Expression<bool> Function($$AprAssinaturaTableTableFilterComposer f) f) {
    final $$AprAssinaturaTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.aprAssinaturaTable,
        getReferencedColumn: (t) => t.usuarioId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AprAssinaturaTableTableFilterComposer(
              $db: $db,
              $table: $db.aprAssinaturaTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
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

  Expression<T> aprPreenchidaTableRefs<T extends Object>(
      Expression<T> Function($$AprPreenchidaTableTableAnnotationComposer a) f) {
    final $$AprPreenchidaTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.aprPreenchidaTable,
            getReferencedColumn: (t) => t.usuarioId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$AprPreenchidaTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.aprPreenchidaTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> aprAssinaturaTableRefs<T extends Object>(
      Expression<T> Function($$AprAssinaturaTableTableAnnotationComposer a) f) {
    final $$AprAssinaturaTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.aprAssinaturaTable,
            getReferencedColumn: (t) => t.usuarioId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$AprAssinaturaTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.aprAssinaturaTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
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
    (UsuarioTableData, $$UsuarioTableTableReferences),
    UsuarioTableData,
    PrefetchHooks Function(
        {bool aprPreenchidaTableRefs, bool aprAssinaturaTableRefs})> {
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
              .map((e) => (
                    e.readTable(table),
                    $$UsuarioTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {aprPreenchidaTableRefs = false,
              aprAssinaturaTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (aprPreenchidaTableRefs) db.aprPreenchidaTable,
                if (aprAssinaturaTableRefs) db.aprAssinaturaTable
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (aprPreenchidaTableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$UsuarioTableTableReferences
                            ._aprPreenchidaTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$UsuarioTableTableReferences(db, table, p0)
                                .aprPreenchidaTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.usuarioId == item.id),
                        typedResults: items),
                  if (aprAssinaturaTableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$UsuarioTableTableReferences
                            ._aprAssinaturaTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$UsuarioTableTableReferences(db, table, p0)
                                .aprAssinaturaTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.usuarioId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
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
    (UsuarioTableData, $$UsuarioTableTableReferences),
    UsuarioTableData,
    PrefetchHooks Function(
        {bool aprPreenchidaTableRefs, bool aprAssinaturaTableRefs})>;
typedef $$TipoAtividadeTableTableCreateCompanionBuilder
    = TipoAtividadeTableCompanion Function({
  Value<int> id,
  required String uuid,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<bool> sincronizado,
  required String nome,
  required TipoAtividadeMobile tipoAtividadeMobile,
  required int aprId,
  required int checklistId,
});
typedef $$TipoAtividadeTableTableUpdateCompanionBuilder
    = TipoAtividadeTableCompanion Function({
  Value<int> id,
  Value<String> uuid,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<bool> sincronizado,
  Value<String> nome,
  Value<TipoAtividadeMobile> tipoAtividadeMobile,
  Value<int> aprId,
  Value<int> checklistId,
});

final class $$TipoAtividadeTableTableReferences extends BaseReferences<
    _$AppDatabase, $TipoAtividadeTableTable, TipoAtividadeTableData> {
  $$TipoAtividadeTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$AtividadeTableTable, List<AtividadeTableData>>
      _atividadeTableRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.atividadeTable,
              aliasName: $_aliasNameGenerator(
                  db.tipoAtividadeTable.id, db.atividadeTable.tipoAtividadeId));

  $$AtividadeTableTableProcessedTableManager get atividadeTableRefs {
    final manager = $$AtividadeTableTableTableManager($_db, $_db.atividadeTable)
        .filter((f) => f.tipoAtividadeId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_atividadeTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$TipoAtividadeTableTableFilterComposer
    extends Composer<_$AppDatabase, $TipoAtividadeTableTable> {
  $$TipoAtividadeTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get uuid => $composableBuilder(
      column: $table.uuid, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get sincronizado => $composableBuilder(
      column: $table.sincronizado, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nome => $composableBuilder(
      column: $table.nome, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<TipoAtividadeMobile, TipoAtividadeMobile,
          String>
      get tipoAtividadeMobile => $composableBuilder(
          column: $table.tipoAtividadeMobile,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<int> get aprId => $composableBuilder(
      column: $table.aprId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get checklistId => $composableBuilder(
      column: $table.checklistId, builder: (column) => ColumnFilters(column));

  Expression<bool> atividadeTableRefs(
      Expression<bool> Function($$AtividadeTableTableFilterComposer f) f) {
    final $$AtividadeTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.atividadeTable,
        getReferencedColumn: (t) => t.tipoAtividadeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AtividadeTableTableFilterComposer(
              $db: $db,
              $table: $db.atividadeTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$TipoAtividadeTableTableOrderingComposer
    extends Composer<_$AppDatabase, $TipoAtividadeTableTable> {
  $$TipoAtividadeTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get uuid => $composableBuilder(
      column: $table.uuid, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get sincronizado => $composableBuilder(
      column: $table.sincronizado,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nome => $composableBuilder(
      column: $table.nome, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tipoAtividadeMobile => $composableBuilder(
      column: $table.tipoAtividadeMobile,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get aprId => $composableBuilder(
      column: $table.aprId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get checklistId => $composableBuilder(
      column: $table.checklistId, builder: (column) => ColumnOrderings(column));
}

class $$TipoAtividadeTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $TipoAtividadeTableTable> {
  $$TipoAtividadeTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get uuid =>
      $composableBuilder(column: $table.uuid, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get sincronizado => $composableBuilder(
      column: $table.sincronizado, builder: (column) => column);

  GeneratedColumn<String> get nome =>
      $composableBuilder(column: $table.nome, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TipoAtividadeMobile, String>
      get tipoAtividadeMobile => $composableBuilder(
          column: $table.tipoAtividadeMobile, builder: (column) => column);

  GeneratedColumn<int> get aprId =>
      $composableBuilder(column: $table.aprId, builder: (column) => column);

  GeneratedColumn<int> get checklistId => $composableBuilder(
      column: $table.checklistId, builder: (column) => column);

  Expression<T> atividadeTableRefs<T extends Object>(
      Expression<T> Function($$AtividadeTableTableAnnotationComposer a) f) {
    final $$AtividadeTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.atividadeTable,
        getReferencedColumn: (t) => t.tipoAtividadeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AtividadeTableTableAnnotationComposer(
              $db: $db,
              $table: $db.atividadeTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$TipoAtividadeTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TipoAtividadeTableTable,
    TipoAtividadeTableData,
    $$TipoAtividadeTableTableFilterComposer,
    $$TipoAtividadeTableTableOrderingComposer,
    $$TipoAtividadeTableTableAnnotationComposer,
    $$TipoAtividadeTableTableCreateCompanionBuilder,
    $$TipoAtividadeTableTableUpdateCompanionBuilder,
    (TipoAtividadeTableData, $$TipoAtividadeTableTableReferences),
    TipoAtividadeTableData,
    PrefetchHooks Function({bool atividadeTableRefs})> {
  $$TipoAtividadeTableTableTableManager(
      _$AppDatabase db, $TipoAtividadeTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TipoAtividadeTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TipoAtividadeTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TipoAtividadeTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> uuid = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<bool> sincronizado = const Value.absent(),
            Value<String> nome = const Value.absent(),
            Value<TipoAtividadeMobile> tipoAtividadeMobile =
                const Value.absent(),
            Value<int> aprId = const Value.absent(),
            Value<int> checklistId = const Value.absent(),
          }) =>
              TipoAtividadeTableCompanion(
            id: id,
            uuid: uuid,
            createdAt: createdAt,
            updatedAt: updatedAt,
            sincronizado: sincronizado,
            nome: nome,
            tipoAtividadeMobile: tipoAtividadeMobile,
            aprId: aprId,
            checklistId: checklistId,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String uuid,
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<bool> sincronizado = const Value.absent(),
            required String nome,
            required TipoAtividadeMobile tipoAtividadeMobile,
            required int aprId,
            required int checklistId,
          }) =>
              TipoAtividadeTableCompanion.insert(
            id: id,
            uuid: uuid,
            createdAt: createdAt,
            updatedAt: updatedAt,
            sincronizado: sincronizado,
            nome: nome,
            tipoAtividadeMobile: tipoAtividadeMobile,
            aprId: aprId,
            checklistId: checklistId,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$TipoAtividadeTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({atividadeTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (atividadeTableRefs) db.atividadeTable
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (atividadeTableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$TipoAtividadeTableTableReferences
                            ._atividadeTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$TipoAtividadeTableTableReferences(db, table, p0)
                                .atividadeTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.tipoAtividadeId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$TipoAtividadeTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TipoAtividadeTableTable,
    TipoAtividadeTableData,
    $$TipoAtividadeTableTableFilterComposer,
    $$TipoAtividadeTableTableOrderingComposer,
    $$TipoAtividadeTableTableAnnotationComposer,
    $$TipoAtividadeTableTableCreateCompanionBuilder,
    $$TipoAtividadeTableTableUpdateCompanionBuilder,
    (TipoAtividadeTableData, $$TipoAtividadeTableTableReferences),
    TipoAtividadeTableData,
    PrefetchHooks Function({bool atividadeTableRefs})>;
typedef $$GrupoDefeitoEquipamentoTableTableCreateCompanionBuilder
    = GrupoDefeitoEquipamentoTableCompanion Function({
  Value<int> id,
  required String uuid,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<bool> sincronizado,
  required String nome,
});
typedef $$GrupoDefeitoEquipamentoTableTableUpdateCompanionBuilder
    = GrupoDefeitoEquipamentoTableCompanion Function({
  Value<int> id,
  Value<String> uuid,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<bool> sincronizado,
  Value<String> nome,
});

final class $$GrupoDefeitoEquipamentoTableTableReferences
    extends BaseReferences<_$AppDatabase, $GrupoDefeitoEquipamentoTableTable,
        GrupoDefeitoEquipamentoTableData> {
  $$GrupoDefeitoEquipamentoTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$EquipamentoTableTable, List<EquipamentoTableData>>
      _equipamentoTableRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.equipamentoTable,
              aliasName: $_aliasNameGenerator(
                  db.grupoDefeitoEquipamentoTable.id,
                  db.equipamentoTable.grupoId));

  $$EquipamentoTableTableProcessedTableManager get equipamentoTableRefs {
    final manager =
        $$EquipamentoTableTableTableManager($_db, $_db.equipamentoTable)
            .filter((f) => f.grupoId.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_equipamentoTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$GrupoDefeitoEquipamentoTableTableFilterComposer
    extends Composer<_$AppDatabase, $GrupoDefeitoEquipamentoTableTable> {
  $$GrupoDefeitoEquipamentoTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get uuid => $composableBuilder(
      column: $table.uuid, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get sincronizado => $composableBuilder(
      column: $table.sincronizado, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nome => $composableBuilder(
      column: $table.nome, builder: (column) => ColumnFilters(column));

  Expression<bool> equipamentoTableRefs(
      Expression<bool> Function($$EquipamentoTableTableFilterComposer f) f) {
    final $$EquipamentoTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.equipamentoTable,
        getReferencedColumn: (t) => t.grupoId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EquipamentoTableTableFilterComposer(
              $db: $db,
              $table: $db.equipamentoTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$GrupoDefeitoEquipamentoTableTableOrderingComposer
    extends Composer<_$AppDatabase, $GrupoDefeitoEquipamentoTableTable> {
  $$GrupoDefeitoEquipamentoTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get uuid => $composableBuilder(
      column: $table.uuid, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get sincronizado => $composableBuilder(
      column: $table.sincronizado,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nome => $composableBuilder(
      column: $table.nome, builder: (column) => ColumnOrderings(column));
}

class $$GrupoDefeitoEquipamentoTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $GrupoDefeitoEquipamentoTableTable> {
  $$GrupoDefeitoEquipamentoTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get uuid =>
      $composableBuilder(column: $table.uuid, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get sincronizado => $composableBuilder(
      column: $table.sincronizado, builder: (column) => column);

  GeneratedColumn<String> get nome =>
      $composableBuilder(column: $table.nome, builder: (column) => column);

  Expression<T> equipamentoTableRefs<T extends Object>(
      Expression<T> Function($$EquipamentoTableTableAnnotationComposer a) f) {
    final $$EquipamentoTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.equipamentoTable,
        getReferencedColumn: (t) => t.grupoId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EquipamentoTableTableAnnotationComposer(
              $db: $db,
              $table: $db.equipamentoTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$GrupoDefeitoEquipamentoTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $GrupoDefeitoEquipamentoTableTable,
    GrupoDefeitoEquipamentoTableData,
    $$GrupoDefeitoEquipamentoTableTableFilterComposer,
    $$GrupoDefeitoEquipamentoTableTableOrderingComposer,
    $$GrupoDefeitoEquipamentoTableTableAnnotationComposer,
    $$GrupoDefeitoEquipamentoTableTableCreateCompanionBuilder,
    $$GrupoDefeitoEquipamentoTableTableUpdateCompanionBuilder,
    (
      GrupoDefeitoEquipamentoTableData,
      $$GrupoDefeitoEquipamentoTableTableReferences
    ),
    GrupoDefeitoEquipamentoTableData,
    PrefetchHooks Function({bool equipamentoTableRefs})> {
  $$GrupoDefeitoEquipamentoTableTableTableManager(
      _$AppDatabase db, $GrupoDefeitoEquipamentoTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GrupoDefeitoEquipamentoTableTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$GrupoDefeitoEquipamentoTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GrupoDefeitoEquipamentoTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> uuid = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<bool> sincronizado = const Value.absent(),
            Value<String> nome = const Value.absent(),
          }) =>
              GrupoDefeitoEquipamentoTableCompanion(
            id: id,
            uuid: uuid,
            createdAt: createdAt,
            updatedAt: updatedAt,
            sincronizado: sincronizado,
            nome: nome,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String uuid,
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<bool> sincronizado = const Value.absent(),
            required String nome,
          }) =>
              GrupoDefeitoEquipamentoTableCompanion.insert(
            id: id,
            uuid: uuid,
            createdAt: createdAt,
            updatedAt: updatedAt,
            sincronizado: sincronizado,
            nome: nome,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$GrupoDefeitoEquipamentoTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({equipamentoTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (equipamentoTableRefs) db.equipamentoTable
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (equipamentoTableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$GrupoDefeitoEquipamentoTableTableReferences
                                ._equipamentoTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$GrupoDefeitoEquipamentoTableTableReferences(
                                    db, table, p0)
                                .equipamentoTableRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.grupoId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$GrupoDefeitoEquipamentoTableTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $GrupoDefeitoEquipamentoTableTable,
        GrupoDefeitoEquipamentoTableData,
        $$GrupoDefeitoEquipamentoTableTableFilterComposer,
        $$GrupoDefeitoEquipamentoTableTableOrderingComposer,
        $$GrupoDefeitoEquipamentoTableTableAnnotationComposer,
        $$GrupoDefeitoEquipamentoTableTableCreateCompanionBuilder,
        $$GrupoDefeitoEquipamentoTableTableUpdateCompanionBuilder,
        (
          GrupoDefeitoEquipamentoTableData,
          $$GrupoDefeitoEquipamentoTableTableReferences
        ),
        GrupoDefeitoEquipamentoTableData,
        PrefetchHooks Function({bool equipamentoTableRefs})>;
typedef $$SubgrupoDefeitoEquipamentoTableTableCreateCompanionBuilder
    = SubgrupoDefeitoEquipamentoTableCompanion Function({
  Value<int> id,
  required String uuid,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<bool> sincronizado,
  required String nome,
});
typedef $$SubgrupoDefeitoEquipamentoTableTableUpdateCompanionBuilder
    = SubgrupoDefeitoEquipamentoTableCompanion Function({
  Value<int> id,
  Value<String> uuid,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<bool> sincronizado,
  Value<String> nome,
});

final class $$SubgrupoDefeitoEquipamentoTableTableReferences
    extends BaseReferences<_$AppDatabase, $SubgrupoDefeitoEquipamentoTableTable,
        SubgrupoDefeitoEquipamentoTableData> {
  $$SubgrupoDefeitoEquipamentoTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$EquipamentoTableTable, List<EquipamentoTableData>>
      _equipamentoTableRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.equipamentoTable,
              aliasName: $_aliasNameGenerator(
                  db.subgrupoDefeitoEquipamentoTable.id,
                  db.equipamentoTable.subgrupoId));

  $$EquipamentoTableTableProcessedTableManager get equipamentoTableRefs {
    final manager =
        $$EquipamentoTableTableTableManager($_db, $_db.equipamentoTable)
            .filter((f) => f.subgrupoId.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_equipamentoTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$SubgrupoDefeitoEquipamentoTableTableFilterComposer
    extends Composer<_$AppDatabase, $SubgrupoDefeitoEquipamentoTableTable> {
  $$SubgrupoDefeitoEquipamentoTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get uuid => $composableBuilder(
      column: $table.uuid, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get sincronizado => $composableBuilder(
      column: $table.sincronizado, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nome => $composableBuilder(
      column: $table.nome, builder: (column) => ColumnFilters(column));

  Expression<bool> equipamentoTableRefs(
      Expression<bool> Function($$EquipamentoTableTableFilterComposer f) f) {
    final $$EquipamentoTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.equipamentoTable,
        getReferencedColumn: (t) => t.subgrupoId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EquipamentoTableTableFilterComposer(
              $db: $db,
              $table: $db.equipamentoTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$SubgrupoDefeitoEquipamentoTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SubgrupoDefeitoEquipamentoTableTable> {
  $$SubgrupoDefeitoEquipamentoTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get uuid => $composableBuilder(
      column: $table.uuid, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get sincronizado => $composableBuilder(
      column: $table.sincronizado,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nome => $composableBuilder(
      column: $table.nome, builder: (column) => ColumnOrderings(column));
}

class $$SubgrupoDefeitoEquipamentoTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SubgrupoDefeitoEquipamentoTableTable> {
  $$SubgrupoDefeitoEquipamentoTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get uuid =>
      $composableBuilder(column: $table.uuid, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get sincronizado => $composableBuilder(
      column: $table.sincronizado, builder: (column) => column);

  GeneratedColumn<String> get nome =>
      $composableBuilder(column: $table.nome, builder: (column) => column);

  Expression<T> equipamentoTableRefs<T extends Object>(
      Expression<T> Function($$EquipamentoTableTableAnnotationComposer a) f) {
    final $$EquipamentoTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.equipamentoTable,
        getReferencedColumn: (t) => t.subgrupoId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EquipamentoTableTableAnnotationComposer(
              $db: $db,
              $table: $db.equipamentoTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$SubgrupoDefeitoEquipamentoTableTableTableManager
    extends RootTableManager<
        _$AppDatabase,
        $SubgrupoDefeitoEquipamentoTableTable,
        SubgrupoDefeitoEquipamentoTableData,
        $$SubgrupoDefeitoEquipamentoTableTableFilterComposer,
        $$SubgrupoDefeitoEquipamentoTableTableOrderingComposer,
        $$SubgrupoDefeitoEquipamentoTableTableAnnotationComposer,
        $$SubgrupoDefeitoEquipamentoTableTableCreateCompanionBuilder,
        $$SubgrupoDefeitoEquipamentoTableTableUpdateCompanionBuilder,
        (
          SubgrupoDefeitoEquipamentoTableData,
          $$SubgrupoDefeitoEquipamentoTableTableReferences
        ),
        SubgrupoDefeitoEquipamentoTableData,
        PrefetchHooks Function({bool equipamentoTableRefs})> {
  $$SubgrupoDefeitoEquipamentoTableTableTableManager(
      _$AppDatabase db, $SubgrupoDefeitoEquipamentoTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SubgrupoDefeitoEquipamentoTableTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$SubgrupoDefeitoEquipamentoTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SubgrupoDefeitoEquipamentoTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> uuid = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<bool> sincronizado = const Value.absent(),
            Value<String> nome = const Value.absent(),
          }) =>
              SubgrupoDefeitoEquipamentoTableCompanion(
            id: id,
            uuid: uuid,
            createdAt: createdAt,
            updatedAt: updatedAt,
            sincronizado: sincronizado,
            nome: nome,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String uuid,
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<bool> sincronizado = const Value.absent(),
            required String nome,
          }) =>
              SubgrupoDefeitoEquipamentoTableCompanion.insert(
            id: id,
            uuid: uuid,
            createdAt: createdAt,
            updatedAt: updatedAt,
            sincronizado: sincronizado,
            nome: nome,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$SubgrupoDefeitoEquipamentoTableTableReferences(
                        db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({equipamentoTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (equipamentoTableRefs) db.equipamentoTable
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (equipamentoTableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$SubgrupoDefeitoEquipamentoTableTableReferences
                                ._equipamentoTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$SubgrupoDefeitoEquipamentoTableTableReferences(
                                    db, table, p0)
                                .equipamentoTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.subgrupoId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$SubgrupoDefeitoEquipamentoTableTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $SubgrupoDefeitoEquipamentoTableTable,
        SubgrupoDefeitoEquipamentoTableData,
        $$SubgrupoDefeitoEquipamentoTableTableFilterComposer,
        $$SubgrupoDefeitoEquipamentoTableTableOrderingComposer,
        $$SubgrupoDefeitoEquipamentoTableTableAnnotationComposer,
        $$SubgrupoDefeitoEquipamentoTableTableCreateCompanionBuilder,
        $$SubgrupoDefeitoEquipamentoTableTableUpdateCompanionBuilder,
        (
          SubgrupoDefeitoEquipamentoTableData,
          $$SubgrupoDefeitoEquipamentoTableTableReferences
        ),
        SubgrupoDefeitoEquipamentoTableData,
        PrefetchHooks Function({bool equipamentoTableRefs})>;
typedef $$EquipamentoTableTableCreateCompanionBuilder
    = EquipamentoTableCompanion Function({
  Value<int> id,
  required String uuid,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<bool> sincronizado,
  required String nome,
  required String descricao,
  required String subestacao,
  required int grupoId,
  required int subgrupoId,
});
typedef $$EquipamentoTableTableUpdateCompanionBuilder
    = EquipamentoTableCompanion Function({
  Value<int> id,
  Value<String> uuid,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<bool> sincronizado,
  Value<String> nome,
  Value<String> descricao,
  Value<String> subestacao,
  Value<int> grupoId,
  Value<int> subgrupoId,
});

final class $$EquipamentoTableTableReferences extends BaseReferences<
    _$AppDatabase, $EquipamentoTableTable, EquipamentoTableData> {
  $$EquipamentoTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $GrupoDefeitoEquipamentoTableTable _grupoIdTable(_$AppDatabase db) =>
      db.grupoDefeitoEquipamentoTable.createAlias($_aliasNameGenerator(
          db.equipamentoTable.grupoId, db.grupoDefeitoEquipamentoTable.id));

  $$GrupoDefeitoEquipamentoTableTableProcessedTableManager get grupoId {
    final manager = $$GrupoDefeitoEquipamentoTableTableTableManager(
            $_db, $_db.grupoDefeitoEquipamentoTable)
        .filter((f) => f.id($_item.grupoId));
    final item = $_typedResult.readTableOrNull(_grupoIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $SubgrupoDefeitoEquipamentoTableTable _subgrupoIdTable(
          _$AppDatabase db) =>
      db.subgrupoDefeitoEquipamentoTable.createAlias($_aliasNameGenerator(
          db.equipamentoTable.subgrupoId,
          db.subgrupoDefeitoEquipamentoTable.id));

  $$SubgrupoDefeitoEquipamentoTableTableProcessedTableManager get subgrupoId {
    final manager = $$SubgrupoDefeitoEquipamentoTableTableTableManager(
            $_db, $_db.subgrupoDefeitoEquipamentoTable)
        .filter((f) => f.id($_item.subgrupoId));
    final item = $_typedResult.readTableOrNull(_subgrupoIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$AtividadeTableTable, List<AtividadeTableData>>
      _atividadeTableRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.atividadeTable,
              aliasName: $_aliasNameGenerator(
                  db.equipamentoTable.id, db.atividadeTable.equipamentoId));

  $$AtividadeTableTableProcessedTableManager get atividadeTableRefs {
    final manager = $$AtividadeTableTableTableManager($_db, $_db.atividadeTable)
        .filter((f) => f.equipamentoId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_atividadeTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$EquipamentoTableTableFilterComposer
    extends Composer<_$AppDatabase, $EquipamentoTableTable> {
  $$EquipamentoTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get uuid => $composableBuilder(
      column: $table.uuid, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get sincronizado => $composableBuilder(
      column: $table.sincronizado, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nome => $composableBuilder(
      column: $table.nome, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get descricao => $composableBuilder(
      column: $table.descricao, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get subestacao => $composableBuilder(
      column: $table.subestacao, builder: (column) => ColumnFilters(column));

  $$GrupoDefeitoEquipamentoTableTableFilterComposer get grupoId {
    final $$GrupoDefeitoEquipamentoTableTableFilterComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.grupoId,
            referencedTable: $db.grupoDefeitoEquipamentoTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$GrupoDefeitoEquipamentoTableTableFilterComposer(
                  $db: $db,
                  $table: $db.grupoDefeitoEquipamentoTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }

  $$SubgrupoDefeitoEquipamentoTableTableFilterComposer get subgrupoId {
    final $$SubgrupoDefeitoEquipamentoTableTableFilterComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.subgrupoId,
            referencedTable: $db.subgrupoDefeitoEquipamentoTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$SubgrupoDefeitoEquipamentoTableTableFilterComposer(
                  $db: $db,
                  $table: $db.subgrupoDefeitoEquipamentoTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }

  Expression<bool> atividadeTableRefs(
      Expression<bool> Function($$AtividadeTableTableFilterComposer f) f) {
    final $$AtividadeTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.atividadeTable,
        getReferencedColumn: (t) => t.equipamentoId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AtividadeTableTableFilterComposer(
              $db: $db,
              $table: $db.atividadeTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$EquipamentoTableTableOrderingComposer
    extends Composer<_$AppDatabase, $EquipamentoTableTable> {
  $$EquipamentoTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get uuid => $composableBuilder(
      column: $table.uuid, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get sincronizado => $composableBuilder(
      column: $table.sincronizado,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nome => $composableBuilder(
      column: $table.nome, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get descricao => $composableBuilder(
      column: $table.descricao, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get subestacao => $composableBuilder(
      column: $table.subestacao, builder: (column) => ColumnOrderings(column));

  $$GrupoDefeitoEquipamentoTableTableOrderingComposer get grupoId {
    final $$GrupoDefeitoEquipamentoTableTableOrderingComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.grupoId,
            referencedTable: $db.grupoDefeitoEquipamentoTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$GrupoDefeitoEquipamentoTableTableOrderingComposer(
                  $db: $db,
                  $table: $db.grupoDefeitoEquipamentoTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }

  $$SubgrupoDefeitoEquipamentoTableTableOrderingComposer get subgrupoId {
    final $$SubgrupoDefeitoEquipamentoTableTableOrderingComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.subgrupoId,
            referencedTable: $db.subgrupoDefeitoEquipamentoTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$SubgrupoDefeitoEquipamentoTableTableOrderingComposer(
                  $db: $db,
                  $table: $db.subgrupoDefeitoEquipamentoTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }
}

class $$EquipamentoTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $EquipamentoTableTable> {
  $$EquipamentoTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get uuid =>
      $composableBuilder(column: $table.uuid, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get sincronizado => $composableBuilder(
      column: $table.sincronizado, builder: (column) => column);

  GeneratedColumn<String> get nome =>
      $composableBuilder(column: $table.nome, builder: (column) => column);

  GeneratedColumn<String> get descricao =>
      $composableBuilder(column: $table.descricao, builder: (column) => column);

  GeneratedColumn<String> get subestacao => $composableBuilder(
      column: $table.subestacao, builder: (column) => column);

  $$GrupoDefeitoEquipamentoTableTableAnnotationComposer get grupoId {
    final $$GrupoDefeitoEquipamentoTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.grupoId,
            referencedTable: $db.grupoDefeitoEquipamentoTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$GrupoDefeitoEquipamentoTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.grupoDefeitoEquipamentoTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }

  $$SubgrupoDefeitoEquipamentoTableTableAnnotationComposer get subgrupoId {
    final $$SubgrupoDefeitoEquipamentoTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.subgrupoId,
            referencedTable: $db.subgrupoDefeitoEquipamentoTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$SubgrupoDefeitoEquipamentoTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.subgrupoDefeitoEquipamentoTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }

  Expression<T> atividadeTableRefs<T extends Object>(
      Expression<T> Function($$AtividadeTableTableAnnotationComposer a) f) {
    final $$AtividadeTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.atividadeTable,
        getReferencedColumn: (t) => t.equipamentoId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AtividadeTableTableAnnotationComposer(
              $db: $db,
              $table: $db.atividadeTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$EquipamentoTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $EquipamentoTableTable,
    EquipamentoTableData,
    $$EquipamentoTableTableFilterComposer,
    $$EquipamentoTableTableOrderingComposer,
    $$EquipamentoTableTableAnnotationComposer,
    $$EquipamentoTableTableCreateCompanionBuilder,
    $$EquipamentoTableTableUpdateCompanionBuilder,
    (EquipamentoTableData, $$EquipamentoTableTableReferences),
    EquipamentoTableData,
    PrefetchHooks Function(
        {bool grupoId, bool subgrupoId, bool atividadeTableRefs})> {
  $$EquipamentoTableTableTableManager(
      _$AppDatabase db, $EquipamentoTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EquipamentoTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EquipamentoTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EquipamentoTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> uuid = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<bool> sincronizado = const Value.absent(),
            Value<String> nome = const Value.absent(),
            Value<String> descricao = const Value.absent(),
            Value<String> subestacao = const Value.absent(),
            Value<int> grupoId = const Value.absent(),
            Value<int> subgrupoId = const Value.absent(),
          }) =>
              EquipamentoTableCompanion(
            id: id,
            uuid: uuid,
            createdAt: createdAt,
            updatedAt: updatedAt,
            sincronizado: sincronizado,
            nome: nome,
            descricao: descricao,
            subestacao: subestacao,
            grupoId: grupoId,
            subgrupoId: subgrupoId,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String uuid,
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<bool> sincronizado = const Value.absent(),
            required String nome,
            required String descricao,
            required String subestacao,
            required int grupoId,
            required int subgrupoId,
          }) =>
              EquipamentoTableCompanion.insert(
            id: id,
            uuid: uuid,
            createdAt: createdAt,
            updatedAt: updatedAt,
            sincronizado: sincronizado,
            nome: nome,
            descricao: descricao,
            subestacao: subestacao,
            grupoId: grupoId,
            subgrupoId: subgrupoId,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$EquipamentoTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {grupoId = false,
              subgrupoId = false,
              atividadeTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (atividadeTableRefs) db.atividadeTable
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (grupoId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.grupoId,
                    referencedTable:
                        $$EquipamentoTableTableReferences._grupoIdTable(db),
                    referencedColumn:
                        $$EquipamentoTableTableReferences._grupoIdTable(db).id,
                  ) as T;
                }
                if (subgrupoId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.subgrupoId,
                    referencedTable:
                        $$EquipamentoTableTableReferences._subgrupoIdTable(db),
                    referencedColumn: $$EquipamentoTableTableReferences
                        ._subgrupoIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (atividadeTableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$EquipamentoTableTableReferences
                            ._atividadeTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$EquipamentoTableTableReferences(db, table, p0)
                                .atividadeTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.equipamentoId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$EquipamentoTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $EquipamentoTableTable,
    EquipamentoTableData,
    $$EquipamentoTableTableFilterComposer,
    $$EquipamentoTableTableOrderingComposer,
    $$EquipamentoTableTableAnnotationComposer,
    $$EquipamentoTableTableCreateCompanionBuilder,
    $$EquipamentoTableTableUpdateCompanionBuilder,
    (EquipamentoTableData, $$EquipamentoTableTableReferences),
    EquipamentoTableData,
    PrefetchHooks Function(
        {bool grupoId, bool subgrupoId, bool atividadeTableRefs})>;
typedef $$AtividadeTableTableCreateCompanionBuilder = AtividadeTableCompanion
    Function({
  Value<int> id,
  required String uuid,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<bool> sincronizado,
  required String titulo,
  required String ordemServico,
  required String descricao,
  required DateTime dataLimite,
  required String subestacao,
  required int equipamentoId,
  required StatusAtividade status,
  Value<DateTime?> dataInicio,
  Value<DateTime?> dataFim,
  required int tipoAtividadeId,
  required TipoAtividadeMobile tipoAtividadeMobile,
});
typedef $$AtividadeTableTableUpdateCompanionBuilder = AtividadeTableCompanion
    Function({
  Value<int> id,
  Value<String> uuid,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<bool> sincronizado,
  Value<String> titulo,
  Value<String> ordemServico,
  Value<String> descricao,
  Value<DateTime> dataLimite,
  Value<String> subestacao,
  Value<int> equipamentoId,
  Value<StatusAtividade> status,
  Value<DateTime?> dataInicio,
  Value<DateTime?> dataFim,
  Value<int> tipoAtividadeId,
  Value<TipoAtividadeMobile> tipoAtividadeMobile,
});

final class $$AtividadeTableTableReferences extends BaseReferences<
    _$AppDatabase, $AtividadeTableTable, AtividadeTableData> {
  $$AtividadeTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $EquipamentoTableTable _equipamentoIdTable(_$AppDatabase db) =>
      db.equipamentoTable.createAlias($_aliasNameGenerator(
          db.atividadeTable.equipamentoId, db.equipamentoTable.id));

  $$EquipamentoTableTableProcessedTableManager get equipamentoId {
    final manager =
        $$EquipamentoTableTableTableManager($_db, $_db.equipamentoTable)
            .filter((f) => f.id($_item.equipamentoId));
    final item = $_typedResult.readTableOrNull(_equipamentoIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $TipoAtividadeTableTable _tipoAtividadeIdTable(_$AppDatabase db) =>
      db.tipoAtividadeTable.createAlias($_aliasNameGenerator(
          db.atividadeTable.tipoAtividadeId, db.tipoAtividadeTable.id));

  $$TipoAtividadeTableTableProcessedTableManager get tipoAtividadeId {
    final manager =
        $$TipoAtividadeTableTableTableManager($_db, $_db.tipoAtividadeTable)
            .filter((f) => f.id($_item.tipoAtividadeId));
    final item = $_typedResult.readTableOrNull(_tipoAtividadeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$AprPreenchidaTableTable,
      List<AprPreenchidaTableData>> _aprPreenchidaTableRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.aprPreenchidaTable,
          aliasName: $_aliasNameGenerator(
              db.atividadeTable.id, db.aprPreenchidaTable.atividadeId));

  $$AprPreenchidaTableTableProcessedTableManager get aprPreenchidaTableRefs {
    final manager =
        $$AprPreenchidaTableTableTableManager($_db, $_db.aprPreenchidaTable)
            .filter((f) => f.atividadeId.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_aprPreenchidaTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$AtividadeTableTableFilterComposer
    extends Composer<_$AppDatabase, $AtividadeTableTable> {
  $$AtividadeTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get uuid => $composableBuilder(
      column: $table.uuid, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get sincronizado => $composableBuilder(
      column: $table.sincronizado, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get titulo => $composableBuilder(
      column: $table.titulo, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get ordemServico => $composableBuilder(
      column: $table.ordemServico, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get descricao => $composableBuilder(
      column: $table.descricao, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dataLimite => $composableBuilder(
      column: $table.dataLimite, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get subestacao => $composableBuilder(
      column: $table.subestacao, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<StatusAtividade, StatusAtividade, String>
      get status => $composableBuilder(
          column: $table.status,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<DateTime> get dataInicio => $composableBuilder(
      column: $table.dataInicio, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dataFim => $composableBuilder(
      column: $table.dataFim, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<TipoAtividadeMobile, TipoAtividadeMobile,
          String>
      get tipoAtividadeMobile => $composableBuilder(
          column: $table.tipoAtividadeMobile,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  $$EquipamentoTableTableFilterComposer get equipamentoId {
    final $$EquipamentoTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.equipamentoId,
        referencedTable: $db.equipamentoTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EquipamentoTableTableFilterComposer(
              $db: $db,
              $table: $db.equipamentoTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TipoAtividadeTableTableFilterComposer get tipoAtividadeId {
    final $$TipoAtividadeTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.tipoAtividadeId,
        referencedTable: $db.tipoAtividadeTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TipoAtividadeTableTableFilterComposer(
              $db: $db,
              $table: $db.tipoAtividadeTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> aprPreenchidaTableRefs(
      Expression<bool> Function($$AprPreenchidaTableTableFilterComposer f) f) {
    final $$AprPreenchidaTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.aprPreenchidaTable,
        getReferencedColumn: (t) => t.atividadeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AprPreenchidaTableTableFilterComposer(
              $db: $db,
              $table: $db.aprPreenchidaTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$AtividadeTableTableOrderingComposer
    extends Composer<_$AppDatabase, $AtividadeTableTable> {
  $$AtividadeTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get uuid => $composableBuilder(
      column: $table.uuid, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get sincronizado => $composableBuilder(
      column: $table.sincronizado,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get titulo => $composableBuilder(
      column: $table.titulo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get ordemServico => $composableBuilder(
      column: $table.ordemServico,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get descricao => $composableBuilder(
      column: $table.descricao, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dataLimite => $composableBuilder(
      column: $table.dataLimite, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get subestacao => $composableBuilder(
      column: $table.subestacao, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dataInicio => $composableBuilder(
      column: $table.dataInicio, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dataFim => $composableBuilder(
      column: $table.dataFim, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tipoAtividadeMobile => $composableBuilder(
      column: $table.tipoAtividadeMobile,
      builder: (column) => ColumnOrderings(column));

  $$EquipamentoTableTableOrderingComposer get equipamentoId {
    final $$EquipamentoTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.equipamentoId,
        referencedTable: $db.equipamentoTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EquipamentoTableTableOrderingComposer(
              $db: $db,
              $table: $db.equipamentoTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TipoAtividadeTableTableOrderingComposer get tipoAtividadeId {
    final $$TipoAtividadeTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.tipoAtividadeId,
        referencedTable: $db.tipoAtividadeTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TipoAtividadeTableTableOrderingComposer(
              $db: $db,
              $table: $db.tipoAtividadeTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$AtividadeTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $AtividadeTableTable> {
  $$AtividadeTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get uuid =>
      $composableBuilder(column: $table.uuid, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get sincronizado => $composableBuilder(
      column: $table.sincronizado, builder: (column) => column);

  GeneratedColumn<String> get titulo =>
      $composableBuilder(column: $table.titulo, builder: (column) => column);

  GeneratedColumn<String> get ordemServico => $composableBuilder(
      column: $table.ordemServico, builder: (column) => column);

  GeneratedColumn<String> get descricao =>
      $composableBuilder(column: $table.descricao, builder: (column) => column);

  GeneratedColumn<DateTime> get dataLimite => $composableBuilder(
      column: $table.dataLimite, builder: (column) => column);

  GeneratedColumn<String> get subestacao => $composableBuilder(
      column: $table.subestacao, builder: (column) => column);

  GeneratedColumnWithTypeConverter<StatusAtividade, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get dataInicio => $composableBuilder(
      column: $table.dataInicio, builder: (column) => column);

  GeneratedColumn<DateTime> get dataFim =>
      $composableBuilder(column: $table.dataFim, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TipoAtividadeMobile, String>
      get tipoAtividadeMobile => $composableBuilder(
          column: $table.tipoAtividadeMobile, builder: (column) => column);

  $$EquipamentoTableTableAnnotationComposer get equipamentoId {
    final $$EquipamentoTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.equipamentoId,
        referencedTable: $db.equipamentoTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EquipamentoTableTableAnnotationComposer(
              $db: $db,
              $table: $db.equipamentoTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TipoAtividadeTableTableAnnotationComposer get tipoAtividadeId {
    final $$TipoAtividadeTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.tipoAtividadeId,
            referencedTable: $db.tipoAtividadeTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$TipoAtividadeTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.tipoAtividadeTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }

  Expression<T> aprPreenchidaTableRefs<T extends Object>(
      Expression<T> Function($$AprPreenchidaTableTableAnnotationComposer a) f) {
    final $$AprPreenchidaTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.aprPreenchidaTable,
            getReferencedColumn: (t) => t.atividadeId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$AprPreenchidaTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.aprPreenchidaTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$AtividadeTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AtividadeTableTable,
    AtividadeTableData,
    $$AtividadeTableTableFilterComposer,
    $$AtividadeTableTableOrderingComposer,
    $$AtividadeTableTableAnnotationComposer,
    $$AtividadeTableTableCreateCompanionBuilder,
    $$AtividadeTableTableUpdateCompanionBuilder,
    (AtividadeTableData, $$AtividadeTableTableReferences),
    AtividadeTableData,
    PrefetchHooks Function(
        {bool equipamentoId,
        bool tipoAtividadeId,
        bool aprPreenchidaTableRefs})> {
  $$AtividadeTableTableTableManager(
      _$AppDatabase db, $AtividadeTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AtividadeTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AtividadeTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AtividadeTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> uuid = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<bool> sincronizado = const Value.absent(),
            Value<String> titulo = const Value.absent(),
            Value<String> ordemServico = const Value.absent(),
            Value<String> descricao = const Value.absent(),
            Value<DateTime> dataLimite = const Value.absent(),
            Value<String> subestacao = const Value.absent(),
            Value<int> equipamentoId = const Value.absent(),
            Value<StatusAtividade> status = const Value.absent(),
            Value<DateTime?> dataInicio = const Value.absent(),
            Value<DateTime?> dataFim = const Value.absent(),
            Value<int> tipoAtividadeId = const Value.absent(),
            Value<TipoAtividadeMobile> tipoAtividadeMobile =
                const Value.absent(),
          }) =>
              AtividadeTableCompanion(
            id: id,
            uuid: uuid,
            createdAt: createdAt,
            updatedAt: updatedAt,
            sincronizado: sincronizado,
            titulo: titulo,
            ordemServico: ordemServico,
            descricao: descricao,
            dataLimite: dataLimite,
            subestacao: subestacao,
            equipamentoId: equipamentoId,
            status: status,
            dataInicio: dataInicio,
            dataFim: dataFim,
            tipoAtividadeId: tipoAtividadeId,
            tipoAtividadeMobile: tipoAtividadeMobile,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String uuid,
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<bool> sincronizado = const Value.absent(),
            required String titulo,
            required String ordemServico,
            required String descricao,
            required DateTime dataLimite,
            required String subestacao,
            required int equipamentoId,
            required StatusAtividade status,
            Value<DateTime?> dataInicio = const Value.absent(),
            Value<DateTime?> dataFim = const Value.absent(),
            required int tipoAtividadeId,
            required TipoAtividadeMobile tipoAtividadeMobile,
          }) =>
              AtividadeTableCompanion.insert(
            id: id,
            uuid: uuid,
            createdAt: createdAt,
            updatedAt: updatedAt,
            sincronizado: sincronizado,
            titulo: titulo,
            ordemServico: ordemServico,
            descricao: descricao,
            dataLimite: dataLimite,
            subestacao: subestacao,
            equipamentoId: equipamentoId,
            status: status,
            dataInicio: dataInicio,
            dataFim: dataFim,
            tipoAtividadeId: tipoAtividadeId,
            tipoAtividadeMobile: tipoAtividadeMobile,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$AtividadeTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {equipamentoId = false,
              tipoAtividadeId = false,
              aprPreenchidaTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (aprPreenchidaTableRefs) db.aprPreenchidaTable
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (equipamentoId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.equipamentoId,
                    referencedTable:
                        $$AtividadeTableTableReferences._equipamentoIdTable(db),
                    referencedColumn: $$AtividadeTableTableReferences
                        ._equipamentoIdTable(db)
                        .id,
                  ) as T;
                }
                if (tipoAtividadeId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.tipoAtividadeId,
                    referencedTable: $$AtividadeTableTableReferences
                        ._tipoAtividadeIdTable(db),
                    referencedColumn: $$AtividadeTableTableReferences
                        ._tipoAtividadeIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (aprPreenchidaTableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$AtividadeTableTableReferences
                            ._aprPreenchidaTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$AtividadeTableTableReferences(db, table, p0)
                                .aprPreenchidaTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.atividadeId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$AtividadeTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AtividadeTableTable,
    AtividadeTableData,
    $$AtividadeTableTableFilterComposer,
    $$AtividadeTableTableOrderingComposer,
    $$AtividadeTableTableAnnotationComposer,
    $$AtividadeTableTableCreateCompanionBuilder,
    $$AtividadeTableTableUpdateCompanionBuilder,
    (AtividadeTableData, $$AtividadeTableTableReferences),
    AtividadeTableData,
    PrefetchHooks Function(
        {bool equipamentoId,
        bool tipoAtividadeId,
        bool aprPreenchidaTableRefs})>;
typedef $$AprTableTableCreateCompanionBuilder = AprTableCompanion Function({
  Value<int> id,
  required String uuid,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<bool> sincronizado,
  required String nome,
  Value<String?> descricao,
});
typedef $$AprTableTableUpdateCompanionBuilder = AprTableCompanion Function({
  Value<int> id,
  Value<String> uuid,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<bool> sincronizado,
  Value<String> nome,
  Value<String?> descricao,
});

final class $$AprTableTableReferences
    extends BaseReferences<_$AppDatabase, $AprTableTable, AprTableData> {
  $$AprTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$AprPreenchidaTableTable,
      List<AprPreenchidaTableData>> _aprPreenchidaTableRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.aprPreenchidaTable,
          aliasName: $_aliasNameGenerator(
              db.aprTable.id, db.aprPreenchidaTable.aprId));

  $$AprPreenchidaTableTableProcessedTableManager get aprPreenchidaTableRefs {
    final manager =
        $$AprPreenchidaTableTableTableManager($_db, $_db.aprPreenchidaTable)
            .filter((f) => f.aprId.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_aprPreenchidaTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$AprPerguntaRelacionamentoTableTable,
          List<AprPerguntaRelacionamentoTableData>>
      _aprPerguntaRelacionamentoTableRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.aprPerguntaRelacionamentoTable,
              aliasName: $_aliasNameGenerator(
                  db.aprTable.id, db.aprPerguntaRelacionamentoTable.aprId));

  $$AprPerguntaRelacionamentoTableTableProcessedTableManager
      get aprPerguntaRelacionamentoTableRefs {
    final manager = $$AprPerguntaRelacionamentoTableTableTableManager(
            $_db, $_db.aprPerguntaRelacionamentoTable)
        .filter((f) => f.aprId.id($_item.id));

    final cache = $_typedResult
        .readTableOrNull(_aprPerguntaRelacionamentoTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$AprTableTableFilterComposer
    extends Composer<_$AppDatabase, $AprTableTable> {
  $$AprTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get uuid => $composableBuilder(
      column: $table.uuid, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get sincronizado => $composableBuilder(
      column: $table.sincronizado, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nome => $composableBuilder(
      column: $table.nome, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get descricao => $composableBuilder(
      column: $table.descricao, builder: (column) => ColumnFilters(column));

  Expression<bool> aprPreenchidaTableRefs(
      Expression<bool> Function($$AprPreenchidaTableTableFilterComposer f) f) {
    final $$AprPreenchidaTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.aprPreenchidaTable,
        getReferencedColumn: (t) => t.aprId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AprPreenchidaTableTableFilterComposer(
              $db: $db,
              $table: $db.aprPreenchidaTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> aprPerguntaRelacionamentoTableRefs(
      Expression<bool> Function(
              $$AprPerguntaRelacionamentoTableTableFilterComposer f)
          f) {
    final $$AprPerguntaRelacionamentoTableTableFilterComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.aprPerguntaRelacionamentoTable,
            getReferencedColumn: (t) => t.aprId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$AprPerguntaRelacionamentoTableTableFilterComposer(
                  $db: $db,
                  $table: $db.aprPerguntaRelacionamentoTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$AprTableTableOrderingComposer
    extends Composer<_$AppDatabase, $AprTableTable> {
  $$AprTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get uuid => $composableBuilder(
      column: $table.uuid, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get sincronizado => $composableBuilder(
      column: $table.sincronizado,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nome => $composableBuilder(
      column: $table.nome, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get descricao => $composableBuilder(
      column: $table.descricao, builder: (column) => ColumnOrderings(column));
}

class $$AprTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $AprTableTable> {
  $$AprTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get uuid =>
      $composableBuilder(column: $table.uuid, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get sincronizado => $composableBuilder(
      column: $table.sincronizado, builder: (column) => column);

  GeneratedColumn<String> get nome =>
      $composableBuilder(column: $table.nome, builder: (column) => column);

  GeneratedColumn<String> get descricao =>
      $composableBuilder(column: $table.descricao, builder: (column) => column);

  Expression<T> aprPreenchidaTableRefs<T extends Object>(
      Expression<T> Function($$AprPreenchidaTableTableAnnotationComposer a) f) {
    final $$AprPreenchidaTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.aprPreenchidaTable,
            getReferencedColumn: (t) => t.aprId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$AprPreenchidaTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.aprPreenchidaTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> aprPerguntaRelacionamentoTableRefs<T extends Object>(
      Expression<T> Function(
              $$AprPerguntaRelacionamentoTableTableAnnotationComposer a)
          f) {
    final $$AprPerguntaRelacionamentoTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.aprPerguntaRelacionamentoTable,
            getReferencedColumn: (t) => t.aprId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$AprPerguntaRelacionamentoTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.aprPerguntaRelacionamentoTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$AprTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AprTableTable,
    AprTableData,
    $$AprTableTableFilterComposer,
    $$AprTableTableOrderingComposer,
    $$AprTableTableAnnotationComposer,
    $$AprTableTableCreateCompanionBuilder,
    $$AprTableTableUpdateCompanionBuilder,
    (AprTableData, $$AprTableTableReferences),
    AprTableData,
    PrefetchHooks Function(
        {bool aprPreenchidaTableRefs,
        bool aprPerguntaRelacionamentoTableRefs})> {
  $$AprTableTableTableManager(_$AppDatabase db, $AprTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AprTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AprTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AprTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> uuid = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<bool> sincronizado = const Value.absent(),
            Value<String> nome = const Value.absent(),
            Value<String?> descricao = const Value.absent(),
          }) =>
              AprTableCompanion(
            id: id,
            uuid: uuid,
            createdAt: createdAt,
            updatedAt: updatedAt,
            sincronizado: sincronizado,
            nome: nome,
            descricao: descricao,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String uuid,
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<bool> sincronizado = const Value.absent(),
            required String nome,
            Value<String?> descricao = const Value.absent(),
          }) =>
              AprTableCompanion.insert(
            id: id,
            uuid: uuid,
            createdAt: createdAt,
            updatedAt: updatedAt,
            sincronizado: sincronizado,
            nome: nome,
            descricao: descricao,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$AprTableTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {aprPreenchidaTableRefs = false,
              aprPerguntaRelacionamentoTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (aprPreenchidaTableRefs) db.aprPreenchidaTable,
                if (aprPerguntaRelacionamentoTableRefs)
                  db.aprPerguntaRelacionamentoTable
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (aprPreenchidaTableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$AprTableTableReferences
                            ._aprPreenchidaTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$AprTableTableReferences(db, table, p0)
                                .aprPreenchidaTableRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.aprId == item.id),
                        typedResults: items),
                  if (aprPerguntaRelacionamentoTableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$AprTableTableReferences
                            ._aprPerguntaRelacionamentoTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$AprTableTableReferences(db, table, p0)
                                .aprPerguntaRelacionamentoTableRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.aprId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$AprTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AprTableTable,
    AprTableData,
    $$AprTableTableFilterComposer,
    $$AprTableTableOrderingComposer,
    $$AprTableTableAnnotationComposer,
    $$AprTableTableCreateCompanionBuilder,
    $$AprTableTableUpdateCompanionBuilder,
    (AprTableData, $$AprTableTableReferences),
    AprTableData,
    PrefetchHooks Function(
        {bool aprPreenchidaTableRefs,
        bool aprPerguntaRelacionamentoTableRefs})>;
typedef $$AprQuestionTableTableCreateCompanionBuilder
    = AprQuestionTableCompanion Function({
  Value<int> id,
  required String uuid,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<bool> sincronizado,
  required String texto,
});
typedef $$AprQuestionTableTableUpdateCompanionBuilder
    = AprQuestionTableCompanion Function({
  Value<int> id,
  Value<String> uuid,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<bool> sincronizado,
  Value<String> texto,
});

final class $$AprQuestionTableTableReferences extends BaseReferences<
    _$AppDatabase, $AprQuestionTableTable, AprQuestionTableData> {
  $$AprQuestionTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$AprRespostaTableTable, List<AprRespostaTableData>>
      _aprRespostaTableRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.aprRespostaTable,
              aliasName: $_aliasNameGenerator(
                  db.aprQuestionTable.id, db.aprRespostaTable.perguntaId));

  $$AprRespostaTableTableProcessedTableManager get aprRespostaTableRefs {
    final manager =
        $$AprRespostaTableTableTableManager($_db, $_db.aprRespostaTable)
            .filter((f) => f.perguntaId.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_aprRespostaTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$AprPerguntaRelacionamentoTableTable,
          List<AprPerguntaRelacionamentoTableData>>
      _aprPerguntaRelacionamentoTableRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.aprPerguntaRelacionamentoTable,
              aliasName: $_aliasNameGenerator(db.aprQuestionTable.id,
                  db.aprPerguntaRelacionamentoTable.perguntaId));

  $$AprPerguntaRelacionamentoTableTableProcessedTableManager
      get aprPerguntaRelacionamentoTableRefs {
    final manager = $$AprPerguntaRelacionamentoTableTableTableManager(
            $_db, $_db.aprPerguntaRelacionamentoTable)
        .filter((f) => f.perguntaId.id($_item.id));

    final cache = $_typedResult
        .readTableOrNull(_aprPerguntaRelacionamentoTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$AprQuestionTableTableFilterComposer
    extends Composer<_$AppDatabase, $AprQuestionTableTable> {
  $$AprQuestionTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get uuid => $composableBuilder(
      column: $table.uuid, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get sincronizado => $composableBuilder(
      column: $table.sincronizado, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get texto => $composableBuilder(
      column: $table.texto, builder: (column) => ColumnFilters(column));

  Expression<bool> aprRespostaTableRefs(
      Expression<bool> Function($$AprRespostaTableTableFilterComposer f) f) {
    final $$AprRespostaTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.aprRespostaTable,
        getReferencedColumn: (t) => t.perguntaId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AprRespostaTableTableFilterComposer(
              $db: $db,
              $table: $db.aprRespostaTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> aprPerguntaRelacionamentoTableRefs(
      Expression<bool> Function(
              $$AprPerguntaRelacionamentoTableTableFilterComposer f)
          f) {
    final $$AprPerguntaRelacionamentoTableTableFilterComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.aprPerguntaRelacionamentoTable,
            getReferencedColumn: (t) => t.perguntaId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$AprPerguntaRelacionamentoTableTableFilterComposer(
                  $db: $db,
                  $table: $db.aprPerguntaRelacionamentoTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$AprQuestionTableTableOrderingComposer
    extends Composer<_$AppDatabase, $AprQuestionTableTable> {
  $$AprQuestionTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get uuid => $composableBuilder(
      column: $table.uuid, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get sincronizado => $composableBuilder(
      column: $table.sincronizado,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get texto => $composableBuilder(
      column: $table.texto, builder: (column) => ColumnOrderings(column));
}

class $$AprQuestionTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $AprQuestionTableTable> {
  $$AprQuestionTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get uuid =>
      $composableBuilder(column: $table.uuid, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get sincronizado => $composableBuilder(
      column: $table.sincronizado, builder: (column) => column);

  GeneratedColumn<String> get texto =>
      $composableBuilder(column: $table.texto, builder: (column) => column);

  Expression<T> aprRespostaTableRefs<T extends Object>(
      Expression<T> Function($$AprRespostaTableTableAnnotationComposer a) f) {
    final $$AprRespostaTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.aprRespostaTable,
        getReferencedColumn: (t) => t.perguntaId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AprRespostaTableTableAnnotationComposer(
              $db: $db,
              $table: $db.aprRespostaTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> aprPerguntaRelacionamentoTableRefs<T extends Object>(
      Expression<T> Function(
              $$AprPerguntaRelacionamentoTableTableAnnotationComposer a)
          f) {
    final $$AprPerguntaRelacionamentoTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.aprPerguntaRelacionamentoTable,
            getReferencedColumn: (t) => t.perguntaId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$AprPerguntaRelacionamentoTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.aprPerguntaRelacionamentoTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$AprQuestionTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AprQuestionTableTable,
    AprQuestionTableData,
    $$AprQuestionTableTableFilterComposer,
    $$AprQuestionTableTableOrderingComposer,
    $$AprQuestionTableTableAnnotationComposer,
    $$AprQuestionTableTableCreateCompanionBuilder,
    $$AprQuestionTableTableUpdateCompanionBuilder,
    (AprQuestionTableData, $$AprQuestionTableTableReferences),
    AprQuestionTableData,
    PrefetchHooks Function(
        {bool aprRespostaTableRefs, bool aprPerguntaRelacionamentoTableRefs})> {
  $$AprQuestionTableTableTableManager(
      _$AppDatabase db, $AprQuestionTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AprQuestionTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AprQuestionTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AprQuestionTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> uuid = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<bool> sincronizado = const Value.absent(),
            Value<String> texto = const Value.absent(),
          }) =>
              AprQuestionTableCompanion(
            id: id,
            uuid: uuid,
            createdAt: createdAt,
            updatedAt: updatedAt,
            sincronizado: sincronizado,
            texto: texto,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String uuid,
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<bool> sincronizado = const Value.absent(),
            required String texto,
          }) =>
              AprQuestionTableCompanion.insert(
            id: id,
            uuid: uuid,
            createdAt: createdAt,
            updatedAt: updatedAt,
            sincronizado: sincronizado,
            texto: texto,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$AprQuestionTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {aprRespostaTableRefs = false,
              aprPerguntaRelacionamentoTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (aprRespostaTableRefs) db.aprRespostaTable,
                if (aprPerguntaRelacionamentoTableRefs)
                  db.aprPerguntaRelacionamentoTable
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (aprRespostaTableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$AprQuestionTableTableReferences
                            ._aprRespostaTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$AprQuestionTableTableReferences(db, table, p0)
                                .aprRespostaTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.perguntaId == item.id),
                        typedResults: items),
                  if (aprPerguntaRelacionamentoTableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$AprQuestionTableTableReferences
                            ._aprPerguntaRelacionamentoTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$AprQuestionTableTableReferences(db, table, p0)
                                .aprPerguntaRelacionamentoTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.perguntaId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$AprQuestionTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AprQuestionTableTable,
    AprQuestionTableData,
    $$AprQuestionTableTableFilterComposer,
    $$AprQuestionTableTableOrderingComposer,
    $$AprQuestionTableTableAnnotationComposer,
    $$AprQuestionTableTableCreateCompanionBuilder,
    $$AprQuestionTableTableUpdateCompanionBuilder,
    (AprQuestionTableData, $$AprQuestionTableTableReferences),
    AprQuestionTableData,
    PrefetchHooks Function(
        {bool aprRespostaTableRefs, bool aprPerguntaRelacionamentoTableRefs})>;
typedef $$AprPreenchidaTableTableCreateCompanionBuilder
    = AprPreenchidaTableCompanion Function({
  Value<int> id,
  required int atividadeId,
  required int aprId,
  required int usuarioId,
  required DateTime dataPreenchimento,
});
typedef $$AprPreenchidaTableTableUpdateCompanionBuilder
    = AprPreenchidaTableCompanion Function({
  Value<int> id,
  Value<int> atividadeId,
  Value<int> aprId,
  Value<int> usuarioId,
  Value<DateTime> dataPreenchimento,
});

final class $$AprPreenchidaTableTableReferences extends BaseReferences<
    _$AppDatabase, $AprPreenchidaTableTable, AprPreenchidaTableData> {
  $$AprPreenchidaTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $AtividadeTableTable _atividadeIdTable(_$AppDatabase db) =>
      db.atividadeTable.createAlias($_aliasNameGenerator(
          db.aprPreenchidaTable.atividadeId, db.atividadeTable.id));

  $$AtividadeTableTableProcessedTableManager get atividadeId {
    final manager = $$AtividadeTableTableTableManager($_db, $_db.atividadeTable)
        .filter((f) => f.id($_item.atividadeId));
    final item = $_typedResult.readTableOrNull(_atividadeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $AprTableTable _aprIdTable(_$AppDatabase db) =>
      db.aprTable.createAlias(
          $_aliasNameGenerator(db.aprPreenchidaTable.aprId, db.aprTable.id));

  $$AprTableTableProcessedTableManager get aprId {
    final manager = $$AprTableTableTableManager($_db, $_db.aprTable)
        .filter((f) => f.id($_item.aprId));
    final item = $_typedResult.readTableOrNull(_aprIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $UsuarioTableTable _usuarioIdTable(_$AppDatabase db) =>
      db.usuarioTable.createAlias($_aliasNameGenerator(
          db.aprPreenchidaTable.usuarioId, db.usuarioTable.id));

  $$UsuarioTableTableProcessedTableManager get usuarioId {
    final manager = $$UsuarioTableTableTableManager($_db, $_db.usuarioTable)
        .filter((f) => f.id($_item.usuarioId));
    final item = $_typedResult.readTableOrNull(_usuarioIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$AprRespostaTableTable, List<AprRespostaTableData>>
      _aprRespostaTableRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.aprRespostaTable,
              aliasName: $_aliasNameGenerator(db.aprPreenchidaTable.id,
                  db.aprRespostaTable.aprPreenchidaId));

  $$AprRespostaTableTableProcessedTableManager get aprRespostaTableRefs {
    final manager =
        $$AprRespostaTableTableTableManager($_db, $_db.aprRespostaTable)
            .filter((f) => f.aprPreenchidaId.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_aprRespostaTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$AprAssinaturaTableTable,
      List<AprAssinaturaTableData>> _aprAssinaturaTableRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.aprAssinaturaTable,
          aliasName: $_aliasNameGenerator(
              db.aprPreenchidaTable.id, db.aprAssinaturaTable.aprPreenchidaId));

  $$AprAssinaturaTableTableProcessedTableManager get aprAssinaturaTableRefs {
    final manager =
        $$AprAssinaturaTableTableTableManager($_db, $_db.aprAssinaturaTable)
            .filter((f) => f.aprPreenchidaId.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_aprAssinaturaTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$AprPreenchidaTableTableFilterComposer
    extends Composer<_$AppDatabase, $AprPreenchidaTableTable> {
  $$AprPreenchidaTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dataPreenchimento => $composableBuilder(
      column: $table.dataPreenchimento,
      builder: (column) => ColumnFilters(column));

  $$AtividadeTableTableFilterComposer get atividadeId {
    final $$AtividadeTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.atividadeId,
        referencedTable: $db.atividadeTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AtividadeTableTableFilterComposer(
              $db: $db,
              $table: $db.atividadeTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$AprTableTableFilterComposer get aprId {
    final $$AprTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.aprId,
        referencedTable: $db.aprTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AprTableTableFilterComposer(
              $db: $db,
              $table: $db.aprTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UsuarioTableTableFilterComposer get usuarioId {
    final $$UsuarioTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.usuarioId,
        referencedTable: $db.usuarioTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsuarioTableTableFilterComposer(
              $db: $db,
              $table: $db.usuarioTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> aprRespostaTableRefs(
      Expression<bool> Function($$AprRespostaTableTableFilterComposer f) f) {
    final $$AprRespostaTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.aprRespostaTable,
        getReferencedColumn: (t) => t.aprPreenchidaId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AprRespostaTableTableFilterComposer(
              $db: $db,
              $table: $db.aprRespostaTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> aprAssinaturaTableRefs(
      Expression<bool> Function($$AprAssinaturaTableTableFilterComposer f) f) {
    final $$AprAssinaturaTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.aprAssinaturaTable,
        getReferencedColumn: (t) => t.aprPreenchidaId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AprAssinaturaTableTableFilterComposer(
              $db: $db,
              $table: $db.aprAssinaturaTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$AprPreenchidaTableTableOrderingComposer
    extends Composer<_$AppDatabase, $AprPreenchidaTableTable> {
  $$AprPreenchidaTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dataPreenchimento => $composableBuilder(
      column: $table.dataPreenchimento,
      builder: (column) => ColumnOrderings(column));

  $$AtividadeTableTableOrderingComposer get atividadeId {
    final $$AtividadeTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.atividadeId,
        referencedTable: $db.atividadeTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AtividadeTableTableOrderingComposer(
              $db: $db,
              $table: $db.atividadeTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$AprTableTableOrderingComposer get aprId {
    final $$AprTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.aprId,
        referencedTable: $db.aprTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AprTableTableOrderingComposer(
              $db: $db,
              $table: $db.aprTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UsuarioTableTableOrderingComposer get usuarioId {
    final $$UsuarioTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.usuarioId,
        referencedTable: $db.usuarioTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsuarioTableTableOrderingComposer(
              $db: $db,
              $table: $db.usuarioTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$AprPreenchidaTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $AprPreenchidaTableTable> {
  $$AprPreenchidaTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get dataPreenchimento => $composableBuilder(
      column: $table.dataPreenchimento, builder: (column) => column);

  $$AtividadeTableTableAnnotationComposer get atividadeId {
    final $$AtividadeTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.atividadeId,
        referencedTable: $db.atividadeTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AtividadeTableTableAnnotationComposer(
              $db: $db,
              $table: $db.atividadeTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$AprTableTableAnnotationComposer get aprId {
    final $$AprTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.aprId,
        referencedTable: $db.aprTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AprTableTableAnnotationComposer(
              $db: $db,
              $table: $db.aprTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UsuarioTableTableAnnotationComposer get usuarioId {
    final $$UsuarioTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.usuarioId,
        referencedTable: $db.usuarioTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsuarioTableTableAnnotationComposer(
              $db: $db,
              $table: $db.usuarioTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> aprRespostaTableRefs<T extends Object>(
      Expression<T> Function($$AprRespostaTableTableAnnotationComposer a) f) {
    final $$AprRespostaTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.aprRespostaTable,
        getReferencedColumn: (t) => t.aprPreenchidaId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AprRespostaTableTableAnnotationComposer(
              $db: $db,
              $table: $db.aprRespostaTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> aprAssinaturaTableRefs<T extends Object>(
      Expression<T> Function($$AprAssinaturaTableTableAnnotationComposer a) f) {
    final $$AprAssinaturaTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.aprAssinaturaTable,
            getReferencedColumn: (t) => t.aprPreenchidaId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$AprAssinaturaTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.aprAssinaturaTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$AprPreenchidaTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AprPreenchidaTableTable,
    AprPreenchidaTableData,
    $$AprPreenchidaTableTableFilterComposer,
    $$AprPreenchidaTableTableOrderingComposer,
    $$AprPreenchidaTableTableAnnotationComposer,
    $$AprPreenchidaTableTableCreateCompanionBuilder,
    $$AprPreenchidaTableTableUpdateCompanionBuilder,
    (AprPreenchidaTableData, $$AprPreenchidaTableTableReferences),
    AprPreenchidaTableData,
    PrefetchHooks Function(
        {bool atividadeId,
        bool aprId,
        bool usuarioId,
        bool aprRespostaTableRefs,
        bool aprAssinaturaTableRefs})> {
  $$AprPreenchidaTableTableTableManager(
      _$AppDatabase db, $AprPreenchidaTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AprPreenchidaTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AprPreenchidaTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AprPreenchidaTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> atividadeId = const Value.absent(),
            Value<int> aprId = const Value.absent(),
            Value<int> usuarioId = const Value.absent(),
            Value<DateTime> dataPreenchimento = const Value.absent(),
          }) =>
              AprPreenchidaTableCompanion(
            id: id,
            atividadeId: atividadeId,
            aprId: aprId,
            usuarioId: usuarioId,
            dataPreenchimento: dataPreenchimento,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int atividadeId,
            required int aprId,
            required int usuarioId,
            required DateTime dataPreenchimento,
          }) =>
              AprPreenchidaTableCompanion.insert(
            id: id,
            atividadeId: atividadeId,
            aprId: aprId,
            usuarioId: usuarioId,
            dataPreenchimento: dataPreenchimento,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$AprPreenchidaTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {atividadeId = false,
              aprId = false,
              usuarioId = false,
              aprRespostaTableRefs = false,
              aprAssinaturaTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (aprRespostaTableRefs) db.aprRespostaTable,
                if (aprAssinaturaTableRefs) db.aprAssinaturaTable
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (atividadeId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.atividadeId,
                    referencedTable: $$AprPreenchidaTableTableReferences
                        ._atividadeIdTable(db),
                    referencedColumn: $$AprPreenchidaTableTableReferences
                        ._atividadeIdTable(db)
                        .id,
                  ) as T;
                }
                if (aprId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.aprId,
                    referencedTable:
                        $$AprPreenchidaTableTableReferences._aprIdTable(db),
                    referencedColumn:
                        $$AprPreenchidaTableTableReferences._aprIdTable(db).id,
                  ) as T;
                }
                if (usuarioId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.usuarioId,
                    referencedTable:
                        $$AprPreenchidaTableTableReferences._usuarioIdTable(db),
                    referencedColumn: $$AprPreenchidaTableTableReferences
                        ._usuarioIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (aprRespostaTableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$AprPreenchidaTableTableReferences
                            ._aprRespostaTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$AprPreenchidaTableTableReferences(db, table, p0)
                                .aprRespostaTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.aprPreenchidaId == item.id),
                        typedResults: items),
                  if (aprAssinaturaTableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$AprPreenchidaTableTableReferences
                            ._aprAssinaturaTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$AprPreenchidaTableTableReferences(db, table, p0)
                                .aprAssinaturaTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.aprPreenchidaId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$AprPreenchidaTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AprPreenchidaTableTable,
    AprPreenchidaTableData,
    $$AprPreenchidaTableTableFilterComposer,
    $$AprPreenchidaTableTableOrderingComposer,
    $$AprPreenchidaTableTableAnnotationComposer,
    $$AprPreenchidaTableTableCreateCompanionBuilder,
    $$AprPreenchidaTableTableUpdateCompanionBuilder,
    (AprPreenchidaTableData, $$AprPreenchidaTableTableReferences),
    AprPreenchidaTableData,
    PrefetchHooks Function(
        {bool atividadeId,
        bool aprId,
        bool usuarioId,
        bool aprRespostaTableRefs,
        bool aprAssinaturaTableRefs})>;
typedef $$AprRespostaTableTableCreateCompanionBuilder
    = AprRespostaTableCompanion Function({
  Value<int> id,
  required int aprPreenchidaId,
  required int perguntaId,
  required RespostaApr resposta,
  Value<String?> observacao,
});
typedef $$AprRespostaTableTableUpdateCompanionBuilder
    = AprRespostaTableCompanion Function({
  Value<int> id,
  Value<int> aprPreenchidaId,
  Value<int> perguntaId,
  Value<RespostaApr> resposta,
  Value<String?> observacao,
});

final class $$AprRespostaTableTableReferences extends BaseReferences<
    _$AppDatabase, $AprRespostaTableTable, AprRespostaTableData> {
  $$AprRespostaTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $AprPreenchidaTableTable _aprPreenchidaIdTable(_$AppDatabase db) =>
      db.aprPreenchidaTable.createAlias($_aliasNameGenerator(
          db.aprRespostaTable.aprPreenchidaId, db.aprPreenchidaTable.id));

  $$AprPreenchidaTableTableProcessedTableManager get aprPreenchidaId {
    final manager =
        $$AprPreenchidaTableTableTableManager($_db, $_db.aprPreenchidaTable)
            .filter((f) => f.id($_item.aprPreenchidaId));
    final item = $_typedResult.readTableOrNull(_aprPreenchidaIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $AprQuestionTableTable _perguntaIdTable(_$AppDatabase db) =>
      db.aprQuestionTable.createAlias($_aliasNameGenerator(
          db.aprRespostaTable.perguntaId, db.aprQuestionTable.id));

  $$AprQuestionTableTableProcessedTableManager get perguntaId {
    final manager =
        $$AprQuestionTableTableTableManager($_db, $_db.aprQuestionTable)
            .filter((f) => f.id($_item.perguntaId));
    final item = $_typedResult.readTableOrNull(_perguntaIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$AprRespostaTableTableFilterComposer
    extends Composer<_$AppDatabase, $AprRespostaTableTable> {
  $$AprRespostaTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<RespostaApr, RespostaApr, String>
      get resposta => $composableBuilder(
          column: $table.resposta,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<String> get observacao => $composableBuilder(
      column: $table.observacao, builder: (column) => ColumnFilters(column));

  $$AprPreenchidaTableTableFilterComposer get aprPreenchidaId {
    final $$AprPreenchidaTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.aprPreenchidaId,
        referencedTable: $db.aprPreenchidaTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AprPreenchidaTableTableFilterComposer(
              $db: $db,
              $table: $db.aprPreenchidaTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$AprQuestionTableTableFilterComposer get perguntaId {
    final $$AprQuestionTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.perguntaId,
        referencedTable: $db.aprQuestionTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AprQuestionTableTableFilterComposer(
              $db: $db,
              $table: $db.aprQuestionTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$AprRespostaTableTableOrderingComposer
    extends Composer<_$AppDatabase, $AprRespostaTableTable> {
  $$AprRespostaTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get resposta => $composableBuilder(
      column: $table.resposta, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get observacao => $composableBuilder(
      column: $table.observacao, builder: (column) => ColumnOrderings(column));

  $$AprPreenchidaTableTableOrderingComposer get aprPreenchidaId {
    final $$AprPreenchidaTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.aprPreenchidaId,
        referencedTable: $db.aprPreenchidaTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AprPreenchidaTableTableOrderingComposer(
              $db: $db,
              $table: $db.aprPreenchidaTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$AprQuestionTableTableOrderingComposer get perguntaId {
    final $$AprQuestionTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.perguntaId,
        referencedTable: $db.aprQuestionTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AprQuestionTableTableOrderingComposer(
              $db: $db,
              $table: $db.aprQuestionTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$AprRespostaTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $AprRespostaTableTable> {
  $$AprRespostaTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<RespostaApr, String> get resposta =>
      $composableBuilder(column: $table.resposta, builder: (column) => column);

  GeneratedColumn<String> get observacao => $composableBuilder(
      column: $table.observacao, builder: (column) => column);

  $$AprPreenchidaTableTableAnnotationComposer get aprPreenchidaId {
    final $$AprPreenchidaTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.aprPreenchidaId,
            referencedTable: $db.aprPreenchidaTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$AprPreenchidaTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.aprPreenchidaTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }

  $$AprQuestionTableTableAnnotationComposer get perguntaId {
    final $$AprQuestionTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.perguntaId,
        referencedTable: $db.aprQuestionTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AprQuestionTableTableAnnotationComposer(
              $db: $db,
              $table: $db.aprQuestionTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$AprRespostaTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AprRespostaTableTable,
    AprRespostaTableData,
    $$AprRespostaTableTableFilterComposer,
    $$AprRespostaTableTableOrderingComposer,
    $$AprRespostaTableTableAnnotationComposer,
    $$AprRespostaTableTableCreateCompanionBuilder,
    $$AprRespostaTableTableUpdateCompanionBuilder,
    (AprRespostaTableData, $$AprRespostaTableTableReferences),
    AprRespostaTableData,
    PrefetchHooks Function({bool aprPreenchidaId, bool perguntaId})> {
  $$AprRespostaTableTableTableManager(
      _$AppDatabase db, $AprRespostaTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AprRespostaTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AprRespostaTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AprRespostaTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> aprPreenchidaId = const Value.absent(),
            Value<int> perguntaId = const Value.absent(),
            Value<RespostaApr> resposta = const Value.absent(),
            Value<String?> observacao = const Value.absent(),
          }) =>
              AprRespostaTableCompanion(
            id: id,
            aprPreenchidaId: aprPreenchidaId,
            perguntaId: perguntaId,
            resposta: resposta,
            observacao: observacao,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int aprPreenchidaId,
            required int perguntaId,
            required RespostaApr resposta,
            Value<String?> observacao = const Value.absent(),
          }) =>
              AprRespostaTableCompanion.insert(
            id: id,
            aprPreenchidaId: aprPreenchidaId,
            perguntaId: perguntaId,
            resposta: resposta,
            observacao: observacao,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$AprRespostaTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {aprPreenchidaId = false, perguntaId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (aprPreenchidaId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.aprPreenchidaId,
                    referencedTable: $$AprRespostaTableTableReferences
                        ._aprPreenchidaIdTable(db),
                    referencedColumn: $$AprRespostaTableTableReferences
                        ._aprPreenchidaIdTable(db)
                        .id,
                  ) as T;
                }
                if (perguntaId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.perguntaId,
                    referencedTable:
                        $$AprRespostaTableTableReferences._perguntaIdTable(db),
                    referencedColumn: $$AprRespostaTableTableReferences
                        ._perguntaIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$AprRespostaTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AprRespostaTableTable,
    AprRespostaTableData,
    $$AprRespostaTableTableFilterComposer,
    $$AprRespostaTableTableOrderingComposer,
    $$AprRespostaTableTableAnnotationComposer,
    $$AprRespostaTableTableCreateCompanionBuilder,
    $$AprRespostaTableTableUpdateCompanionBuilder,
    (AprRespostaTableData, $$AprRespostaTableTableReferences),
    AprRespostaTableData,
    PrefetchHooks Function({bool aprPreenchidaId, bool perguntaId})>;
typedef $$AprPerguntaRelacionamentoTableTableCreateCompanionBuilder
    = AprPerguntaRelacionamentoTableCompanion Function({
  Value<int> id,
  required String uuid,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<bool> sincronizado,
  required int aprId,
  required int perguntaId,
  required int ordem,
});
typedef $$AprPerguntaRelacionamentoTableTableUpdateCompanionBuilder
    = AprPerguntaRelacionamentoTableCompanion Function({
  Value<int> id,
  Value<String> uuid,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<bool> sincronizado,
  Value<int> aprId,
  Value<int> perguntaId,
  Value<int> ordem,
});

final class $$AprPerguntaRelacionamentoTableTableReferences
    extends BaseReferences<_$AppDatabase, $AprPerguntaRelacionamentoTableTable,
        AprPerguntaRelacionamentoTableData> {
  $$AprPerguntaRelacionamentoTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $AprTableTable _aprIdTable(_$AppDatabase db) =>
      db.aprTable.createAlias($_aliasNameGenerator(
          db.aprPerguntaRelacionamentoTable.aprId, db.aprTable.id));

  $$AprTableTableProcessedTableManager get aprId {
    final manager = $$AprTableTableTableManager($_db, $_db.aprTable)
        .filter((f) => f.id($_item.aprId));
    final item = $_typedResult.readTableOrNull(_aprIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $AprQuestionTableTable _perguntaIdTable(_$AppDatabase db) =>
      db.aprQuestionTable.createAlias($_aliasNameGenerator(
          db.aprPerguntaRelacionamentoTable.perguntaId,
          db.aprQuestionTable.id));

  $$AprQuestionTableTableProcessedTableManager get perguntaId {
    final manager =
        $$AprQuestionTableTableTableManager($_db, $_db.aprQuestionTable)
            .filter((f) => f.id($_item.perguntaId));
    final item = $_typedResult.readTableOrNull(_perguntaIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$AprPerguntaRelacionamentoTableTableFilterComposer
    extends Composer<_$AppDatabase, $AprPerguntaRelacionamentoTableTable> {
  $$AprPerguntaRelacionamentoTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get uuid => $composableBuilder(
      column: $table.uuid, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get sincronizado => $composableBuilder(
      column: $table.sincronizado, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get ordem => $composableBuilder(
      column: $table.ordem, builder: (column) => ColumnFilters(column));

  $$AprTableTableFilterComposer get aprId {
    final $$AprTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.aprId,
        referencedTable: $db.aprTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AprTableTableFilterComposer(
              $db: $db,
              $table: $db.aprTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$AprQuestionTableTableFilterComposer get perguntaId {
    final $$AprQuestionTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.perguntaId,
        referencedTable: $db.aprQuestionTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AprQuestionTableTableFilterComposer(
              $db: $db,
              $table: $db.aprQuestionTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$AprPerguntaRelacionamentoTableTableOrderingComposer
    extends Composer<_$AppDatabase, $AprPerguntaRelacionamentoTableTable> {
  $$AprPerguntaRelacionamentoTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get uuid => $composableBuilder(
      column: $table.uuid, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get sincronizado => $composableBuilder(
      column: $table.sincronizado,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get ordem => $composableBuilder(
      column: $table.ordem, builder: (column) => ColumnOrderings(column));

  $$AprTableTableOrderingComposer get aprId {
    final $$AprTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.aprId,
        referencedTable: $db.aprTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AprTableTableOrderingComposer(
              $db: $db,
              $table: $db.aprTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$AprQuestionTableTableOrderingComposer get perguntaId {
    final $$AprQuestionTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.perguntaId,
        referencedTable: $db.aprQuestionTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AprQuestionTableTableOrderingComposer(
              $db: $db,
              $table: $db.aprQuestionTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$AprPerguntaRelacionamentoTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $AprPerguntaRelacionamentoTableTable> {
  $$AprPerguntaRelacionamentoTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get uuid =>
      $composableBuilder(column: $table.uuid, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get sincronizado => $composableBuilder(
      column: $table.sincronizado, builder: (column) => column);

  GeneratedColumn<int> get ordem =>
      $composableBuilder(column: $table.ordem, builder: (column) => column);

  $$AprTableTableAnnotationComposer get aprId {
    final $$AprTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.aprId,
        referencedTable: $db.aprTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AprTableTableAnnotationComposer(
              $db: $db,
              $table: $db.aprTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$AprQuestionTableTableAnnotationComposer get perguntaId {
    final $$AprQuestionTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.perguntaId,
        referencedTable: $db.aprQuestionTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AprQuestionTableTableAnnotationComposer(
              $db: $db,
              $table: $db.aprQuestionTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$AprPerguntaRelacionamentoTableTableTableManager
    extends RootTableManager<
        _$AppDatabase,
        $AprPerguntaRelacionamentoTableTable,
        AprPerguntaRelacionamentoTableData,
        $$AprPerguntaRelacionamentoTableTableFilterComposer,
        $$AprPerguntaRelacionamentoTableTableOrderingComposer,
        $$AprPerguntaRelacionamentoTableTableAnnotationComposer,
        $$AprPerguntaRelacionamentoTableTableCreateCompanionBuilder,
        $$AprPerguntaRelacionamentoTableTableUpdateCompanionBuilder,
        (
          AprPerguntaRelacionamentoTableData,
          $$AprPerguntaRelacionamentoTableTableReferences
        ),
        AprPerguntaRelacionamentoTableData,
        PrefetchHooks Function({bool aprId, bool perguntaId})> {
  $$AprPerguntaRelacionamentoTableTableTableManager(
      _$AppDatabase db, $AprPerguntaRelacionamentoTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AprPerguntaRelacionamentoTableTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$AprPerguntaRelacionamentoTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AprPerguntaRelacionamentoTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> uuid = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<bool> sincronizado = const Value.absent(),
            Value<int> aprId = const Value.absent(),
            Value<int> perguntaId = const Value.absent(),
            Value<int> ordem = const Value.absent(),
          }) =>
              AprPerguntaRelacionamentoTableCompanion(
            id: id,
            uuid: uuid,
            createdAt: createdAt,
            updatedAt: updatedAt,
            sincronizado: sincronizado,
            aprId: aprId,
            perguntaId: perguntaId,
            ordem: ordem,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String uuid,
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<bool> sincronizado = const Value.absent(),
            required int aprId,
            required int perguntaId,
            required int ordem,
          }) =>
              AprPerguntaRelacionamentoTableCompanion.insert(
            id: id,
            uuid: uuid,
            createdAt: createdAt,
            updatedAt: updatedAt,
            sincronizado: sincronizado,
            aprId: aprId,
            perguntaId: perguntaId,
            ordem: ordem,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$AprPerguntaRelacionamentoTableTableReferences(
                        db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({aprId = false, perguntaId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (aprId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.aprId,
                    referencedTable:
                        $$AprPerguntaRelacionamentoTableTableReferences
                            ._aprIdTable(db),
                    referencedColumn:
                        $$AprPerguntaRelacionamentoTableTableReferences
                            ._aprIdTable(db)
                            .id,
                  ) as T;
                }
                if (perguntaId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.perguntaId,
                    referencedTable:
                        $$AprPerguntaRelacionamentoTableTableReferences
                            ._perguntaIdTable(db),
                    referencedColumn:
                        $$AprPerguntaRelacionamentoTableTableReferences
                            ._perguntaIdTable(db)
                            .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$AprPerguntaRelacionamentoTableTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $AprPerguntaRelacionamentoTableTable,
        AprPerguntaRelacionamentoTableData,
        $$AprPerguntaRelacionamentoTableTableFilterComposer,
        $$AprPerguntaRelacionamentoTableTableOrderingComposer,
        $$AprPerguntaRelacionamentoTableTableAnnotationComposer,
        $$AprPerguntaRelacionamentoTableTableCreateCompanionBuilder,
        $$AprPerguntaRelacionamentoTableTableUpdateCompanionBuilder,
        (
          AprPerguntaRelacionamentoTableData,
          $$AprPerguntaRelacionamentoTableTableReferences
        ),
        AprPerguntaRelacionamentoTableData,
        PrefetchHooks Function({bool aprId, bool perguntaId})>;
typedef $$TecnicosTableTableCreateCompanionBuilder = TecnicosTableCompanion
    Function({
  Value<int> id,
  required String uuid,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<bool> sincronizado,
  required String nome,
  required String matricula,
});
typedef $$TecnicosTableTableUpdateCompanionBuilder = TecnicosTableCompanion
    Function({
  Value<int> id,
  Value<String> uuid,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<bool> sincronizado,
  Value<String> nome,
  Value<String> matricula,
});

final class $$TecnicosTableTableReferences extends BaseReferences<_$AppDatabase,
    $TecnicosTableTable, TecnicosTableData> {
  $$TecnicosTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$AprAssinaturaTableTable,
      List<AprAssinaturaTableData>> _aprAssinaturaTableRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.aprAssinaturaTable,
          aliasName: $_aliasNameGenerator(
              db.tecnicosTable.id, db.aprAssinaturaTable.tecnicoId));

  $$AprAssinaturaTableTableProcessedTableManager get aprAssinaturaTableRefs {
    final manager =
        $$AprAssinaturaTableTableTableManager($_db, $_db.aprAssinaturaTable)
            .filter((f) => f.tecnicoId.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_aprAssinaturaTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$TecnicosTableTableFilterComposer
    extends Composer<_$AppDatabase, $TecnicosTableTable> {
  $$TecnicosTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get uuid => $composableBuilder(
      column: $table.uuid, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get sincronizado => $composableBuilder(
      column: $table.sincronizado, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nome => $composableBuilder(
      column: $table.nome, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get matricula => $composableBuilder(
      column: $table.matricula, builder: (column) => ColumnFilters(column));

  Expression<bool> aprAssinaturaTableRefs(
      Expression<bool> Function($$AprAssinaturaTableTableFilterComposer f) f) {
    final $$AprAssinaturaTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.aprAssinaturaTable,
        getReferencedColumn: (t) => t.tecnicoId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AprAssinaturaTableTableFilterComposer(
              $db: $db,
              $table: $db.aprAssinaturaTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$TecnicosTableTableOrderingComposer
    extends Composer<_$AppDatabase, $TecnicosTableTable> {
  $$TecnicosTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get uuid => $composableBuilder(
      column: $table.uuid, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get sincronizado => $composableBuilder(
      column: $table.sincronizado,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nome => $composableBuilder(
      column: $table.nome, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get matricula => $composableBuilder(
      column: $table.matricula, builder: (column) => ColumnOrderings(column));
}

class $$TecnicosTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $TecnicosTableTable> {
  $$TecnicosTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get uuid =>
      $composableBuilder(column: $table.uuid, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get sincronizado => $composableBuilder(
      column: $table.sincronizado, builder: (column) => column);

  GeneratedColumn<String> get nome =>
      $composableBuilder(column: $table.nome, builder: (column) => column);

  GeneratedColumn<String> get matricula =>
      $composableBuilder(column: $table.matricula, builder: (column) => column);

  Expression<T> aprAssinaturaTableRefs<T extends Object>(
      Expression<T> Function($$AprAssinaturaTableTableAnnotationComposer a) f) {
    final $$AprAssinaturaTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.aprAssinaturaTable,
            getReferencedColumn: (t) => t.tecnicoId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$AprAssinaturaTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.aprAssinaturaTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$TecnicosTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TecnicosTableTable,
    TecnicosTableData,
    $$TecnicosTableTableFilterComposer,
    $$TecnicosTableTableOrderingComposer,
    $$TecnicosTableTableAnnotationComposer,
    $$TecnicosTableTableCreateCompanionBuilder,
    $$TecnicosTableTableUpdateCompanionBuilder,
    (TecnicosTableData, $$TecnicosTableTableReferences),
    TecnicosTableData,
    PrefetchHooks Function({bool aprAssinaturaTableRefs})> {
  $$TecnicosTableTableTableManager(_$AppDatabase db, $TecnicosTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TecnicosTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TecnicosTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TecnicosTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> uuid = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<bool> sincronizado = const Value.absent(),
            Value<String> nome = const Value.absent(),
            Value<String> matricula = const Value.absent(),
          }) =>
              TecnicosTableCompanion(
            id: id,
            uuid: uuid,
            createdAt: createdAt,
            updatedAt: updatedAt,
            sincronizado: sincronizado,
            nome: nome,
            matricula: matricula,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String uuid,
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<bool> sincronizado = const Value.absent(),
            required String nome,
            required String matricula,
          }) =>
              TecnicosTableCompanion.insert(
            id: id,
            uuid: uuid,
            createdAt: createdAt,
            updatedAt: updatedAt,
            sincronizado: sincronizado,
            nome: nome,
            matricula: matricula,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$TecnicosTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({aprAssinaturaTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (aprAssinaturaTableRefs) db.aprAssinaturaTable
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (aprAssinaturaTableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$TecnicosTableTableReferences
                            ._aprAssinaturaTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$TecnicosTableTableReferences(db, table, p0)
                                .aprAssinaturaTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.tecnicoId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$TecnicosTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TecnicosTableTable,
    TecnicosTableData,
    $$TecnicosTableTableFilterComposer,
    $$TecnicosTableTableOrderingComposer,
    $$TecnicosTableTableAnnotationComposer,
    $$TecnicosTableTableCreateCompanionBuilder,
    $$TecnicosTableTableUpdateCompanionBuilder,
    (TecnicosTableData, $$TecnicosTableTableReferences),
    TecnicosTableData,
    PrefetchHooks Function({bool aprAssinaturaTableRefs})>;
typedef $$AprAssinaturaTableTableCreateCompanionBuilder
    = AprAssinaturaTableCompanion Function({
  Value<int> id,
  required int aprPreenchidaId,
  required int usuarioId,
  required DateTime dataAssinatura,
  required int tecnicoId,
  required String assinatura,
  Value<String?> assinaturaPath,
});
typedef $$AprAssinaturaTableTableUpdateCompanionBuilder
    = AprAssinaturaTableCompanion Function({
  Value<int> id,
  Value<int> aprPreenchidaId,
  Value<int> usuarioId,
  Value<DateTime> dataAssinatura,
  Value<int> tecnicoId,
  Value<String> assinatura,
  Value<String?> assinaturaPath,
});

final class $$AprAssinaturaTableTableReferences extends BaseReferences<
    _$AppDatabase, $AprAssinaturaTableTable, AprAssinaturaTableData> {
  $$AprAssinaturaTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $AprPreenchidaTableTable _aprPreenchidaIdTable(_$AppDatabase db) =>
      db.aprPreenchidaTable.createAlias($_aliasNameGenerator(
          db.aprAssinaturaTable.aprPreenchidaId, db.aprPreenchidaTable.id));

  $$AprPreenchidaTableTableProcessedTableManager get aprPreenchidaId {
    final manager =
        $$AprPreenchidaTableTableTableManager($_db, $_db.aprPreenchidaTable)
            .filter((f) => f.id($_item.aprPreenchidaId));
    final item = $_typedResult.readTableOrNull(_aprPreenchidaIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $UsuarioTableTable _usuarioIdTable(_$AppDatabase db) =>
      db.usuarioTable.createAlias($_aliasNameGenerator(
          db.aprAssinaturaTable.usuarioId, db.usuarioTable.id));

  $$UsuarioTableTableProcessedTableManager get usuarioId {
    final manager = $$UsuarioTableTableTableManager($_db, $_db.usuarioTable)
        .filter((f) => f.id($_item.usuarioId));
    final item = $_typedResult.readTableOrNull(_usuarioIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $TecnicosTableTable _tecnicoIdTable(_$AppDatabase db) =>
      db.tecnicosTable.createAlias($_aliasNameGenerator(
          db.aprAssinaturaTable.tecnicoId, db.tecnicosTable.id));

  $$TecnicosTableTableProcessedTableManager get tecnicoId {
    final manager = $$TecnicosTableTableTableManager($_db, $_db.tecnicosTable)
        .filter((f) => f.id($_item.tecnicoId));
    final item = $_typedResult.readTableOrNull(_tecnicoIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$AprAssinaturaTableTableFilterComposer
    extends Composer<_$AppDatabase, $AprAssinaturaTableTable> {
  $$AprAssinaturaTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dataAssinatura => $composableBuilder(
      column: $table.dataAssinatura,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get assinatura => $composableBuilder(
      column: $table.assinatura, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get assinaturaPath => $composableBuilder(
      column: $table.assinaturaPath,
      builder: (column) => ColumnFilters(column));

  $$AprPreenchidaTableTableFilterComposer get aprPreenchidaId {
    final $$AprPreenchidaTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.aprPreenchidaId,
        referencedTable: $db.aprPreenchidaTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AprPreenchidaTableTableFilterComposer(
              $db: $db,
              $table: $db.aprPreenchidaTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UsuarioTableTableFilterComposer get usuarioId {
    final $$UsuarioTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.usuarioId,
        referencedTable: $db.usuarioTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsuarioTableTableFilterComposer(
              $db: $db,
              $table: $db.usuarioTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TecnicosTableTableFilterComposer get tecnicoId {
    final $$TecnicosTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.tecnicoId,
        referencedTable: $db.tecnicosTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TecnicosTableTableFilterComposer(
              $db: $db,
              $table: $db.tecnicosTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$AprAssinaturaTableTableOrderingComposer
    extends Composer<_$AppDatabase, $AprAssinaturaTableTable> {
  $$AprAssinaturaTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dataAssinatura => $composableBuilder(
      column: $table.dataAssinatura,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get assinatura => $composableBuilder(
      column: $table.assinatura, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get assinaturaPath => $composableBuilder(
      column: $table.assinaturaPath,
      builder: (column) => ColumnOrderings(column));

  $$AprPreenchidaTableTableOrderingComposer get aprPreenchidaId {
    final $$AprPreenchidaTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.aprPreenchidaId,
        referencedTable: $db.aprPreenchidaTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AprPreenchidaTableTableOrderingComposer(
              $db: $db,
              $table: $db.aprPreenchidaTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UsuarioTableTableOrderingComposer get usuarioId {
    final $$UsuarioTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.usuarioId,
        referencedTable: $db.usuarioTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsuarioTableTableOrderingComposer(
              $db: $db,
              $table: $db.usuarioTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TecnicosTableTableOrderingComposer get tecnicoId {
    final $$TecnicosTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.tecnicoId,
        referencedTable: $db.tecnicosTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TecnicosTableTableOrderingComposer(
              $db: $db,
              $table: $db.tecnicosTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$AprAssinaturaTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $AprAssinaturaTableTable> {
  $$AprAssinaturaTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get dataAssinatura => $composableBuilder(
      column: $table.dataAssinatura, builder: (column) => column);

  GeneratedColumn<String> get assinatura => $composableBuilder(
      column: $table.assinatura, builder: (column) => column);

  GeneratedColumn<String> get assinaturaPath => $composableBuilder(
      column: $table.assinaturaPath, builder: (column) => column);

  $$AprPreenchidaTableTableAnnotationComposer get aprPreenchidaId {
    final $$AprPreenchidaTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.aprPreenchidaId,
            referencedTable: $db.aprPreenchidaTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$AprPreenchidaTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.aprPreenchidaTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }

  $$UsuarioTableTableAnnotationComposer get usuarioId {
    final $$UsuarioTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.usuarioId,
        referencedTable: $db.usuarioTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsuarioTableTableAnnotationComposer(
              $db: $db,
              $table: $db.usuarioTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TecnicosTableTableAnnotationComposer get tecnicoId {
    final $$TecnicosTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.tecnicoId,
        referencedTable: $db.tecnicosTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TecnicosTableTableAnnotationComposer(
              $db: $db,
              $table: $db.tecnicosTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$AprAssinaturaTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AprAssinaturaTableTable,
    AprAssinaturaTableData,
    $$AprAssinaturaTableTableFilterComposer,
    $$AprAssinaturaTableTableOrderingComposer,
    $$AprAssinaturaTableTableAnnotationComposer,
    $$AprAssinaturaTableTableCreateCompanionBuilder,
    $$AprAssinaturaTableTableUpdateCompanionBuilder,
    (AprAssinaturaTableData, $$AprAssinaturaTableTableReferences),
    AprAssinaturaTableData,
    PrefetchHooks Function(
        {bool aprPreenchidaId, bool usuarioId, bool tecnicoId})> {
  $$AprAssinaturaTableTableTableManager(
      _$AppDatabase db, $AprAssinaturaTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AprAssinaturaTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AprAssinaturaTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AprAssinaturaTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> aprPreenchidaId = const Value.absent(),
            Value<int> usuarioId = const Value.absent(),
            Value<DateTime> dataAssinatura = const Value.absent(),
            Value<int> tecnicoId = const Value.absent(),
            Value<String> assinatura = const Value.absent(),
            Value<String?> assinaturaPath = const Value.absent(),
          }) =>
              AprAssinaturaTableCompanion(
            id: id,
            aprPreenchidaId: aprPreenchidaId,
            usuarioId: usuarioId,
            dataAssinatura: dataAssinatura,
            tecnicoId: tecnicoId,
            assinatura: assinatura,
            assinaturaPath: assinaturaPath,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int aprPreenchidaId,
            required int usuarioId,
            required DateTime dataAssinatura,
            required int tecnicoId,
            required String assinatura,
            Value<String?> assinaturaPath = const Value.absent(),
          }) =>
              AprAssinaturaTableCompanion.insert(
            id: id,
            aprPreenchidaId: aprPreenchidaId,
            usuarioId: usuarioId,
            dataAssinatura: dataAssinatura,
            tecnicoId: tecnicoId,
            assinatura: assinatura,
            assinaturaPath: assinaturaPath,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$AprAssinaturaTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {aprPreenchidaId = false, usuarioId = false, tecnicoId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (aprPreenchidaId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.aprPreenchidaId,
                    referencedTable: $$AprAssinaturaTableTableReferences
                        ._aprPreenchidaIdTable(db),
                    referencedColumn: $$AprAssinaturaTableTableReferences
                        ._aprPreenchidaIdTable(db)
                        .id,
                  ) as T;
                }
                if (usuarioId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.usuarioId,
                    referencedTable:
                        $$AprAssinaturaTableTableReferences._usuarioIdTable(db),
                    referencedColumn: $$AprAssinaturaTableTableReferences
                        ._usuarioIdTable(db)
                        .id,
                  ) as T;
                }
                if (tecnicoId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.tecnicoId,
                    referencedTable:
                        $$AprAssinaturaTableTableReferences._tecnicoIdTable(db),
                    referencedColumn: $$AprAssinaturaTableTableReferences
                        ._tecnicoIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$AprAssinaturaTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AprAssinaturaTableTable,
    AprAssinaturaTableData,
    $$AprAssinaturaTableTableFilterComposer,
    $$AprAssinaturaTableTableOrderingComposer,
    $$AprAssinaturaTableTableAnnotationComposer,
    $$AprAssinaturaTableTableCreateCompanionBuilder,
    $$AprAssinaturaTableTableUpdateCompanionBuilder,
    (AprAssinaturaTableData, $$AprAssinaturaTableTableReferences),
    AprAssinaturaTableData,
    PrefetchHooks Function(
        {bool aprPreenchidaId, bool usuarioId, bool tecnicoId})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UsuarioTableTableTableManager get usuarioTable =>
      $$UsuarioTableTableTableManager(_db, _db.usuarioTable);
  $$TipoAtividadeTableTableTableManager get tipoAtividadeTable =>
      $$TipoAtividadeTableTableTableManager(_db, _db.tipoAtividadeTable);
  $$GrupoDefeitoEquipamentoTableTableTableManager
      get grupoDefeitoEquipamentoTable =>
          $$GrupoDefeitoEquipamentoTableTableTableManager(
              _db, _db.grupoDefeitoEquipamentoTable);
  $$SubgrupoDefeitoEquipamentoTableTableTableManager
      get subgrupoDefeitoEquipamentoTable =>
          $$SubgrupoDefeitoEquipamentoTableTableTableManager(
              _db, _db.subgrupoDefeitoEquipamentoTable);
  $$EquipamentoTableTableTableManager get equipamentoTable =>
      $$EquipamentoTableTableTableManager(_db, _db.equipamentoTable);
  $$AtividadeTableTableTableManager get atividadeTable =>
      $$AtividadeTableTableTableManager(_db, _db.atividadeTable);
  $$AprTableTableTableManager get aprTable =>
      $$AprTableTableTableManager(_db, _db.aprTable);
  $$AprQuestionTableTableTableManager get aprQuestionTable =>
      $$AprQuestionTableTableTableManager(_db, _db.aprQuestionTable);
  $$AprPreenchidaTableTableTableManager get aprPreenchidaTable =>
      $$AprPreenchidaTableTableTableManager(_db, _db.aprPreenchidaTable);
  $$AprRespostaTableTableTableManager get aprRespostaTable =>
      $$AprRespostaTableTableTableManager(_db, _db.aprRespostaTable);
  $$AprPerguntaRelacionamentoTableTableTableManager
      get aprPerguntaRelacionamentoTable =>
          $$AprPerguntaRelacionamentoTableTableTableManager(
              _db, _db.aprPerguntaRelacionamentoTable);
  $$TecnicosTableTableTableManager get tecnicosTable =>
      $$TecnicosTableTableTableManager(_db, _db.tecnicosTable);
  $$AprAssinaturaTableTableTableManager get aprAssinaturaTable =>
      $$AprAssinaturaTableTableTableManager(_db, _db.aprAssinaturaTable);
}
