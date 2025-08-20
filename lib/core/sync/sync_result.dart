/// Resultado consolidado da sincronização.
///
/// - `sucesso`: indica se todas as operações concluíram sem erro
/// - `podeContinuar`: mesmo em falha parcial, indica se há dados locais
///   suficientes para permitir navegação/uso do app
class SyncResult {
  final bool sucesso;
  final bool podeContinuar;

  SyncResult({required this.sucesso, required this.podeContinuar});
}
