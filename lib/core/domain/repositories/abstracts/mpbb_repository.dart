import 'package:sympla_app/core/domain/dto/mpbb/formulario_bateria_table_dto.dart';
import 'package:sympla_app/core/domain/dto/mpbb/medicao_elemento_table_dto.dart';

abstract class MpbbRepository {
  // 🗂️ Formulário
  Future<FormularioBateriaTableDto?> buscarFormulario(String atividadeId);
  Future<void> salvarFormulario(FormularioBateriaTableDto formulario);
  Future<void> deleteByAtividadeId(String atividadeId);
  Future<void> insert(FormularioBateriaTableDto formulario);
  Future<List<FormularioBateriaTableDto>> getByAtividadeId(String atividadeId);

  // 🔢 Medições
  Future<List<MedicaoElementoMpbbTableDto>> getByFormularioId(int formularioId);
  Future<void> insertAll(List<MedicaoElementoMpbbTableDto> medicoes);
}
