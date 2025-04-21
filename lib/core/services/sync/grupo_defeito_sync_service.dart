import 'package:drift/drift.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/network/dio_client.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/daos/grupo_defeito_equipamento_dao.dart';

class GrupoDefeitoSyncService {
  final DioClient dio;
  final GrupoDefeitoEquipamentoDao dao;

  GrupoDefeitoSyncService({required this.dio, required this.dao});

  Future<void> sincronizar() async {
    AppLogger.i('🔄 Sincronizando Grupos de Defeito...',
        tag: 'GrupoDefeitoSync');

    try {
      final response = await dio.get('/grupos-defeito');
      final dados = response.data as List;

      final lista = dados.map<GrupoDefeitoEquipamentoTableCompanion>((json) {
        return GrupoDefeitoEquipamentoTableCompanion(
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
      AppLogger.e('Erro ao sincronizar Grupos de Defeito',
          tag: 'GrupoDefeitoSync', error: e, stackTrace: s);
    }
  }
}
