import 'package:sympla_app/core/domain/dto/mpdj/medicao_pressao_sf6_table_dto.dart';
import 'package:sympla_app/core/domain/dto/mpdj/medicao_resistencia_contato_table_dto.dart';
import 'package:sympla_app/core/domain/dto/mpdj/medicao_resistencia_isolamento_table_dto.dart';
import 'package:sympla_app/core/domain/dto/mpdj/medicao_tempo_operacao_table_dto.dart';
import 'package:sympla_app/core/domain/dto/mpdj/prev_disj_form_table_dto.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/mpdj_repository.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/repository_helper.dart';
import 'package:sympla_app/core/network/dio_client.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/daos/mpdj_dao.dart';

/// 🔥 Implementação concreta do repositório de Manutenção Preventiva de Disjuntor (MPDJ)
/// Segue o padrão RepositoryHelper com logs e tratamento de erros.
class MpdjRepositoryImpl with RepositoryHelper implements MpDjRepository {
  final AppDatabase db;
  final MpdjDao dao;
  final DioClient dio;

  MpdjRepositoryImpl(this.db, this.dio) : dao = db.mpdjDao;

  // ----------------------------------------------------------------------------
  // 🗂️ FORMULÁRIO
  // ----------------------------------------------------------------------------

  /// 🔍 Busca o formulário da atividade
  @override
  Future<MpdjFormTableDto?> getByAtividadeId(String atividadeId) {
    return executar('getByAtividadeId', () async {
      final data = await dao.buscarFormularioPorAtividade(atividadeId);
      return data != null ? MpdjFormTableDto.fromData(data) : null;
    }, onErrorReturn: null);
  }

  /// 💾 Salva o formulário e retorna o ID
  @override
  Future<int> insert(MpdjFormTableDto dados) {
    return executar('insertFormulario', () async {
      return await dao.salvarFormulario(dados.toCompanion());
    });
  }

  // ----------------------------------------------------------------------------
  // 🔢 PRESSÃO SF6
  // ----------------------------------------------------------------------------

  @override
  Future<List<MedicaoPressaoSf6TableDto>> getPressaoSf6ByFormularioId(
      int formularioId) {
    return executar('getPressaoSf6ByFormularioId', () async {
      final lista = await dao.buscarSf6(formularioId);
      return lista.map(MedicaoPressaoSf6TableDto.fromData).toList();
    }, onErrorReturn: []);
  }

  @override
  Future<void> deletePressaoSf6ByFormularioId(int formularioId) {
    return executar('deletePressaoSf6ByFormularioId', () async {
      await dao.deletarMedicoesPorFormulario(formularioId);
    });
  }

  @override
  Future<void> insertPressaoSf6(List<MedicaoPressaoSf6TableDto> entradas) {
    return executar('insertPressaoSf6', () async {
      await dao
          .salvarMedicoesSf6(entradas.map((e) => e.toCompanion()).toList());
    });
  }

  // ----------------------------------------------------------------------------
  // 🔢 RESISTÊNCIA DE CONTATO
  // ----------------------------------------------------------------------------

  @override
  Future<List<MedicaoResistenciaContatoTableDto>>
      getResistenciaContatoByFormularioId(int formularioId) {
    return executar('getResistenciaContatoByFormularioId', () async {
      final lista = await dao.buscarContato(formularioId);
      return lista.map(MedicaoResistenciaContatoTableDto.fromData).toList();
    }, onErrorReturn: []);
  }

  @override
  Future<void> deleteResistenciaContatoByFormularioId(int formularioId) {
    return executar('deleteResistenciaContatoByFormularioId', () async {
      await dao.deletarMedicoesPorFormulario(formularioId);
    });
  }

  @override
  Future<void> insertResistenciaContato(
      List<MedicaoResistenciaContatoTableDto> entradas) {
    return executar('insertResistenciaContato', () async {
      await dao
          .salvarMedicoesContato(entradas.map((e) => e.toCompanion()).toList());
    });
  }

  // ----------------------------------------------------------------------------
  // 🔢 RESISTÊNCIA DE ISOLAMENTO
  // ----------------------------------------------------------------------------

  @override
  Future<List<MedicaoResistenciaIsolamentoTableDto>>
      getResistenciaIsolamentoByFormularioId(int formularioId) {
    return executar('getResistenciaIsolamentoByFormularioId', () async {
      final lista = await dao.buscarIsolamento(formularioId);
      return lista.map(MedicaoResistenciaIsolamentoTableDto.fromData).toList();
    }, onErrorReturn: []);
  }

  @override
  Future<void> deleteResistenciaIsolamentoByFormularioId(int formularioId) {
    return executar('deleteResistenciaIsolamentoByFormularioId', () async {
      await dao.deletarMedicoesPorFormulario(formularioId);
    });
  }

  @override
  Future<void> insertResistenciaIsolamento(
      List<MedicaoResistenciaIsolamentoTableDto> entradas) {
    return executar('insertResistenciaIsolamento', () async {
      await dao.salvarMedicoesIsolamento(
          entradas.map((e) => e.toCompanion()).toList());
    });
  }

  // ----------------------------------------------------------------------------
  // 🔢 TEMPO DE OPERAÇÃO
  // ----------------------------------------------------------------------------

  @override
  Future<List<MedicaoTempoOperacaoTableDto>> getTempoOperacaoByFormularioId(
      int formularioId) {
    return executar('getTempoOperacaoByFormularioId', () async {
      final lista = await dao.buscarTempo(formularioId);
      return lista.map(MedicaoTempoOperacaoTableDto.fromData).toList();
    }, onErrorReturn: []);
  }

  @override
  Future<void> deleteTempoOperacaoByFormularioId(int formularioId) {
    return executar('deleteTempoOperacaoByFormularioId', () async {
      await dao.deletarMedicoesPorFormulario(formularioId);
    });
  }

  @override
  Future<void> insertTempoOperacao(
      List<MedicaoTempoOperacaoTableDto> entradas) {
    return executar('insertTempoOperacao', () async {
      await dao
          .salvarMedicoesTempo(entradas.map((e) => e.toCompanion()).toList());
    });
  }
}
