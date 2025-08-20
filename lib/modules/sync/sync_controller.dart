import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/upload/background_sync_service.dart';
import 'package:sympla_app/core/upload/upload_manager.dart';

class SyncController extends GetxController {
  final BackgroundSyncService _backgroundService = Get.find<BackgroundSyncService>();

  final RxBool isLoading = false.obs;
  final RxMap<String, dynamic> status = <String, dynamic>{}.obs;

  // Reativos derivados
  late final RxBool estaExecutandoRx;
  late final RxBool temConexaoRx;
  late final RxInt tamanhoFilaRx;
  late final RxBool estaProcessandoRx;

  @override
  void onInit() {
    super.onInit();
    _initComputedRx();
    // Evita disparar mudanças reativas durante a construção inicial da árvore
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateStatus());
  }

  void _initComputedRx() {
    // Usa reatividade direta dos serviços quando possível
    try {
      final bg = _backgroundService;
      estaExecutandoRx = bg.executandoRx;
      temConexaoRx = bg.temConexaoRx;
    } catch (_) {
      estaExecutandoRx = RxBool(status['executando'] ?? false);
      temConexaoRx = RxBool(status['temConexao'] ?? false);
    }
    try {
      final uploadManager = Get.find<UploadManager>();
      tamanhoFilaRx = uploadManager.tamanhoFilaRx;
      estaProcessandoRx = uploadManager.estaProcessandoRx;
    } catch (_) {
      tamanhoFilaRx = RxInt(status['tamanhoFila'] ?? 0);
      estaProcessandoRx = RxBool(status['estaProcessando'] ?? false);
    }
  }

  void _updateStatus() {
    try {
      status.value = _backgroundService.status;
    } catch (e) {
      AppLogger.e('❌ Erro ao obter status do BackgroundSyncService', error: e);
      status.value = {
        'executando': false,
        'temConexao': false,
        'tamanhoFila': 0,
        'estaProcessando': false,
      };
    }
    // Não altere os Rx derivados aqui para evitar setState durante build
  }

  Future<void> iniciarServico() async {
    isLoading.value = true;
    try {
      await _backgroundService.iniciar();
      _updateStatus();
      AppLogger.d('✅ Serviço iniciado com sucesso');
    } catch (e, s) {
      AppLogger.e('❌ Erro ao iniciar serviço', error: e, stackTrace: s);
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> pararServico() async {
    isLoading.value = true;
    try {
      await _backgroundService.parar();
      _updateStatus();
      AppLogger.d('✅ Serviço parado com sucesso');
    } catch (e, s) {
      AppLogger.e('❌ Erro ao parar serviço', error: e, stackTrace: s);
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> verificarManual() async {
    isLoading.value = true;
    try {
      await _backgroundService.verificarManual();
      _updateStatus();
      AppLogger.d('✅ Verificação manual executada');
    } catch (e, s) {
      AppLogger.e('❌ Erro na verificação manual', error: e, stackTrace: s);
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> sincronizarManual() async {
    isLoading.value = true;
    try {
      await _backgroundService.sincronizarManual();
      _updateStatus();
      AppLogger.d('✅ Sincronização manual executada');
    } catch (e, s) {
      AppLogger.e('❌ Erro na sincronização manual', error: e, stackTrace: s);
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> limparFila() async {
    isLoading.value = true;
    try {
      final uploadManager = Get.find<UploadManager>();
      uploadManager.limparFila();
      _updateStatus();
      AppLogger.d('🗑️ Fila limpa com sucesso');
    } catch (e, s) {
      AppLogger.e('❌ Erro ao limpar fila', error: e, stackTrace: s);
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  void atualizarStatus() {
    _updateStatus();
  }

  // Expostos para uso na View
  bool get estaExecutando => estaExecutandoRx.value;
  bool get temConexao => temConexaoRx.value;
  int get tamanhoFila => tamanhoFilaRx.value;
  bool get estaProcessando => estaProcessandoRx.value;
}
