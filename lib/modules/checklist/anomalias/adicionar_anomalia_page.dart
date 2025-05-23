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

  final ImagePicker _picker = ImagePicker();
  File? _imagemSelecionada;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AnomaliaController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Anomalia'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                final atividade =
                    controller.atividadeController.atividadeEmAndamento.value;
                final equipamento = controller.equipamentoSelecionado.value;
                final defeito = defeitoSelecionado.value;
                final fase = faseSelecionada.value;
                final lado = ladoSelecionado.value;

                if (atividade == null ||
                    equipamento == null ||
                    defeito == null ||
                    fase == null ||
                    lado == null) {
                  AppLogger.w(
                      '[AdicionarAnomaliaPage] Campos obrigatórios ausentes');
                  return;
                }

                final anomalia = AnomaliaTableDto(
                  perguntaId: widget.perguntaId,
                  atividadeId: atividade.uuid,
                  equipamentoId: equipamento.uuid,
                  defeitoId: defeito.uuid,
                  fase: fase,
                  lado: lado,
                  delta: double.tryParse(deltaController.text),
                  observacao: observacaoController.text.isEmpty
                      ? null
                      : observacaoController.text,
                  foto: _imagemSelecionada != null
                      ? await _imagemSelecionada!.readAsBytes()
                      : null,
                  corrigida: false,
                );
                await controller.salvarAnomalia(widget.perguntaId, anomalia);

                Get.back();
              }
            },
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
                      value: controller.equipamentoSelecionado.value,
                      decoration:
                          const InputDecoration(labelText: 'Equipamento'),
                      items: controller.equipamentos.map((e) {
                        return DropdownMenuItem(
                          value: e,
                          child: Text(e.nome),
                        );
                      }).toList(),
                      onChanged: (value) {
                        controller.equipamentoSelecionado.value = value;
                        defeitoSelecionado.value = null;
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
                          child: Text(d.descricao),
                        );
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
                                value: f,
                                child: Text(f.label),
                              );
                            }).toList(),
                            onChanged: (value) => faseSelecionada.value = value,
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
                                value: l,
                                child: Text(l.label),
                              );
                            }).toList(),
                            onChanged: (value) => ladoSelecionado.value = value,
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
