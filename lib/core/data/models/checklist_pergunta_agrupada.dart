import 'package:sympla_app/core/storage/app_database.dart';

class PerguntasAgrupadas {
  final ChecklistGrupoTableData grupo;
  final ChecklistSubgrupoTableData subgrupo;
  final List<ChecklistPerguntaTableData> perguntas;

  PerguntasAgrupadas({
    required this.grupo,
    required this.subgrupo,
    required this.perguntas,
  });
}
