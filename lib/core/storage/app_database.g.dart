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
  static const VerificationMeta _equipamentoIdMeta =
      const VerificationMeta('equipamentoId');
  @override
  late final GeneratedColumn<int> equipamentoId = GeneratedColumn<int>(
      'equipamento_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES equipamento_table (id)'));
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
        status,
        dataInicio,
        dataFim,
        tipoAtividadeId,
        equipamentoId
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
    if (data.containsKey('equipamento_id')) {
      context.handle(
          _equipamentoIdMeta,
          equipamentoId.isAcceptableOrUnknown(
              data['equipamento_id']!, _equipamentoIdMeta));
    } else if (isInserting) {
      context.missing(_equipamentoIdMeta);
    }
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
      status: $AtividadeTableTable.$converterstatus.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!),
      dataInicio: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}data_inicio']),
      dataFim: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}data_fim']),
      tipoAtividadeId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}tipo_atividade_id'])!,
      equipamentoId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}equipamento_id'])!,
    );
  }

  @override
  $AtividadeTableTable createAlias(String alias) {
    return $AtividadeTableTable(attachedDatabase, alias);
  }

  static TypeConverter<StatusAtividade, String> $converterstatus =
      const StatusAtividadeConverter();
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
  final StatusAtividade status;
  final DateTime? dataInicio;
  final DateTime? dataFim;
  final int tipoAtividadeId;
  final int equipamentoId;
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
      required this.status,
      this.dataInicio,
      this.dataFim,
      required this.tipoAtividadeId,
      required this.equipamentoId});
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
    map['equipamento_id'] = Variable<int>(equipamentoId);
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
      status: Value(status),
      dataInicio: dataInicio == null && nullToAbsent
          ? const Value.absent()
          : Value(dataInicio),
      dataFim: dataFim == null && nullToAbsent
          ? const Value.absent()
          : Value(dataFim),
      tipoAtividadeId: Value(tipoAtividadeId),
      equipamentoId: Value(equipamentoId),
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
      status: serializer.fromJson<StatusAtividade>(json['status']),
      dataInicio: serializer.fromJson<DateTime?>(json['dataInicio']),
      dataFim: serializer.fromJson<DateTime?>(json['dataFim']),
      tipoAtividadeId: serializer.fromJson<int>(json['tipoAtividadeId']),
      equipamentoId: serializer.fromJson<int>(json['equipamentoId']),
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
      'status': serializer.toJson<StatusAtividade>(status),
      'dataInicio': serializer.toJson<DateTime?>(dataInicio),
      'dataFim': serializer.toJson<DateTime?>(dataFim),
      'tipoAtividadeId': serializer.toJson<int>(tipoAtividadeId),
      'equipamentoId': serializer.toJson<int>(equipamentoId),
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
          StatusAtividade? status,
          Value<DateTime?> dataInicio = const Value.absent(),
          Value<DateTime?> dataFim = const Value.absent(),
          int? tipoAtividadeId,
          int? equipamentoId}) =>
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
        status: status ?? this.status,
        dataInicio: dataInicio.present ? dataInicio.value : this.dataInicio,
        dataFim: dataFim.present ? dataFim.value : this.dataFim,
        tipoAtividadeId: tipoAtividadeId ?? this.tipoAtividadeId,
        equipamentoId: equipamentoId ?? this.equipamentoId,
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
      status: data.status.present ? data.status.value : this.status,
      dataInicio:
          data.dataInicio.present ? data.dataInicio.value : this.dataInicio,
      dataFim: data.dataFim.present ? data.dataFim.value : this.dataFim,
      tipoAtividadeId: data.tipoAtividadeId.present
          ? data.tipoAtividadeId.value
          : this.tipoAtividadeId,
      equipamentoId: data.equipamentoId.present
          ? data.equipamentoId.value
          : this.equipamentoId,
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
          ..write('status: $status, ')
          ..write('dataInicio: $dataInicio, ')
          ..write('dataFim: $dataFim, ')
          ..write('tipoAtividadeId: $tipoAtividadeId, ')
          ..write('equipamentoId: $equipamentoId')
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
      status,
      dataInicio,
      dataFim,
      tipoAtividadeId,
      equipamentoId);
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
          other.status == this.status &&
          other.dataInicio == this.dataInicio &&
          other.dataFim == this.dataFim &&
          other.tipoAtividadeId == this.tipoAtividadeId &&
          other.equipamentoId == this.equipamentoId);
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
  final Value<StatusAtividade> status;
  final Value<DateTime?> dataInicio;
  final Value<DateTime?> dataFim;
  final Value<int> tipoAtividadeId;
  final Value<int> equipamentoId;
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
    this.status = const Value.absent(),
    this.dataInicio = const Value.absent(),
    this.dataFim = const Value.absent(),
    this.tipoAtividadeId = const Value.absent(),
    this.equipamentoId = const Value.absent(),
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
    required StatusAtividade status,
    this.dataInicio = const Value.absent(),
    this.dataFim = const Value.absent(),
    required int tipoAtividadeId,
    required int equipamentoId,
  })  : uuid = Value(uuid),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt),
        titulo = Value(titulo),
        ordemServico = Value(ordemServico),
        descricao = Value(descricao),
        dataLimite = Value(dataLimite),
        subestacao = Value(subestacao),
        status = Value(status),
        tipoAtividadeId = Value(tipoAtividadeId),
        equipamentoId = Value(equipamentoId);
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
    Expression<String>? status,
    Expression<DateTime>? dataInicio,
    Expression<DateTime>? dataFim,
    Expression<int>? tipoAtividadeId,
    Expression<int>? equipamentoId,
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
      if (status != null) 'status': status,
      if (dataInicio != null) 'data_inicio': dataInicio,
      if (dataFim != null) 'data_fim': dataFim,
      if (tipoAtividadeId != null) 'tipo_atividade_id': tipoAtividadeId,
      if (equipamentoId != null) 'equipamento_id': equipamentoId,
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
      Value<StatusAtividade>? status,
      Value<DateTime?>? dataInicio,
      Value<DateTime?>? dataFim,
      Value<int>? tipoAtividadeId,
      Value<int>? equipamentoId}) {
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
      status: status ?? this.status,
      dataInicio: dataInicio ?? this.dataInicio,
      dataFim: dataFim ?? this.dataFim,
      tipoAtividadeId: tipoAtividadeId ?? this.tipoAtividadeId,
      equipamentoId: equipamentoId ?? this.equipamentoId,
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
    if (equipamentoId.present) {
      map['equipamento_id'] = Variable<int>(equipamentoId.value);
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
          ..write('status: $status, ')
          ..write('dataInicio: $dataInicio, ')
          ..write('dataFim: $dataFim, ')
          ..write('tipoAtividadeId: $tipoAtividadeId, ')
          ..write('equipamentoId: $equipamentoId')
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
        atividadeTable
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
  required StatusAtividade status,
  Value<DateTime?> dataInicio,
  Value<DateTime?> dataFim,
  required int tipoAtividadeId,
  required int equipamentoId,
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
  Value<StatusAtividade> status,
  Value<DateTime?> dataInicio,
  Value<DateTime?> dataFim,
  Value<int> tipoAtividadeId,
  Value<int> equipamentoId,
});

final class $$AtividadeTableTableReferences extends BaseReferences<
    _$AppDatabase, $AtividadeTableTable, AtividadeTableData> {
  $$AtividadeTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

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
    PrefetchHooks Function({bool tipoAtividadeId, bool equipamentoId})> {
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
            Value<StatusAtividade> status = const Value.absent(),
            Value<DateTime?> dataInicio = const Value.absent(),
            Value<DateTime?> dataFim = const Value.absent(),
            Value<int> tipoAtividadeId = const Value.absent(),
            Value<int> equipamentoId = const Value.absent(),
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
            status: status,
            dataInicio: dataInicio,
            dataFim: dataFim,
            tipoAtividadeId: tipoAtividadeId,
            equipamentoId: equipamentoId,
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
            required StatusAtividade status,
            Value<DateTime?> dataInicio = const Value.absent(),
            Value<DateTime?> dataFim = const Value.absent(),
            required int tipoAtividadeId,
            required int equipamentoId,
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
            status: status,
            dataInicio: dataInicio,
            dataFim: dataFim,
            tipoAtividadeId: tipoAtividadeId,
            equipamentoId: equipamentoId,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$AtividadeTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {tipoAtividadeId = false, equipamentoId = false}) {
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

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
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
    PrefetchHooks Function({bool tipoAtividadeId, bool equipamentoId})>;

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
}
