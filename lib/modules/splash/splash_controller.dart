import 'dart:io';

import 'package:get/get.dart';
import 'package:sympla_app/core/constants/route_names.dart';
import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/services/sync/sync_orchestrator_service.dart';
import 'package:sympla_app/core/session/session_manager.dart';
import 'package:sympla_app/core/storage/app_database.dart';

class SplashController extends GetxController {
  final status = ''.obs;
  final carregando = true.obs;

  final syncService = Get.find<SyncOrchestratorService>();
  final db = Get.find<AppDatabase>();

  @override
  Future<void> onInit() async {
    super.onInit();
    AppLogger.d('🌀 Splash: onInit iniciado');

    final session = Get.find<SessionManager>();
    await session.init();

    AppLogger.d('🌀 Após init. Usuario: ${session.usuario}');

    if (session.estaLogado) {
      AppLogger.i('🔐 Sessão válida encontrada. Iniciando sincronização...');
      final sincronizou = await _sincronizarDados();

      if (!sincronizou) {
        final primeiraExecucao = await _dadosLocaisEstaoVazios();
        if (primeiraExecucao) {
          Get.offAllNamed(Routes.erroSplash);
          return;
        } else {
          AppLogger.w(
              '⚠️ Sincronização falhou, mas há dados locais. Seguindo...');
        }
      }
    } else {
      AppLogger.w('🔐 Nenhum usuário logado. Pulando sincronização.');
    }

    AppLogger.d('🌀 Após sincronização. Verificando sessão...');
    await _verificarSessao();
  }

  Future<void> _verificarSessao() async {
    final session = Get.find<SessionManager>();
    AppLogger.d('🔐 estaLogado = ${session.estaLogado}');

    if (session.estaLogado) {
      Get.offAllNamed(Routes.home);
    } else {
      Get.offAllNamed(Routes.login);
    }
  }

  Future<bool> _sincronizarDados() async {
    final temRede = await _verificarConexao();

    if (!temRede) {
      AppLogger.w('Sem conexão com a internet. Pulando sincronização.',
          tag: 'Splash');
      return false;
    }

    status.value = 'Sincronizando dados...';

    try {
      await syncService.sincronizarTudo();
      AppLogger.i('✅ Sincronização finalizada com sucesso', tag: 'Splash');
      return true;
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('Erro ao sincronizar dados',
          tag: 'Splash', error: erro.mensagem, stackTrace: erro.stack);
      return false;
    }
  }

  Future<bool> _verificarConexao() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('Erro ao verificar conexão',
          tag: 'Splash', error: erro.mensagem, stackTrace: erro.stack);
      return false;
    }
  }

  Future<bool> _dadosLocaisEstaoVazios() async {
    // final atividades = await db.atividadeDao.getAll();
    // final equipamentos = await db.equipamentoDao.getAll();
    // final tipos = await db.tipoAtividadeDao.getAll();

    // final estaVazio = atividades.isEmpty || equipamentos.isEmpty || tipos.isEmpty;
    const estaVazio = false;
    AppLogger.d('📦 Banco local está vazio? $estaVazio');

    return estaVazio;
  }
}
