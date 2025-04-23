import 'package:drift/drift.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/network/dio_client.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/daos/equipamento_dao.dart';
import 'package:sympla_app/domain/repositories/equipamento_repository.dart';

class EquipamentoRepositoryImpl implements EquipamentoRepository {
  final DioClient dio;
  final AppDatabase db;
  final EquipamentoDao dao;

  EquipamentoRepositoryImpl({
    required this.dio,
    required this.db,
  }) : dao = db.equipamentoDao;

  @override
  Future<List<EquipamentoTableCompanion>> buscarDaApi() async {
    final response = await dio.get('/equipamentos');
    final dados = response.data as List;

    AppLogger.d('🔍 Recebidos ${dados.length} equipamentos da API',
        tag: 'EquipamentoRepository');

    return dados.map<EquipamentoTableCompanion>((json) {
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
  }

  @override
  Future<void> salvarNoBanco(
      List<EquipamentoTableCompanion> equipamentos) async {
    await dao.sincronizarComApi(equipamentos);
    AppLogger.d('💾 Equipamentos salvos no banco local',
        tag: 'EquipamentoRepository');
  }
}
