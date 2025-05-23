import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sympla_app/core/core_app/controllers/atividade_controller.dart';
import 'package:sympla_app/core/domain/dto/anomalia/anomalia_table_dto.dart';
import 'package:sympla_app/core/domain/dto/grupo_defeito_equipamento/defeito_table_dto.dart';
import 'package:sympla_app/core/domain/dto/grupo_defeito_equipamento/equipamento_table_dto.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/storage/converters/fase_converter.dart';
import 'package:sympla_app/core/storage/converters/lado_converter.dart';
import 'package:sympla_app/modules/resumo_anomalias/resumo_anomalias_controller.dart';
import 'package:sympla_app/modules/resumo_anomalias/widgets/imagem_anomalia_field.dart';

class AnomaliaFormWidget extends StatefulWidget {
  final String perguntaId;
  final AnomaliaTableDto? anomaliaExistente;

  const AnomaliaFormWidget({
    super.key,
    required this.perguntaId,
    this.anomaliaExistente,
  });

  @override
  State<AnomaliaFormWidget> createState() => _AnomaliaFormWidgetState();
}

class _AnomaliaFormWidgetState extends State<AnomaliaFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final Rxn<EquipamentoTableDto> equipamentoSelecionado = Rxn();
  final Rxn<DefeitoTableDto> defeitoSelecionado = Rxn();
  final Rxn<FaseAnomalia> faseSelecionada = Rxn();
  final Rxn<LadoAnomalia> ladoSelecionado = Rxn();

  final TextEditingController deltaController = TextEditingController();
  final TextEditingController observacaoController = TextEditingController();

  final imagemBytesNotifier = ValueNotifier<Uint8List?>(null);

  late final ResumoAnomaliasController controller;

@override
  void initState() {
    super.initState();
    controller = Get.find();

    controller.carregarEquipamentos().then((_) async {
      if (widget.anomaliaExistente != null) {
        final a = widget.anomaliaExistente!;

        // 👉 Seleciona o equipamento
        equipamentoSelecionado.value = a.equipamento ??
            controller.equipamentos
                .firstWhereOrNull((e) => e.uuid == a.equipamentoId);

        // 👉 Carrega defeitos do equipamento
        if (equipamentoSelecionado.value != null) {
          controller.equipamentoSelecionado.value =
              equipamentoSelecionado.value;
          await controller.carregarDefeitos(equipamentoSelecionado.value!);
        }

        // 👉 Só agora seleciona o defeito
        defeitoSelecionado.value = a.defeito ??
            controller.defeitos.firstWhereOrNull((d) => d.uuid == a.defeitoId);

        // 👉 Demais campos
        faseSelecionada.value = a.fase;
        ladoSelecionado.value = a.lado;
        deltaController.text = a.delta?.toString() ?? '';
        observacaoController.text = a.observacao ?? '';

        if (a.foto != null && a.foto!.isNotEmpty) {
          imagemBytesNotifier.value = a.foto!;
        }
      }
    });
  }

  @override
  void dispose() {
    imagemBytesNotifier.dispose();
    deltaController.dispose();
    observacaoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.anomaliaExistente != null
              ? 'Editar Anomalia'
              : 'Adicionar Anomalia'),
          actions: [
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: _salvarAnomalia,
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Obx(() => DropdownButtonFormField<EquipamentoTableDto>(
                        value: equipamentoSelecionado.value,
                        decoration:
                            const InputDecoration(labelText: 'Equipamento'),
                        items: controller.equipamentos.map((e) {
                          return DropdownMenuItem(
                              value: e, child: Text(e.nome));
                        }).toList(),
                        onChanged: (value) {
                          equipamentoSelecionado.value = value;
                          defeitoSelecionado.value = null;
                          if (value != null) {
                            controller.equipamentoSelecionado.value = value;
                            controller.carregarDefeitos(value);
                          }
                        },
                        validator: (value) =>
                            value == null ? 'Selecione o equipamento' : null,
                      )),
                  const SizedBox(height: 16),
                  Obx(() => DropdownButtonFormField<DefeitoTableDto>(
                        value: defeitoSelecionado.value,
                        decoration: const InputDecoration(labelText: 'Defeito'),
                        items: controller.defeitos.map((d) {
                          return DropdownMenuItem(
                              value: d,
                              child: Text('${d.codigoSap} - ${d.descricao}'));
                        }).toList(),
                        onChanged: (value) => defeitoSelecionado.value = value,
                        validator: (value) =>
                            value == null ? 'Selecione o defeito' : null,
                      )),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Obx(() => DropdownButtonFormField<FaseAnomalia>(
                              value: faseSelecionada.value,
                              decoration:
                                  const InputDecoration(labelText: 'Fase'),
                              items: FaseAnomalia.values.map((f) {
                                return DropdownMenuItem(
                                    value: f, child: Text(f.label));
                              }).toList(),
                              onChanged: (value) =>
                                  faseSelecionada.value = value,
                              validator: (value) =>
                                  value == null ? 'Selecione a fase' : null,
                            )),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Obx(() => DropdownButtonFormField<LadoAnomalia>(
                              value: ladoSelecionado.value,
                              decoration:
                                  const InputDecoration(labelText: 'Lado'),
                              items: LadoAnomalia.values.map((l) {
                                return DropdownMenuItem(
                                    value: l, child: Text(l.label));
                              }).toList(),
                              onChanged: (value) =>
                                  ladoSelecionado.value = value,
                              validator: (value) =>
                                  value == null ? 'Selecione o lado' : null,
                            )),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: deltaController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d{0,2}')),
                    ],
                    decoration:
                        const InputDecoration(labelText: 'Delta T (opcional)'),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: observacaoController,
                    decoration: const InputDecoration(
                        labelText: 'Observação (opcional)'),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 16),
                  ImagemAnomaliaField(imagemBytesNotifier: imagemBytesNotifier),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _salvarAnomalia() async {
    if (!_formKey.currentState!.validate()) return;

    final atividade =
        Get.find<AtividadeController>().atividadeEmAndamento.value;
    final equipamento = equipamentoSelecionado.value;
    final defeito = defeitoSelecionado.value;
    final fase = faseSelecionada.value;
    final lado = ladoSelecionado.value;

    if (atividade == null ||
        equipamento == null ||
        defeito == null ||
        fase == null ||
        lado == null) {
      AppLogger.w('[AnomaliaFormWidget] Campos obrigatórios ausentes');
      return;
    }

    final novaAnomalia = AnomaliaTableDto(
      id: widget.anomaliaExistente?.id,
      perguntaId: widget.perguntaId,
      atividadeId: atividade.uuid,
      equipamentoId: equipamento.uuid,
      defeitoId: defeito.uuid,
      fase: fase,
      lado: lado,
      delta: double.tryParse(deltaController.text),
      observacao: observacaoController.text.trim().isEmpty
          ? null
          : observacaoController.text.trim(),
      foto: imagemBytesNotifier.value,
      corrigida: widget.anomaliaExistente?.corrigida ?? false,
      nomeEquipamento: equipamento.nome,
      codigoSapDefeito: defeito.codigoSap,
      equipamento: equipamento,
      defeito: defeito,
    );

    await controller.salvarOuAtualizarAnomalia(novaAnomalia);
    Get.back();
  }
}
