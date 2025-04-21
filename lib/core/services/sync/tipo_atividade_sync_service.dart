import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/network/dio_client.dart';
import 'package:drift/drift.dart';
import 'package:sympla_app/core/storage/converters/tipo_atividade_mobile_converter.dart';
import 'package:sympla_app/core/storage/daos/tipo_atividade_dao.dart';

class TipoAtividadeSyncService {
  final DioClient dio;
  final TipoAtividadeDao dao;

  TipoAtividadeSyncService({required this.dio, required this.dao});

  Future<void> sincronizar() async {
    AppLogger.i('🔄 Sincronizando TipoAtividade...', tag: 'TipoAtividadeSync');

    try {
      final response = await dio.get('/tipo-atividade');
      final dados = response.data as List;

      final lista = dados.map<TipoAtividadeTableCompanion>((json) {
        return TipoAtividadeTableCompanion(
          id: Value(json['id']),
          uuid: Value(json['uuid']),
          nome: Value(json['nome']),
          tipoAtividadeMobile:
              Value(_mapTipoMobile(json['tipoAtividadeMobile'])),
          aprId: Value(json['aprId']),
          checklistId: Value(json['checklistId']),
          createdAt: Value(DateTime.parse(json['createdAt'])),
          updatedAt: Value(DateTime.parse(json['updatedAt'])),
          sincronizado: const Value(true),
        );
      }).toList();

      await dao.sincronizarComApi(lista);
    } catch (e, s) {
      AppLogger.e('Erro ao sincronizar TipoAtividade',
          tag: 'TipoAtividadeSync', error: e, stackTrace: s);
    }
  }

  TipoAtividadeMobile _mapTipoMobile(String value) {
    return TipoAtividadeMobile.values.firstWhere(
      (e) => e.name == value,
      orElse: () => TipoAtividadeMobile.ivItIu,
    );
  }
}
