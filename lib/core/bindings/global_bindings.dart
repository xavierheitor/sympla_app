import 'package:get/get.dart';
import 'package:sympla_app/core/network/dio_client.dart';
import 'package:sympla_app/core/storage/app_database.dart';

class GlobalBinding extends Bindings {
  @override
  void dependencies() {
    // Singleton do banco
    Get.lazyPut<AppDatabase>(() => AppDatabase(), fenix: true);

    // Singleton do Dio
    Get.lazyPut(() => DioClient());

    // Exemplo se quiser registrar DAO diretamente
    // final db = Get.find<AppDatabase>();
    // Get.lazyPut<UsuarioDao>(() => db.usuarioDao);
  }
}
