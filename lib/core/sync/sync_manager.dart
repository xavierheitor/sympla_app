import 'package:sympla_app/core/domain/repositories/abstracts/syncable_repository.dart';
import 'package:sympla_app/core/sync/sync_result.dart';

class SyncManager {
  final Map<String, SyncableRepository> _repos = {};

  void registrar<T>(SyncableRepository<T> repo) {
    _repos[repo.nomeEntidade] = repo;
  }

  /// Lista os módulos disponíveis
  List<String> get modulosDisponiveis => _repos.keys.toList();

  /// Sincroniza tudo
  Future<SyncResult> sincronizarTudo() async {
    bool falhou = false;
    bool temDadosLocais = false;

    for (var entry in _repos.entries) {
      try {
        final repo = entry.value;
        final dados = await repo.buscarDaApi();
        await repo.sincronizarComBanco(dados);
      } catch (_) {
        falhou = true;
        final vazio = await entry.value.estaVazio(entry.key);
        if (!vazio) temDadosLocais = true;
      }
    }

    return SyncResult(
      sucesso: !falhou,
      podeContinuar: !falhou || temDadosLocais,
    );
  }

  /// Sincroniza um módulo específico
  Future<void> sincronizarModulo(String nomeEntidade) async {
    final repo = _repos[nomeEntidade];
    if (repo == null) {
      throw Exception('Nenhum repositório registrado para $nomeEntidade');
    }
    await _executar(repo);
  }

  Future<void> _executar(SyncableRepository repo) async {
    final dados = await repo.buscarDaApi();
    await repo.sincronizarComBanco(dados);
  }
}
