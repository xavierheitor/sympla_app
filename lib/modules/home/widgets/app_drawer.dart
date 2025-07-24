import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sympla_app/modules/home/home_controller.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    /// Controller da página home
    final controller = Get.find<HomeController>();

    /// Usuario logado
    final usuario = controller.session.usuario;

    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              usuario?.nome ?? 'Usuário',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            accountEmail: Text(
              usuario?.matricula ?? 'Matrícula',
              style: const TextStyle(fontSize: 14),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                usuario?.nome.substring(0, 1).toUpperCase() ?? 'U',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
            decoration: const BoxDecoration(color: Colors.blue),
          ),
          ListTile(
            leading: const Icon(Icons.description),
            title: const Text('APRs'),
            onTap: () {
              Navigator.pop(context);
              Future.microtask(() => Get.offAllNamed('/apr-list'));
            },
          ),
          const Spacer(),
          //botao de sincronizar
          ListTile(
            leading: const Icon(Icons.sync),
            title: const Text('Forçar Sincronização'),
            onTap: () {
              Navigator.pop(context);
              controller.sincronizarTudo();
            },
          ),
          //botao de sincronizar
          ListTile(
            leading: const Icon(Icons.sync),
            title: const Text('Enviar concluidos'),
            onTap: () {
              //TODO: Implementar a função de enviar concluidos
            },
          ),
          //botao de limpar dados
          ListTile(
            leading: const Icon(Icons.delete_forever, color: Colors.red),
            title:
                const Text('Limpar Dados', style: TextStyle(color: Colors.red)),
            onTap: () async {
              Navigator.pop(context);
              final confirmado = await Get.dialog<bool>(
                AlertDialog(
                  title: const Text('Limpar Dados'),
                  content: const Text(
                    'Tem certeza que deseja limpar todos os dados do aplicativo? '
                    'Esta ação não pode ser desfeita e manterá apenas os dados do usuário.',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Get.back(result: false),
                      child: const Text('Cancelar'),
                    ),
                    TextButton(
                      onPressed: () => Get.back(result: true),
                      child: const Text('Limpar',
                          style: TextStyle(color: Colors.red)),
                    ),
                  ],
                ),
              );

              if (confirmado == true) {
                try {
                  // await controller.session.limparDadosAplicacao();
                  Get.snackbar(
                    'Sucesso',
                    'Dados limpos com sucesso',
                    backgroundColor: Colors.green,
                    colorText: Colors.white,
                  );
                } catch (e) {
                  Get.snackbar(
                    'Erro',
                    'Falha ao limpar dados: $e',
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                }
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Sair'),
            onTap: () async {
              Navigator.pop(context);
              await controller.sair();
            },
          ),
        ],
      ),
    );
  }
}
