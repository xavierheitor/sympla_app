import 'package:sympla_app/core/domain/dto/mpbb/formulario_bateria_table_dto.dart';
import 'package:sympla_app/core/storage/app_database.dart';

abstract class MpbbRepository {
  Future<void> salvarFormulario(FormularioBateriaTableDto formulario);
  Future<void> buscarFormulario(String atividadeId);

  deleteByAtividadeId(int atividadeId) {}

  insertAll(List<MedicaoElementoBateriaTableCompanion> medicoesComId) {}

  insert(FormularioBateriaTableCompanion formulario) {}

  getByFormularioId(int formularioId) {}

  getByAtividadeId(String atividadeId) {}
}
