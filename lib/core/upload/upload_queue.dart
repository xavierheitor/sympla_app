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
    _items.add(item);
  }

  UploadItem? proximo() {
    if (_items.isEmpty) return null;
    return _items.removeAt(0);
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
    _items.insert(0, item);
  }

  bool contem(String atividadeId) {
    return _items.any((item) => item.atividadeSync.uuid == atividadeId);
  }
}
