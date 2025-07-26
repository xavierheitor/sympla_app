import 'package:sympla_app/core/constants/api_constants.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/atividade_repository.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/network/dio_client.dart';
import 'package:sympla_app/core/storage/converters/status_atividade_converter.dart';
import 'package:sympla_app/core/upload/upload_item.dart';
import 'package:sympla_app/core/upload/upload_queue.dart';
import 'package:sympla_app/core/upload/upload_service.dart';

class UploadManager {
  final UploadQueue _fila = UploadQueue();
  final DioClient _dio;
  final AtividadeRepository _atividadeRepo;
  final UploadService _uploadService;
  bool _processando = false;

  UploadManager({
    required DioClient dio,
    required AtividadeRepository atividadeRepo,
    required UploadService uploadService,
  })  : _dio = dio,
        _atividadeRepo = atividadeRepo,
        _uploadService = uploadService;

  /// Adiciona uma atividade na fila de upload
  Future<void> adicionarNaFila(String atividadeId) async {
    try {
      AppLogger.d('📤 Adicionando atividade $atividadeId na fila de upload');

      // Montar o AtividadeSyncDto completo
      final atividadeSync = await _uploadService.montarAtividadeSync(atividadeId);
      if (atividadeSync == null) {
        AppLogger.e('❌ Não foi possível montar AtividadeSyncDto para $atividadeId');
        return;
      }

      // Criar UploadItem e adicionar na fila
      final uploadItem = UploadItem(atividadeSync);
      _fila.adicionar(uploadItem);

      AppLogger.d('✅ Atividade $atividadeId adicionada na fila. Total na fila: ${_fila.tamanho}');
    } catch (e, s) {
      AppLogger.e('❌ Erro ao adicionar atividade $atividadeId na fila', error: e, stackTrace: s);
    }
  }

  /// Processa toda a fila de upload
  Future<void> processarFila() async {
    if (_processando) {
      AppLogger.w('⚠️ Upload já está em processamento');
      return;
    }

    _processando = true;
    AppLogger.d('🚀 Iniciando processamento da fila de upload. Total: ${_fila.tamanho}');

    try {
      while (!_fila.estaVazia) {
        final item = _fila.proximo();
        if (item == null) break;

        await _processarItem(item);
      }

      AppLogger.d('✅ Fila de upload processada com sucesso');
    } catch (e, s) {
      AppLogger.e('❌ Erro ao processar fila de upload', error: e, stackTrace: s);
    } finally {
      _processando = false;
    }
  }

  /// Processa um item específico da fila
  Future<void> _processarItem(UploadItem item) async {
    try {
      AppLogger.d('📤 Processando upload da atividade: ${item.atividadeSync.uuid}');

      final sucesso = await enviarAtividade(item);

      if (sucesso) {
        AppLogger.d('✅ Atividade ${item.atividadeSync.uuid} enviada com sucesso');
        await _marcarComoSincronizada(item.atividadeSync.uuid);
      } else {
        AppLogger.e('❌ Falha ao enviar atividade ${item.atividadeSync.uuid}');
        await _marcarComoPendente(item.atividadeSync.uuid);

        // Se ainda pode tentar novamente, adiciona no final da fila
        if (item.podeTentarNovamente) {
          _fila.adicionar(item);
          AppLogger.d(
              '🔄 Atividade ${item.atividadeSync.uuid} readicionada na fila para nova tentativa');
        }
      }
    } catch (e, s) {
      AppLogger.e('❌ Erro ao processar item da fila', error: e, stackTrace: s);
      item.marcarErro(e.toString());

      if (item.podeTentarNovamente) {
        _fila.adicionar(item);
      }
    }
  }

  /// Envia uma atividade para o servidor
  Future<bool> enviarAtividade(UploadItem item) async {
    try {
      AppLogger.d('🌐 Enviando atividade ${item.atividadeSync.uuid} para o servidor');

      // Converter AtividadeSyncDto para JSON
      final jsonData = item.atividadeSync.toJson();

      // Fazer requisição POST
      final response = await _dio.post(
        '${ApiConstants.uploadAtividade}/${item.atividadeSync.uuid}',
        data: jsonData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        AppLogger.d('✅ Resposta do servidor: ${response.statusCode}');
        return true;
      } else {
        AppLogger.e('❌ Erro na resposta do servidor: ${response.statusCode}');
        return false;
      }
    } catch (e, s) {
      AppLogger.e('❌ Erro ao enviar atividade ${item.atividadeSync.uuid}', error: e, stackTrace: s);
      item.marcarErro(e.toString());
      return false;
    }
  }

  /// Marca atividade como sincronizada no banco local
  Future<void> _marcarComoSincronizada(String atividadeId) async {
    try {
      final atividade = await _atividadeRepo.buscarAtividade(atividadeId);
      if (atividade != null) {
        await _atividadeRepo
            .atualizarAtividade(atividade.copyWith(status: StatusAtividade.sincronizado));
        AppLogger.d('✅ Atividade $atividadeId marcada como sincronizada');
      }
    } catch (e, s) {
      AppLogger.e('❌ Erro ao marcar atividade como sincronizada', error: e, stackTrace: s);
    }
  }

  /// Marca atividade como pendente de upload no banco local
  Future<void> _marcarComoPendente(String atividadeId) async {
    try {
      final atividade = await _atividadeRepo.buscarAtividade(atividadeId);
      if (atividade != null) {
        await _atividadeRepo
            .atualizarAtividade(atividade.copyWith(status: StatusAtividade.pendenteUpload));
        AppLogger.d('⚠️ Atividade $atividadeId marcada como pendente de upload');
      }
    } catch (e, s) {
      AppLogger.e('❌ Erro ao marcar atividade como pendente', error: e, stackTrace: s);
    }
  }

  /// Retorna informações sobre o estado da fila
  bool get estaProcessando => _processando;
  int get tamanhoFila => _fila.tamanho;
  bool get filaVazia => _fila.estaVazia;

  /// Limpa a fila de upload
  void limparFila() {
    _fila.limpar();
    AppLogger.d('🗑️ Fila de upload limpa');
  }
}
