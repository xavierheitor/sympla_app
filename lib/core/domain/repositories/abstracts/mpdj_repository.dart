import 'package:sympla_app/core/domain/dto/mpdj/medicao_pressao_sf6_table_dto.dart';
import 'package:sympla_app/core/domain/dto/mpdj/medicao_resistencia_contato_table_dto.dart';
import 'package:sympla_app/core/domain/dto/mpdj/medicao_resistencia_isolamento_table_dto.dart';
import 'package:sympla_app/core/domain/dto/mpdj/medicao_tempo_operacao_table_dto.dart';
import 'package:sympla_app/core/domain/dto/mpdj/prev_disj_form_table_dto.dart';

abstract class MpDjRepository {
  Future<PrevDisjFormTableDto?> getByAtividadeId(String atividadeId);
  Future<int> insert(PrevDisjFormTableDto dados);

  Future<List<MedicaoPressaoSf6TableDto>> getPressaoSf6ByFormularioId(
      int formularioId);
  Future<void> deletePressaoSf6ByFormularioId(int formularioId);
  Future<void> insertPressaoSf6(List<MedicaoPressaoSf6TableDto> entradas);

  Future<List<MedicaoResistenciaContatoTableDto>>
      getResistenciaContatoByFormularioId(int formularioId);
  Future<void> deleteResistenciaContatoByFormularioId(int formularioId);
  Future<void> insertResistenciaContato(
      List<MedicaoResistenciaContatoTableDto> entradas);

  Future<List<MedicaoResistenciaIsolamentoTableDto>>
      getResistenciaIsolamentoByFormularioId(int formularioId);
  Future<void> deleteResistenciaIsolamentoByFormularioId(int formularioId);
  Future<void> insertResistenciaIsolamento(
      List<MedicaoResistenciaIsolamentoTableDto> entradas);

  Future<List<MedicaoTempoOperacaoTableDto>> getTempoOperacaoByFormularioId(
      int formularioId);
  Future<void> deleteTempoOperacaoByFormularioId(int formularioId);
  Future<void> insertTempoOperacao(List<MedicaoTempoOperacaoTableDto> entradas);
}
