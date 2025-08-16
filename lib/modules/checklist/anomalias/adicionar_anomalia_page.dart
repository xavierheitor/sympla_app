// AdicionarAnomaliaPage (com botão de salvar na AppBar e salvamento imediato no banco)

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sympla_app/core/domain/dto/anomalia/anomalia_table_dto.dart';
import 'package:sympla_app/core/domain/dto/grupo_defeito_equipamento/defeito_table_dto.dart';
import 'package:sympla_app/core/domain/dto/grupo_defeito_equipamento/equipamento_table_dto.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/storage/converters/fase_converter.dart';
import 'package:sympla_app/core/storage/converters/lado_converter.dart';
import 'package:sympla_app/modules/checklist/anomalias/anomalia_controller.dart';
import 'package:sympla_app/widgets/custom_searcheable_dropdown.dart';

// 👇 novo import do componente

class AdicionarAnomaliaPage extends StatefulWidget {
  final String perguntaId;

  const AdicionarAnomaliaPage({
    super.key,
    required this.perguntaId,
  });

  @override
  State<AdicionarAnomaliaPage> createState() => _AdicionarAnomaliaPageState();
}

class _AdicionarAnomaliaPageState extends State<AdicionarAnomaliaPage> {
  final _formKey = GlobalKey<FormState>();
  final Rxn<DefeitoTableDto> defeitoSelecionado = Rxn();
  final Rxn<FaseAnomalia> faseSelecionada = Rxn();
  final Rxn<LadoAnomalia> ladoSelecionado = Rxn();

  final TextEditingController deltaController = TextEditingController();
  final TextEditingController observacaoController = TextEditingController();
  //controller para o campo de equipamento - pra corrigir o problema de não atualizar o campo depois de selecionar um equipamento
  final TextEditingController equipamentoTextFieldController = TextEditingController();
  //controller para o campo de defeito - pra corrigir o problema de não atualizar o campo depois de selecionar um defeito
  final TextEditingController defeitoTextFieldController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  File? _imagemSelecionada;

  // 👇 adicionados: controllers dos dropdowns pesquisáveis
  late final SearchableDropdownController<EquipamentoTableDto> equipDropdownCtrl;
  late final SearchableDropdownController<DefeitoTableDto> defeitoDropdownCtrl;

  final RxBool salvando = false.obs; // 👈 add

  // ⬇️ ADD: workers para bind reativo
  Worker? _equipamentosWorker;
  Worker? _defeitosWorker;
  Worker? _equipSelecionadoWorker;

  @override
  void initState() {
    super.initState();
    final a = Get.find<AnomaliaController>();

    equipDropdownCtrl = SearchableDropdownController<EquipamentoTableDto>(
      initialItems: a.equipamentos.toList(),
      itemLabel: (e) => e.nome,
    );

    defeitoDropdownCtrl = SearchableDropdownController<DefeitoTableDto>(
      initialItems: a.defeitos.toList(),
      itemLabel: (d) => d.descricao,
    );

    // 👉 quando a lista de equipamentos mudar, atualiza o dropdown
    _equipamentosWorker = ever<List<EquipamentoTableDto>>(a.equipamentos, (lista) {
      equipDropdownCtrl.setItems(lista);
    });

    // 👉 quando a lista de defeitos mudar (após carregar do banco), atualiza dropdown e desliga loading
    _defeitosWorker = ever<List<DefeitoTableDto>>(a.defeitos, (lista) {
      defeitoDropdownCtrl.setItems(lista);
      defeitoDropdownCtrl.loading.value = false; // encerra spinner do bottom sheet, se aberto
    });

    // 👉 mantém a seleção do dropdown de equipamento em sincronia com o controller (se setarem de fora)
    _equipSelecionadoWorker = ever<EquipamentoTableDto?>(a.equipamentoSelecionado, (equip) {
      if (equip == null) {
        equipDropdownCtrl.clearSelection();
      } else {
        equipDropdownCtrl.select(equip);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AnomaliaController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Anomalia'),
        actions: [
          Obx(() {
            if (salvando.value) {
              // loader compacto na AppBar
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
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  final controller = Get.find<AnomaliaController>();
                  final atividade = controller.atividadeController.atividadeEmAndamento.value;
                  final equipamento = controller.equipamentoSelecionado.value;
                  final defeito = defeitoSelecionado.value;
                  final fase = faseSelecionada.value;
                  final lado = ladoSelecionado.value;

                  if (atividade == null ||
                      equipamento == null ||
                      defeito == null ||
                      fase == null ||
                      lado == null) {
                    AppLogger.w('[AdicionarAnomaliaPage] Campos obrigatórios ausentes');
                    return;
                  }

                  salvando.value = true; // 👈 liga loader
                  try {
                    final anomalia = AnomaliaTableDto(
                      perguntaId: widget.perguntaId,
                      atividadeId: atividade.uuid,
                      equipamentoId: equipamento.uuid,
                      defeitoId: defeito.uuid,
                      fase: fase,
                      lado: lado,
                      delta: double.tryParse(deltaController.text),
                      observacao:
                          observacaoController.text.isEmpty ? null : observacaoController.text,
                      foto: _imagemSelecionada != null
                          ? await _imagemSelecionada!.readAsBytes()
                          : null,
                      corrigida: false,
                    );
                    await controller.salvarAnomalia(widget.perguntaId, anomalia);
                    Get.back();
                  } catch (e, s) {
                    AppLogger.e('[AdicionarAnomaliaPage] Erro ao salvar anomalia',
                        error: e, stackTrace: s);
                    // (opcional) feedback ao usuário
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Falha ao salvar. Tente novamente.')),
                    );
                  } finally {
                    salvando.value = false; // 👈 desliga loader (se a tela não tiver sido fechada)
                  }
                }
              },
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
                // ====== ALTERADO: campo de selecao do equipamento ======
                SearchableDropdown<EquipamentoTableDto>(
                  controller: equipDropdownCtrl,
                  labelText: 'Equipamento',
                  leadingIcon: const Icon(Icons.precision_manufacturing),
                  onChanged: (value) {
                    final controller = Get.find<AnomaliaController>();

                    // atualiza estado original
                    controller.equipamentoSelecionado.value = value;

                    // resetar defeito e mostrar spinner enquanto carrega do banco
                    defeitoSelecionado.value = null;
                    defeitoDropdownCtrl.clearSelection();
                    defeitoDropdownCtrl.loading.value =
                        true; // 👈 mostra CircularProgressIndicator no sheet

                    // OBS: o carregarDefeitos é disparado pelo ever(equipamentoSelecionado)
                    // dentro do AnomaliaController. Quando terminar, _defeitosWorker acima
                    // vai setar a nova lista e desligar o loading.
                  },
                ),

                const SizedBox(height: 16),

                // ====== ALTERADO: campo de selecao do defeito ======
                SearchableDropdown<DefeitoTableDto>(
                  controller: defeitoDropdownCtrl,
                  labelText: 'Defeito',
                  leadingIcon: const Icon(Icons.report_problem),
                  onChanged: (value) {
                    defeitoSelecionado.value = value;
                  },
                ),

                const SizedBox(height: 16),

                Row(
                  children: [
                    Expanded(
                      child: Obx(() => DropdownButtonFormField<FaseAnomalia>(
                            value: faseSelecionada.value,
                            decoration: const InputDecoration(labelText: 'Fase'),
                            items: FaseAnomalia.values.map((f) {
                              return DropdownMenuItem(
                                value: f,
                                child: Text(f.label),
                              );
                            }).toList(),
                            onChanged: (value) => faseSelecionada.value = value,
                            validator: (value) => value == null ? 'Selecione a fase' : null,
                          )),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Obx(() => DropdownButtonFormField<LadoAnomalia>(
                            value: ladoSelecionado.value,
                            decoration: const InputDecoration(labelText: 'Lado'),
                            items: LadoAnomalia.values.map((l) {
                              return DropdownMenuItem(
                                value: l,
                                child: Text(l.label),
                              );
                            }).toList(),
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
                  decoration: const InputDecoration(
                    labelText: 'Delta T (opcional)',
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: observacaoController,
                  decoration: const InputDecoration(
                    labelText: 'Observação (opcional)',
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
                if (_imagemSelecionada != null)
                  Column(
                    children: [
                      Image.file(_imagemSelecionada!, height: 200),
                      const SizedBox(height: 8),
                      TextButton.icon(
                        onPressed: () {
                          setState(() {
                            _imagemSelecionada = null;
                          });
                        },
                        icon: const Icon(Icons.delete),
                        label: const Text('Remover imagem'),
                      ),
                    ],
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () => _selecionarImagem(ImageSource.camera),
                      icon: const Icon(Icons.camera_alt),
                      label: const Text('Câmera'),
                    ),
                    ElevatedButton.icon(
                      onPressed: () => _selecionarImagem(ImageSource.gallery),
                      icon: const Icon(Icons.photo_library),
                      label: const Text('Galeria'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _equipamentosWorker?.dispose();
    _defeitosWorker?.dispose();
    _equipSelecionadoWorker?.dispose();
    deltaController.dispose();
    observacaoController.dispose();
    super.dispose();
  }

  Future<void> _selecionarImagem(ImageSource origem) async {
    try {
      final XFile? imagem = await _picker.pickImage(source: origem);
      if (imagem != null) {
        setState(() {
          _imagemSelecionada = File(imagem.path);
        });
      }
    } catch (e) {
      AppLogger.e('[AdicionarAnomaliaPage] Erro ao selecionar imagem: $e');
    }
  }
}
//TODO: ADICIONAR REATIVIDADE AO SALVAR A FOTO DA ANOMALIA, TA DEMORANDO MUITO SALVAR, PRECISA DE UM INDICADOR DE PROGRESSO