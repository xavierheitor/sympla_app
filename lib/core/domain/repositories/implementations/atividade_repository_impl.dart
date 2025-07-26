// lib/core/domain/repositories/impl/atividade_repository_impl.dart

import 'package:sympla_app/core/domain/dto/atividade/atividade_table_dto.dart';
import 'package:sympla_app/core/domain/dto/atividade/tipo_atividade_table_dto.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/atividade_repository.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/repository_helper.dart';
import 'package:sympla_app/core/network/dio_client.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/converters/status_atividade_converter.dart';
import 'package:sympla_app/core/storage/daos/atividade_dao.dart';

class AtividadeRepositoryImpl
    with RepositoryHelper
    implements AtividadeRepository {
  final AppDatabase db;
  final AtividadeDao atividadeDao;
  final DioClient dio;

  AtividadeRepositoryImpl(this.db, this.dio) : atividadeDao = db.atividadeDao;

  // --------------------- Atividades ---------------------

  @override
  Future<AtividadeTableDto?> buscarAtividade(String atividadeId) {
    return executar(
      'buscarAtividade',
      () async {
        final data = await atividadeDao.buscarAtividadePorId(atividadeId);
        return data != null ? AtividadeTableDto.fromData(data) : null;
      },
    );
  }

  @override
  Future<AtividadeTableDto?> buscarAtividadeEmAndamento() {
    return executar(
      'buscarAtividadeEmAndamento',
      () async {
        final data = await atividadeDao.buscarEmAndamento();
        return data != null ? AtividadeTableDto.fromData(data) : null;
      },
    );
  }

  @override
  Future<List<AtividadeTableDto>> buscarTodasAtividades() {
    return executar(
      'buscarTodasAtividades',
      () async {
        final data = await atividadeDao.buscarTodasAtividades();
        return data.map(AtividadeTableDto.fromData).toList();
      },
      onErrorReturn: [],
    );
  }

  @override
  Future<List<AtividadeTableDto>> buscarAtividadesComEquipamento() {
    return executar(
      'buscarAtividadesComEquipamento',
      () async {
        final rows = await atividadeDao.buscarComEquipamento();
        return rows.map((row) {
          final atividade = row.readTable(db.atividadeTable);
          final equipamento = row.readTable(db.equipamentoTable);
          final tipoAtividade = row.readTable(db.tipoAtividadeTable);
          return AtividadeTableDto.fromJoin(
              atividade, equipamento, tipoAtividade);
        }).toList();
      },
      onErrorReturn: [],
    );
  }

  @override
  Future<List<AtividadeTableDto>> buscarAtividadesPorStatus(StatusAtividade status) {
    return executar(
      'buscarAtividadesPorStatus',
      () async {
        final data = await atividadeDao.buscarPorStatus(status);
        return data.map(AtividadeTableDto.fromData).toList();
      },
      onErrorReturn: [],
    );
  }

  @override
  Future<void> iniciarAtividade(AtividadeTableDto atividade) {
    return executar(
      'iniciarAtividade',
      () => atividadeDao.iniciarAtividade(atividade.toCompanion()),
    );
  }

  @override
  Future<void> finalizarAtividade(AtividadeTableDto atividade) {
    return executar(
      'finalizarAtividade',
      () => atividadeDao.finalizarAtividade(atividade.toCompanion()),
    );
  }

  // --------------------- Tipo Atividade ---------------------

  @override
  Future<TipoAtividadeTableDto?> buscarTipoAtividadePorAtividadeId(
      String atividadeId) {
    return executar(
      'buscarTipoAtividadePorAtividadeId',
      () async {
        final data = await atividadeDao.buscarTipoAtividadePorId(atividadeId);
        return TipoAtividadeTableDto.fromData(data);
      },
    );
  }

  @override
  Future<List<TipoAtividadeTableDto>> buscarTodosTiposAtividade() {
    return executar(
      'buscarTodosTiposAtividade',
      () async {
        final data = await atividadeDao.buscarTodosTiposAtividade();
        return data.map(TipoAtividadeTableDto.fromData).toList();
      },
      onErrorReturn: [],
    );
  }
  
  @override
  Future<void> atualizarAtividade(AtividadeTableDto atividade) {
    // TODO: implement atualizarAtividade
    throw UnimplementedError();
  }
}
