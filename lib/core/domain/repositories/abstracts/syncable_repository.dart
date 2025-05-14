abstract class SyncableRepository<T> {
  Future<void> sincronizarComBanco(List<T> itens);
  Future<List<T>> buscarDaApi();
  Future<bool> estaVazio(String entidade);
}
