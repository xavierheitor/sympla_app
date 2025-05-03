import 'package:drift/drift.dart';
import 'package:sympla_app/core/domain/repositories/mp_bb/formulario_bateria_repository.dart';
import 'package:sympla_app/core/domain/repositories/mp_bb/medicao_elemento_bateria_repository.dart';
import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/storage/app_database.dart';

class MpBbFormService {
  final FormularioBateriaRepository formularioRepository;
  final MedicaoElementoBateriaRepository medicaoRepository;

  MpBbFormService({
    required this.formularioRepository,
    required this.medicaoRepository,
  });

  Future<FormularioBateriaTableData?> buscarPorAtividade(
      int atividadeId) async {
    try {
      final lista = await formularioRepository.getByAtividadeId(atividadeId);
      return lista.isNotEmpty ? lista.first : null;
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[MpBbFormService - buscarPorAtividade] ${erro.mensagem}',
          error: e, stackTrace: s);
      rethrow;
    }
  }

  Future<List<MedicaoElementoBateriaTableData>> buscarMedicoes(
      int formularioId) async {
    try {
      return await medicaoRepository.getByFormularioId(formularioId);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[MpBbFormService - buscarMedicoes] ${erro.mensagem}',
          error: e, stackTrace: s);
      rethrow;
    }
  }

  Future<void> salvarFormulario(
    FormularioBateriaTableCompanion formulario,
    List<MedicaoElementoBateriaTableCompanion> medicoes,
  ) async {
    try {
      AppLogger.d(
          '[MpBbFormService] Salvando formulário e ${medicoes.length} medições');

      // Remove possíveis dados antigos antes de salvar novos
      await formularioRepository
          .deleteByAtividadeId(formulario.atividadeId.value);

      // Insere novo formulário
      final id = await formularioRepository.insert(formulario);

      // Insere as medições com o ID recém-criado
      final medicoesComId = medicoes
          .map((e) => MedicaoElementoBateriaTableCompanion(
                formularioBateriaId: Value(id),
                elementoBateriaNumero: e.elementoBateriaNumero,
                tensao: e.tensao,
                resistenciaInterna: e.resistenciaInterna,
              ))
          .toList();

      await medicaoRepository.insertAll(medicoesComId);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[MpBbFormService - salvarFormulario] ${erro.mensagem}',
          error: e, stackTrace: s);
      rethrow;
    }
  }

  Future<void> deletarFormulario(int atividadeId) async {
    try {
      AppLogger.d(
          '[MpBbFormService] Removendo formulário da atividade $atividadeId');
      await formularioRepository.deleteByAtividadeId(atividadeId);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[MpBbFormService - deletarFormulario] ${erro.mensagem}',
          error: e, stackTrace: s);
      rethrow;
    }
  }
}
