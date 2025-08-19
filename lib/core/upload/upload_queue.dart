import 'package:sympla_app/core/upload/upload_item.dart';

/// 📦 Fila de upload
///
/// Responsabilidades:
/// - Gerencia a fila de upload
/// - Adiciona itens à fila
/// - Remove itens da fila
/// - Verifica se a fila está vazia
class UploadQueue {
  final List<UploadItem> _items = [];

  void adicionar(UploadItem item) {
    // evita duplicados do mesmo uuid
    if (!_items.any((i) => i.atividadeSync.uuid == item.atividadeSync.uuid)) {
      _items.add(item);
    }
  }

  UploadItem? proximo() {
    if (_items.isEmpty) return null;
    // encontra o primeiro item elegível pela janela de backoff
    final agora = DateTime.now();
    for (int index = 0; index < _items.length; index++) {
      final item = _items[index];
      final podeProcessar = item.proximaTentativa == null || !item.proximaTentativa!.isAfter(agora);
      if (podeProcessar) {
        return _items.removeAt(index);
      }
    }
    return null; // nenhum elegível no momento
  }

  void remover(String atividadeId) {
    _items.removeWhere((item) => item.atividadeSync.uuid == atividadeId);
  }

  bool get estaVazia => _items.isEmpty;

  int get tamanho => _items.length;

  List<UploadItem> get todos => List.unmodifiable(_items);

  void limpar() {
    _items.clear();
  }

  void adicionarNoInicio(UploadItem item) {
    if (!_items.any((i) => i.atividadeSync.uuid == item.atividadeSync.uuid)) {
      _items.insert(0, item);
    }
  }

  bool contem(String atividadeId) {
    return _items.any((item) => item.atividadeSync.uuid == atividadeId);
  }
}
