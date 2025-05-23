import 'package:sympla_app/core/domain/dto/grupo_defeito_equipamento/defeito_table_dto.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/defeito_repository.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/repository_helper.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/network/dio_client.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/daos/defeito_dao.dart';

/// 🔥 Repositório de Defeito - Implementação concreta
class DefeitoRepositoryImpl with RepositoryHelper implements DefeitoRepository {
  final AppDatabase db;
  final DefeitoDao defeitoDao;
  final DioClient dio;

  DefeitoRepositoryImpl(this.db, this.dio) : defeitoDao = db.defeitoDao;

  // --------------------- Buscar Todos ---------------------

  @override
  Future<List<DefeitoTableDto>> buscarTodosDefeitos() {
    return executar('buscarTodosDefeitos', () async {
      final lista = await defeitoDao.getAll();
      AppLogger.d(
          '[DefeitoRepositoryImpl] Encontrados ${lista.length} defeitos no total');
      return lista.map(DefeitoTableDto.fromData).toList();
    }, onErrorReturn: []);
  }

  // --------------------- Buscar por ID ---------------------

  @override
  Future<DefeitoTableDto> buscarDefeito(String defeitoId) {
    return executar('buscarDefeito', () async {
      final lista = await defeitoDao.getAll();
      final defeito = lista.firstWhere(
        (e) => e.uuid == defeitoId,
        orElse: () => throw Exception('Defeito não encontrado: $defeitoId'),
      );
      return DefeitoTableDto.fromData(defeito);
    });
  }

  // --------------------- Buscar por Equipamento ---------------------

  @override
  Future<List<DefeitoTableDto>> buscarDefeitosPorEquipamentoCodigo(
      String equipamentoCodigo) {
    return executar('buscarDefeitosPorEquipamentoCodigo', () async {
      final lista = await defeitoDao
          .buscarDefeitosPorEquipamentoCodigo(equipamentoCodigo);
      AppLogger.d(
          '[DefeitoRepositoryImpl] Encontrados ${lista.length} defeitos para equipamento $equipamentoCodigo');
      return lista.map(DefeitoTableDto.fromData).toList();
    }, onErrorReturn: []);
  }

  // --------------------- Buscar por Grupo ---------------------

  @override
  Future<List<DefeitoTableDto>> buscarDefeitosPorGrupoDefeitoId(
      String grupoDefeitoId) {
    return executar('buscarDefeitosPorGrupoDefeitoId', () async {
      final lista = await defeitoDao.getByGrupoId(grupoDefeitoId);
      AppLogger.d(
          '[DefeitoRepositoryImpl] Encontrados ${lista.length} defeitos para grupo $grupoDefeitoId');
      return lista.map(DefeitoTableDto.fromData).toList();
    }, onErrorReturn: []);
  }

  @override
  Future<List<DefeitoTableDto>> buscarDefeitosPorGrupoDefeitoCodigo(
      String grupoDefeitoCodigo) {
    return executar('buscarDefeitosPorGrupoDefeitoCodigo', () async {
      final grupo =
          await defeitoDao.buscarGrupoDefeitoCodigo(grupoDefeitoCodigo);

      if (grupo == null) {
        AppLogger.w(
            '[DefeitoRepositoryImpl] Grupo de defeito código não encontrado: $grupoDefeitoCodigo');
        return [];
      }

      final lista = await defeitoDao.getByGrupoId(grupo.uuid);
      AppLogger.d(
          '[DefeitoRepositoryImpl] Encontrados ${lista.length} defeitos para grupo código $grupoDefeitoCodigo');
      return lista.map(DefeitoTableDto.fromData).toList();
    }, onErrorReturn: []);
  }

  // --------------------- Buscar por Subgrupo ---------------------

  @override
  Future<List<DefeitoTableDto>> buscarDefeitosPorSubgrupoDefeitoId(
      String subGrupoDefeitoId) {
    return executar('buscarDefeitosPorSubgrupoDefeitoId', () async {
      final lista = await defeitoDao.getBySubgrupoId(subGrupoDefeitoId);
      AppLogger.d(
          '[DefeitoRepositoryImpl] Encontrados ${lista.length} defeitos para subgrupo $subGrupoDefeitoId');
      return lista.map(DefeitoTableDto.fromData).toList();
    }, onErrorReturn: []);
  }
}
