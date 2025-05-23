import 'package:sympla_app/core/domain/dto/grupo_defeito_equipamento/equipamento_table_dto.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/equipamento_repository.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/repository_helper.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/network/dio_client.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/daos/equipamento_dao.dart';

/// 🔥 Repositório de Equipamento - Implementação concreta
class EquipamentoRepositoryImpl
    with RepositoryHelper
    implements EquipamentoRepository {
  final AppDatabase db;
  final EquipamentoDao equipamentoDao;
  final DioClient dio;

  EquipamentoRepositoryImpl(this.db, this.dio)
      : equipamentoDao = db.equipamentoDao;

  // --------------------- Buscar por ID ---------------------

  @override
  Future<EquipamentoTableDto> buscarEquipamento(String equipamentoId) {
    return executar('buscarEquipamento', () async {
      final equipamento = await equipamentoDao.buscarPorUuid(equipamentoId);

      if (equipamento == null) {
        AppLogger.w(
            '[EquipamentoRepositoryImpl] Equipamento não encontrado para UUID: $equipamentoId');
        throw Exception('Equipamento não encontrado: $equipamentoId');
      }

      return EquipamentoTableDto.fromData(equipamento);
    });
  }

  // --------------------- Buscar Todos ---------------------

  @override
  Future<List<EquipamentoTableDto>> buscarTodosEquipamentos() {
    return executar('buscarTodosEquipamentos', () async {
      final equipamentos = await equipamentoDao.buscarTodos();
      AppLogger.d(
          '[EquipamentoRepositoryImpl] Encontrados ${equipamentos.length} equipamentos');
      return equipamentos.map(EquipamentoTableDto.fromData).toList();
    }, onErrorReturn: []);
  }

  // --------------------- Buscar por Subestação ---------------------

  @override
  Future<List<EquipamentoTableDto>> buscarEquipamentosPorSubestacao(
      String subestacao) {
    return executar('buscarEquipamentosPorSubestacao', () async {
      final equipamentos = await equipamentoDao.buscarPorSubestacao(subestacao);
      AppLogger.d(
          '[EquipamentoRepositoryImpl] Encontrados ${equipamentos.length} equipamentos para subestação $subestacao');
      return equipamentos.map(EquipamentoTableDto.fromData).toList();
    }, onErrorReturn: []);
  }

  @override
  Future<EquipamentoTableDto> buscarEquipamentoPorSubestacao(
      String subestacao) {
    return executar('buscarEquipamentoPorSubestacao', () async {
      final equipamentos = await equipamentoDao.buscarPorSubestacao(subestacao);

      if (equipamentos.isEmpty) {
        AppLogger.w(
            '[EquipamentoRepositoryImpl] Nenhum equipamento encontrado para subestação $subestacao');
        throw Exception(
            'Nenhum equipamento encontrado para subestação $subestacao');
      }

      return EquipamentoTableDto.fromData(equipamentos.first);
    });
  }

  @override
  Future<EquipamentoTableDto> buscarEquipamentoPorSubestacaoId(
      String subestacaoId) {
    return executar('buscarEquipamentoPorSubestacaoId', () async {
      final equipamentos =
          await equipamentoDao.buscarPorSubestacao(subestacaoId);

      if (equipamentos.isEmpty) {
        AppLogger.w(
            '[EquipamentoRepositoryImpl] Nenhum equipamento encontrado para subestaçãoId $subestacaoId');
        throw Exception(
            'Nenhum equipamento encontrado para subestaçãoId $subestacaoId');
      }

      return EquipamentoTableDto.fromData(equipamentos.first);
    });
  }

  // --------------------- Deletar ---------------------

  @override
  Future<void> deletarEquipamento(String equipamentoId) {
    return executar('deletarEquipamento', () async {
      final equipamento = await equipamentoDao.buscarPorUuid(equipamentoId);

      if (equipamento == null) {
        AppLogger.w(
            '[EquipamentoRepositoryImpl] Tentativa de deletar equipamento não encontrado: $equipamentoId');
        throw Exception(
            'Equipamento não encontrado para deleção: $equipamentoId');
      }

      await equipamentoDao.deletarPorUuid(equipamentoId);
      AppLogger.d(
          '[EquipamentoRepositoryImpl] Equipamento deletado com sucesso (UUID: $equipamentoId)');
    });
  }
}
