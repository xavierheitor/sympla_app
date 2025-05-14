import 'package:sympla_app/core/domain/dto/grupo_defeito_equipamento/equipamento_table_dto.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/equipamento_repository.dart';
import 'package:sympla_app/core/network/dio_client.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/daos/equipamento_dao.dart';

class EquipamentoRepositoryImpl implements EquipamentoRepository {
  final AppDatabase db;
  final EquipamentoDao equipamentoDao;
  final DioClient dio;

  EquipamentoRepositoryImpl(this.db, this.dio)
      : equipamentoDao = db.equipamentoDao;

  @override
  Future<EquipamentoTableDto> buscarEquipamento(String equipamentoId) {
    // TODO: implement buscarEquipamento
    throw UnimplementedError();
  }

  @override
  Future<EquipamentoTableDto> buscarEquipamentoPorSubestacao(
      String subestacao) {
    // TODO: implement buscarEquipamentoPorSubestacao
    throw UnimplementedError();
  }

  @override
  Future<EquipamentoTableDto> buscarEquipamentoPorSubestacaoId(
      String subestacaoId) {
    // TODO: implement buscarEquipamentoPorSubestacaoId
    throw UnimplementedError();
  }

  @override
  Future<List<EquipamentoTableDto>> buscarTodosEquipamentos() {
    // TODO: implement buscarTodosEquipamentos
    throw UnimplementedError();
  }

  @override
  Future<void> deletarEquipamento(String equipamentoId) {
    // TODO: implement deletarEquipamento
    throw UnimplementedError();
  }
}
