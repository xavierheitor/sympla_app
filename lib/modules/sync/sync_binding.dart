import 'package:get/get.dart';
import 'package:sympla_app/modules/sync/sync_controller.dart';

/// Binding da tela de status de sincronização.
///
/// Apenas expõe o `SyncController`, pois os serviços necessários
/// já são registrados no `GlobalBinding`.
class SyncBinding extends Bindings {
  @override
  void dependencies() {
    // O BackgroundSyncService já está registrado no GlobalBinding
    // Aqui apenas registramos o controller específico da página
    Get.lazyPut(() => SyncController());
  }
} 