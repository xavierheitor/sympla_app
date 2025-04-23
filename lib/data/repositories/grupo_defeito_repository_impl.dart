import 'package:drift/drift.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/network/dio_client.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/daos/grupo_defeito_equipamento_dao.dart';
import 'package:sympla_app/domain/repositories/grupo_defeito_repository.dart';

class GrupoDefeitoRepositoryImpl implements GrupoDefeitoRepository {
  final DioClient dio;
  final GrupoDefeitoEquipamentoDao dao;

  GrupoDefeitoRepositoryImpl({
    required this.dio,
    required this.dao,
  });

  @override
  Future<List<GrupoDefeitoEquipamentoTableCompanion>> buscarDaApi() async {
    final response = await dio.get('/grupos-defeito');
    final dados = response.data as List;

    return dados.map<GrupoDefeitoEquipamentoTableCompanion>((json) {
      return GrupoDefeitoEquipamentoTableCompanion(
        id: Value(json['id']),
        uuid: Value(json['uuid']),
        nome: Value(json['nome']),
        createdAt: Value(DateTime.parse(json['createdAt'])),
        updatedAt: Value(DateTime.parse(json['updatedAt'])),
        sincronizado: const Value(true),
      );
    }).toList();
  }

  @override
  Future<void> salvarNoBanco(
      List<GrupoDefeitoEquipamentoTableCompanion> dados) async {
    await dao.sincronizarComApi(dados);
    AppLogger.d('💾 Grupos de defeito salvos no banco local',
        tag: 'GrupoDefeitoRepo');
  }
}
