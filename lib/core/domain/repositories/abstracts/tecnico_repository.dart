import 'package:sympla_app/core/domain/dto/tecnico_table_dto.dart';

abstract class TecnicoRepository {
  Future<TecnicoTableDto?> buscarTecnico(String tecnicoId);
  Future<List<TecnicoTableDto>> buscarTodosTecnicos();
  Future<void> deletarTodosTecnicos();
}
