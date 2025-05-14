import 'package:sympla_app/core/domain/dto/grupo_defeito_equipamento/defeito_table_dto.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/defeito_repository.dart';
import 'package:sympla_app/core/network/dio_client.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/daos/defeito_dao.dart';

class DefeitoRepositoryImpl implements DefeitoRepository {
  final AppDatabase db;
  final DefeitoDao defeitoDao;
  final DioClient dio;

  DefeitoRepositoryImpl(this.db, this.dio) : defeitoDao = db.defeitoDao;

  @override
  Future<DefeitoTableDto> buscarDefeito(String defeitoId) {
    // TODO: implement buscarDefeito
    throw UnimplementedError();
  }

  @override
  Future<List<DefeitoTableDto>> buscarDefeitosPorEquipamentoCodigo(
      String equipamentoCodigo) {
    // TODO: implement buscarDefeitosPorEquipamentoCodigo
    throw UnimplementedError();
  }

  @override
  Future<List<DefeitoTableDto>> buscarDefeitosPorGrupoDefeitoCodigo(
      String grupoDefeitoCodigo) {
    // TODO: implement buscarDefeitosPorGrupoDefeitoCodigo
    throw UnimplementedError();
  }

  @override
  Future<List<DefeitoTableDto>> buscarDefeitosPorGrupoDefeitoId(
      String grupoDefeitoId) {
    // TODO: implement buscarDefeitosPorGrupoDefeitoId
    throw UnimplementedError();
  }

  @override
  Future<List<DefeitoTableDto>> buscarDefeitosPorSubgrupoDefeitoId(
      String subGrupoDefeitoId) {
    // TODO: implement buscarDefeitosPorSubgrupoDefeitoId
    throw UnimplementedError();
  }

  @override
  Future<List<DefeitoTableDto>> buscarTodosDefeitos() {
    // TODO: implement buscarTodosDefeitos
    throw UnimplementedError();
  }
}
