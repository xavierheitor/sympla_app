import 'package:sympla_app/core/domain/dto/mpbb/formulario_bateria_table_dto.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/mpbb_repository.dart';
import 'package:sympla_app/core/network/dio_client.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/daos/mpbb_ddao.dart';

class MpbbRepositoryImpl implements MpbbRepository {
  final AppDatabase db;
  final MpbbDao mpbbDao;
  final DioClient dio;

  MpbbRepositoryImpl(this.db, this.dio) : mpbbDao = db.mpbbDao;

  @override
  Future<void> buscarFormulario(String atividadeId) {
    // TODO: implement buscarFormulario
    throw UnimplementedError();
  }

  @override
  Future<void> salvarFormulario(FormularioBateriaTableDto formulario) {
    // TODO: implement salvarFormulario
    throw UnimplementedError();
  }

  @override
  deleteByAtividadeId(int atividadeId) {
    // TODO: implement deleteByAtividadeId
    throw UnimplementedError();
  }

  @override
  getByAtividadeId(String atividadeId) {
    // TODO: implement getByAtividadeId
    throw UnimplementedError();
  }

  @override
  getByFormularioId(int formularioId) {
    // TODO: implement getByFormularioId
    throw UnimplementedError();
  }

  @override
  insert(FormularioBateriaTableCompanion formulario) {
    // TODO: implement insert
    throw UnimplementedError();
  }

  @override
  insertAll(List<MedicaoElementoBateriaTableCompanion> medicoesComId) {
    // TODO: implement insertAll
    throw UnimplementedError();
  }
}
