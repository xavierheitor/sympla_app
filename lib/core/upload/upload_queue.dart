import 'package:sympla_app/core/upload/upload_item.dart';

class UploadQueue {
  final List<UploadItem> _items = [];

  void adicionar(UploadItem item) {
    _items.add(item);
  }

  UploadItem? proximo() {
    return _items.removeAt(0);
  }

  void remover(String atividadeId) {
    _items.removeWhere((item) => item.atividade.uuid == atividadeId);
  }
}
