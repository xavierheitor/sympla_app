import 'package:get/get.dart';
import 'package:sympla_app/core/storage/app_database.dart';

class GlobalBinding extends Bindings {
  @override
  void dependencies() {
    // Singleton do banco
    Get.lazyPut<AppDatabase>(() => AppDatabase(), fenix: true);

    // Exemplo se quiser registrar DAO diretamente
    // final db = Get.find<AppDatabase>();
    // Get.lazyPut<UsuarioDao>(() => db.usuarioDao);
  }
}
