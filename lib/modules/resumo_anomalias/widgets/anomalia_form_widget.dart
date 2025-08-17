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
import 'package:sympla_app/widgets/custom_searcheable_dropdown.dart'; // 👈 novo import

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

  // 👇 controladores novos para dropdowns pesquisáveis
  late final SearchableDropdownController<EquipamentoTableDto> equipDropdownCtrl;
  late final SearchableDropdownController<DefeitoTableDto> defeitoDropdownCtrl;

  final RxBool salvando = false.obs; // loader do botão salvar

  @override
  void initState() {
    super.initState();
    controller = Get.find();

    equipDropdownCtrl = SearchableDropdownController<EquipamentoTableDto>(
      initialItems: controller.equipamentos.toList(),
      itemLabel: (e) => e.nome,
    );

    defeitoDropdownCtrl = SearchableDropdownController<DefeitoTableDto>(
      initialItems: controller.defeitos.toList(),
      itemLabel: (d) => d.descricao,
    );

    // se veio uma anomalia já existente → pré-seleciona os valores
    controller.carregarEquipamentos().then((_) async {
      if (widget.anomaliaExistente != null) {
        final a = widget.anomaliaExistente!;
        equipamentoSelecionado.value = a.equipamento ??
            controller.equipamentos.firstWhereOrNull((e) => e.uuid == a.equipamentoId);

        if (equipamentoSelecionado.value != null) {
          controller.equipamentoSelecionado.value = equipamentoSelecionado.value;
          await controller.carregarDefeitos(equipamentoSelecionado.value!);
        }

        defeitoSelecionado.value =
            a.defeito ?? controller.defeitos.firstWhereOrNull((d) => d.uuid == a.defeitoId);

        faseSelecionada.value = a.fase;
        ladoSelecionado.value = a.lado;
        deltaController.text = a.delta?.toString() ?? '';
        observacaoController.text = a.observacao ?? '';

        if (a.foto != null && a.foto!.isNotEmpty) {
          imagemBytesNotifier.value = a.foto!;
        }

        // atualiza controllers visuais
        if (equipamentoSelecionado.value != null) {
          equipDropdownCtrl.select(equipamentoSelecionado.value!);
        }
        if (defeitoSelecionado.value != null) {
          defeitoDropdownCtrl.select(defeitoSelecionado.value!);
        }
      }
    });

    // bind reativo para atualizar as listas
    ever(controller.equipamentos, (lista) => equipDropdownCtrl.setItems(lista));
    ever(controller.defeitos, (lista) {
      defeitoDropdownCtrl.setItems(lista);
      defeitoDropdownCtrl.loading.value = false;
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
          title: Text(widget.anomaliaExistente != null ? 'Editar Anomalia' : 'Adicionar Anomalia'),
          actions: [
            Obx(() {
              if (salvando.value) {
                return const Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                );
              }
              return IconButton(
                icon: const Icon(Icons.save),
                onPressed: _salvarAnomalia,
              );
            }),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // 🔽 dropdown pesquisável de equipamento
                  SearchableDropdown<EquipamentoTableDto>(
                    controller: equipDropdownCtrl,
                    labelText: 'Equipamento',
                    leadingIcon: const Icon(Icons.precision_manufacturing),
                    onChanged: (value) {
                      equipamentoSelecionado.value = value;
                      defeitoSelecionado.value = null;
                      defeitoDropdownCtrl.clearSelection();
                      defeitoDropdownCtrl.loading.value = true;
                      if (value != null) {
                        controller.equipamentoSelecionado.value = value;
                        controller.carregarDefeitos(value);
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  // 🔽 dropdown pesquisável de defeito
                  SearchableDropdown<DefeitoTableDto>(
                    controller: defeitoDropdownCtrl,
                    labelText: 'Defeito',
                    leadingIcon: const Icon(Icons.report_problem),
                    onChanged: (value) => defeitoSelecionado.value = value,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Obx(() => DropdownButtonFormField<FaseAnomalia>(
                              value: faseSelecionada.value,
                              decoration: const InputDecoration(labelText: 'Fase'),
                              items: FaseAnomalia.values
                                  .map((f) => DropdownMenuItem(value: f, child: Text(f.label)))
                                  .toList(),
                              onChanged: (value) => faseSelecionada.value = value,
                              validator: (value) => value == null ? 'Selecione a fase' : null,
                            )),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Obx(() => DropdownButtonFormField<LadoAnomalia>(
                              value: ladoSelecionado.value,
                              decoration: const InputDecoration(labelText: 'Lado'),
                              items: LadoAnomalia.values
                                  .map((l) => DropdownMenuItem(value: l, child: Text(l.label)))
                                  .toList(),
                              onChanged: (value) => ladoSelecionado.value = value,
                              validator: (value) => value == null ? 'Selecione o lado' : null,
                            )),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: deltaController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                    ],
                    decoration: const InputDecoration(labelText: 'Delta T (opcional)'),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: observacaoController,
                    decoration: const InputDecoration(labelText: 'Observação (opcional)'),
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

    final atividade = Get.find<AtividadeController>().atividadeEmAndamento.value;
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

    salvando.value = true;
    try {
      final novaAnomalia = AnomaliaTableDto(
        id: widget.anomaliaExistente?.id,
        perguntaId: widget.perguntaId,
        atividadeId: atividade.uuid,
        equipamentoId: equipamento.uuid,
        defeitoId: defeito.uuid,
        fase: fase,
        lado: lado,
        delta: double.tryParse(deltaController.text),
        observacao:
            observacaoController.text.trim().isEmpty ? null : observacaoController.text.trim(),
        foto: imagemBytesNotifier.value,
        corrigida: widget.anomaliaExistente?.corrigida ?? false,
        nomeEquipamento: equipamento.nome,
        codigoSapDefeito: defeito.codigoSap,
        equipamento: equipamento,
        defeito: defeito,
      );

      await controller.salvarOuAtualizarAnomalia(novaAnomalia);
      Get.back();
    } catch (e, s) {
      AppLogger.e('[AnomaliaFormWidget] Erro ao salvar anomalia', error: e, stackTrace: s);
      Get.snackbar('Erro ao salvar anomalia', 'Tente novamente',
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      salvando.value = false;
    }
  }
}

//TODO:   Unificar form de cadastro/edicao de anomalias, usamos 2 diferentes, mas podem ser um so
