import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sympla_app/core/session/session_manager.dart';

/// Componente de drawer personalizado que exibe o menu lateral da aplicação
/// Inclui informações do usuário e opções de navegação
class AppDrawer extends StatelessWidget {
  final SessionManager session;

  const AppDrawer({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      //coluna do drawer
      child: Column(
        children: [
          //header do drawer
          UserAccountsDrawerHeader(
            //nome do usuario
            accountName: Text(
              session.usuario?.nome ?? 'Usuário',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            //email do usuario
            accountEmail: Text(
              session.usuario?.matricula ?? 'Matrícula',
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
            //foto do usuario
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                session.usuario?.nome.substring(0, 1).toUpperCase() ?? 'U',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
            //cor do header
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
          ),
          //item do drawer
          ListTile(
            //icone do item
            leading: const Icon(Icons.description),
            //texto do item
            title: const Text('APRs'),
            //onTap do item
            onTap: () {
              Navigator.pop(context);
              Future.microtask(() => Get.offAllNamed('/apr-list'));
            },
          ),
          const Spacer(),
          //item do drawer
          ListTile(
            //icone do item
            leading: const Icon(Icons.delete_forever, color: Colors.red),
            //texto do item
            title:
                const Text('Limpar Dados', style: TextStyle(color: Colors.red)),
            //onTap do item
            onTap: () async {
              Navigator.pop(context);
              final confirmado = await Get.dialog<bool>(
                AlertDialog(
                  //titulo do dialogo
                  title: const Text('Limpar Dados'),
                  //conteudo do dialogo
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
                  // await session.limparDadosAplicacao();
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
              await session.logout();
            },
          ),
        ],
      ),
    );
  }
}
