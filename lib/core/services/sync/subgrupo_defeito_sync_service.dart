import 'package:drift/drift.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/network/dio_client.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/daos/subgrupo_defeito_equipamento_dao.dart';

class SubgrupoDefeitoSyncService {
  final DioClient dio;
  final SubgrupoDefeitoEquipamentoDao dao;

  SubgrupoDefeitoSyncService({required this.dio, required this.dao});

  Future<void> sincronizar() async {
    AppLogger.i('🔄 Sincronizando Subgrupos de Defeito...',
        tag: 'SubgrupoDefeitoSync');

    try {
      final response = await dio.get('/subgrupos-defeito');
      final dados = response.data as List;

      final lista = dados.map<SubgrupoDefeitoEquipamentoTableCompanion>((json) {
        return SubgrupoDefeitoEquipamentoTableCompanion(
          id: Value(json['id']),
          uuid: Value(json['uuid']),
          nome: Value(json['nome']),
          createdAt: Value(DateTime.parse(json['createdAt'])),
          updatedAt: Value(DateTime.parse(json['updatedAt'])),
          sincronizado: const Value(true),
        );
      }).toList();

      await dao.sincronizarComApi(lista);
    } catch (e, s) {
      AppLogger.e('Erro ao sincronizar Subgrupos de Defeito',
          tag: 'SubgrupoDefeitoSync', error: e, stackTrace: s);
    }
  }
}
