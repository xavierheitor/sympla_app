import 'package:drift/drift.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/network/dio_client.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/daos/equipamento_dao.dart';

class EquipamentoSyncService {
  final DioClient dio;
  final EquipamentoDao dao;

  EquipamentoSyncService({required this.dio, required this.dao});

  Future<void> sincronizar() async {
    AppLogger.i('🔄 Sincronizando Equipamentos...', tag: 'EquipamentoSync');

    try {
      final response = await dio.get('/equipamentos');
      final dados = response.data as List;

      final lista = dados.map<EquipamentoTableCompanion>((json) {
        return EquipamentoTableCompanion(
          id: Value(json['id']),
          uuid: Value(json['uuid']),
          nome: Value(json['nome']),
          descricao: Value(json['descricao']),
          subestacao: Value(json['subestacao']),
          grupoId: Value(json['grupoId']),
          subgrupoId: Value(json['subgrupoId']),
          createdAt: Value(DateTime.parse(json['createdAt'])),
          updatedAt: Value(DateTime.parse(json['updatedAt'])),
          sincronizado: const Value(true),
        );
      }).toList();

      await dao.sincronizarComApi(lista);
    } catch (e, s) {
      AppLogger.e('Erro ao sincronizar Equipamentos',
          tag: 'EquipamentoSync', error: e, stackTrace: s);
    }
  }
}
