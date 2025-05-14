import 'package:sympla_app/core/domain/dto/tecnico_table_dto.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/tecnico_repository.dart';
import 'package:sympla_app/core/network/dio_client.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/daos/tecnico_dao.dart';

class TecnicoRepositoryImpl implements TecnicoRepository {
  final AppDatabase db;
  final TecnicoDao tecnicoDao;
  final DioClient dio;

  TecnicoRepositoryImpl(this.db, this.dio) : tecnicoDao = db.tecnicoDao;

  @override
  Future<TecnicoTableDto> buscarTecnico(String tecnicoId) {
    // TODO: implement buscarTecnico
    throw UnimplementedError();
  }

  @override
  Future<List<TecnicoTableDto>> buscarTodosTecnicos() {
    // TODO: implement buscarTodosTecnicos
    throw UnimplementedError();
  }

  @override
  Future<void> deletarTodosTecnicos() {
    // TODO: implement deletarTodosTecnicos
    throw UnimplementedError();
  }
}
