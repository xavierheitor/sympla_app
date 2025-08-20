import 'package:sympla_app/core/domain/repositories/abstracts/syncable_repository.dart';
import 'package:sympla_app/core/sync/sync_result.dart';

/// Orquestrador de sincronização entre API e banco local.
///
/// - Mantém um registro de repositórios "sincronizáveis" (`SyncableRepository`)
/// - Suporta sincronização total (todos os módulos) e por módulo específico
/// - Implementa estratégia "inteligente": se o módulo já tem dados locais e
///   não for forçado (`force=false`), pula a sincronização para economizar rede
class SyncManager {
  final Map<String, SyncableRepository> _repos = {};

  /// Registra um repositório sincronizável, indexado por `nomeEntidade`.
  void registrar<T>(SyncableRepository<T> repo) {
    _repos[repo.nomeEntidade] = repo;
  }

  /// Lista os nomes dos módulos registrados e disponíveis para sync.
  List<String> get modulosDisponiveis => _repos.keys.toList();

  /// Sincroniza tudo
  Future<SyncResult> sincronizarTudo({bool force = false}) async {
    bool falhou = false;
    bool temDadosLocais = false;

    for (var entry in _repos.entries) {
      final repo = entry.value;

      try {
        if (!force) {
          final vazio = await repo.estaVazio(entry.key);
          if (!vazio) {
            temDadosLocais = true;
            continue; // pula sincronização se já tem dados locais e não for forçado
          }
        }

        final dados = await repo.buscarDaApi();
        await repo.sincronizarComBanco(dados);
      } catch (_) {
        falhou = true;
        final vazio = await repo.estaVazio(entry.key);
        if (!vazio) temDadosLocais = true;
      }
    }

    return SyncResult(
      sucesso: !falhou,
      podeContinuar: !falhou || temDadosLocais,
    );
  }

  /// Sincroniza um módulo específico por nome (`nomeEntidade`).
  Future<void> sincronizarModulo(String nomeEntidade,
      {bool force = false}) async {
    final repo = _repos[nomeEntidade];
    if (repo == null) {
      throw Exception('Nenhum repositório registrado para $nomeEntidade');
    }

    if (!force) {
      final vazio = await repo.estaVazio(nomeEntidade);
      if (!vazio) return;
    }

    await _executar(repo);
  }

  /// Executa o ciclo de sincronização de um repositório: buscar da API e
  /// persistir no banco local.
  Future<void> _executar(SyncableRepository repo) async {
    final dados = await repo.buscarDaApi();
    await repo.sincronizarComBanco(dados);
  }
}
