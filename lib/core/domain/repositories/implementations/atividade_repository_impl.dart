import 'package:sympla_app/core/domain/dto/atividade/atividade_table_dto.dart';
import 'package:sympla_app/core/domain/dto/atividade/tipo_atividade_table_dto.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/atividade_repository.dart';
import 'package:sympla_app/core/network/dio_client.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/daos/atividade_dao.dart';

class AtividadeRepositoryImpl implements AtividadeRepository {
  final AppDatabase db;
  final AtividadeDao atividadeDao;
  final DioClient dio;

  AtividadeRepositoryImpl(this.db, this.dio) : atividadeDao = db.atividadeDao;

  @override
  Future<AtividadeTableDto> buscarAtividade(String atividadeId) {
    // TODO: implement buscarAtividade
    throw UnimplementedError();
  }

  @override
  Future<AtividadeTableDto> buscarAtividadeEmAndamento() {
    // TODO: implement buscarAtividadeEmAndamento
    throw UnimplementedError();
  }

  @override
  Future<TipoAtividadeTableDto> buscarTipoAtividadePorAtividadeId(
      String atividadeId) {
    // TODO: implement buscarTipoAtividadePorAtividadeId
    throw UnimplementedError();
  }

  @override
  Future<List<AtividadeTableDto>> buscarTodasAtividades() {
    // TODO: implement buscarTodasAtividades
    throw UnimplementedError();
  }

  @override
  Future<List<TipoAtividadeTableDto>> buscarTodosTiposAtividade() {
    // TODO: implement buscarTodosTiposAtividade
    throw UnimplementedError();
  }

  @override
  Future<void> finalizarAtividade(AtividadeTableDto atividade) {
    // TODO: implement finalizarAtividade
    throw UnimplementedError();
  }

  @override
  Future<void> iniciarAtividade(AtividadeTableDto atividade) {
    // TODO: implement iniciarAtividade
    throw UnimplementedError();
  }

  @override
  buscarAtividadesComEquipamento() {
    // TODO: implement buscarAtividadesComEquipamento
    throw UnimplementedError();
  }
}
