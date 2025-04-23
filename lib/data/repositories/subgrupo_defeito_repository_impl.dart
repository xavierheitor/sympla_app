import 'package:drift/drift.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/network/dio_client.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/daos/subgrupo_defeito_equipamento_dao.dart';
import 'package:sympla_app/domain/repositories/subgrupo_defeito_repository.dart';

class SubgrupoDefeitoRepositoryImpl implements SubgrupoDefeitoRepository {
  final DioClient dio;
  final SubgrupoDefeitoEquipamentoDao dao;
  final AppDatabase db;

  SubgrupoDefeitoRepositoryImpl({
    required this.dio,
    required this.db,
  }) : dao = db.subgrupoDefeitoEquipamentoDao;

  @override
  Future<List<SubgrupoDefeitoEquipamentoTableCompanion>> buscarDaApi() async {
    final response = await dio.get('/subgrupos-defeito');
    final dados = response.data as List;

    return dados.map<SubgrupoDefeitoEquipamentoTableCompanion>((json) {
      return SubgrupoDefeitoEquipamentoTableCompanion(
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
      List<SubgrupoDefeitoEquipamentoTableCompanion> dados) async {
    await dao.sincronizarComApi(dados);
    AppLogger.d('💾 Subgrupos de defeito salvos no banco local',
        tag: 'SubgrupoDefeitoRepo');
  }
}
