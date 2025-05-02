import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/converters/fase_converter.dart';
import 'package:sympla_app/core/storage/converters/lado_converter.dart';
import 'package:sympla_app/modules/resumo_anomalias/resumo_anomalias_controller.dart';
import 'package:drift/drift.dart' as d;

class AnomaliaFormWidget extends StatefulWidget {
  final int perguntaId;
  final AnomaliaTableData? anomaliaExistente;

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
  final Rxn<EquipamentoTableData> equipamentoSelecionado = Rxn();
  final Rxn<DefeitoTableData> defeitoSelecionado = Rxn();
  final Rxn<FaseAnomalia> faseSelecionada = Rxn();
  final Rxn<LadoAnomalia> ladoSelecionado = Rxn();

  final TextEditingController deltaController = TextEditingController();
  final TextEditingController observacaoController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  File? _imagemSelecionada;

  late final ResumoAnomaliasController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find();
    AppLogger.d('[AnomaliaFormWidget] initState - carregando equipamentos...');
    controller.carregarEquipamentos().then((_) {
      if (widget.anomaliaExistente != null) {
        AppLogger.d('[AnomaliaFormWidget] Edição de anomalia iniciada');
        final anomalia = widget.anomaliaExistente!;
        AppLogger.d(
            '[AnomaliaFormWidget] Dados recebidos: id=${anomalia.id}, defeitoId=${anomalia.defeitoId}, equipamentoId=${anomalia.equipamentoId}, fase=${anomalia.fase}, lado=${anomalia.lado}, delta=${anomalia.delta}, observacao=${anomalia.observacao}');
        equipamentoSelecionado.value = controller.equipamentos
            .firstWhereOrNull((e) => e.id == anomalia.equipamentoId);
        defeitoSelecionado.value = controller.defeitos
            .firstWhereOrNull((d) => d.id == anomalia.defeitoId);
        faseSelecionada.value = anomalia.fase;
        ladoSelecionado.value = anomalia.lado;
        deltaController.text = anomalia.delta?.toString() ?? '';
        observacaoController.text = anomalia.observacao ?? '';
        if (anomalia.foto != null) {
          _imagemSelecionada = File.fromRawPath(anomalia.foto!);
        }
      } else {
        AppLogger.d('[AnomaliaFormWidget] Criação de nova anomalia');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Obx(() => DropdownButtonFormField<EquipamentoTableData>(
                      value: equipamentoSelecionado.value,
                      decoration:
                          const InputDecoration(labelText: 'Equipamento'),
                      items: controller.equipamentos.map((e) {
                        return DropdownMenuItem(value: e, child: Text(e.nome));
                      }).toList(),
                      onChanged: (value) {
                        equipamentoSelecionado.value = value;
                        defeitoSelecionado.value = null;
                        AppLogger.d(
                            '[AnomaliaFormWidget] Equipamento selecionado: ${value?.id} - ${value?.nome}');
                        controller.carregarDefeitos(value!);
                      },
                      validator: (value) =>
                          value == null ? 'Selecione o equipamento' : null,
                    )),
                const SizedBox(height: 16),
                Obx(() => DropdownButtonFormField<DefeitoTableData>(
                      value: defeitoSelecionado.value,
                      decoration: const InputDecoration(labelText: 'Defeito'),
                      items: controller.defeitos.map((d) {
                        return DropdownMenuItem(
                            value: d, child: Text(d.descricao));
                      }).toList(),
                      onChanged: (value) {
                        defeitoSelecionado.value = value;
                        AppLogger.d(
                            '[AnomaliaFormWidget] Defeito selecionado: ${value?.id} - ${value?.descricao}');
                      },
                      validator: (value) =>
                          value == null ? 'Selecione o defeito' : null,
                    )),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<FaseAnomalia>(
                        value: faseSelecionada.value,
                        decoration: const InputDecoration(labelText: 'Fase'),
                        items: FaseAnomalia.values.map((f) {
                          return DropdownMenuItem(
                              value: f, child: Text(f.label));
                        }).toList(),
                        onChanged: (value) => faseSelecionada.value = value,
                        validator: (value) =>
                            value == null ? 'Selecione a fase' : null,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: DropdownButtonFormField<LadoAnomalia>(
                        value: ladoSelecionado.value,
                        decoration: const InputDecoration(labelText: 'Lado'),
                        items: LadoAnomalia.values.map((l) {
                          return DropdownMenuItem(
                              value: l, child: Text(l.label));
                        }).toList(),
                        onChanged: (value) => ladoSelecionado.value = value,
                        validator: (value) =>
                            value == null ? 'Selecione o lado' : null,
                      ),
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
                  decoration:
                      const InputDecoration(labelText: 'Observação (opcional)'),
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
                          AppLogger.d(
                              '[AnomaliaFormWidget] Imagem removida pelo usuário');
                          setState(() => _imagemSelecionada = null);
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
        AppLogger.d('[AnomaliaFormWidget] Imagem selecionada: ${imagem.path}');
        setState(() {
          _imagemSelecionada = File(imagem.path);
        });
      }
    } catch (e) {
      AppLogger.e('[AnomaliaFormWidget] Erro ao selecionar imagem: $e');
    }
  }

  Future<void> _salvarAnomalia() async {
    if (!_formKey.currentState!.validate()) return;

    final atividade = controller.atividadeController.atividadeEmAndamento.value;
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

    final novaAnomalia = AnomaliaTableCompanion(
      id: widget.anomaliaExistente != null
          ? d.Value(widget.anomaliaExistente!.id)
          : const d.Value.absent(),
      perguntaId: d.Value(widget.perguntaId),
      atividadeId: d.Value(atividade.id),
      equipamentoId: d.Value(equipamento.id),
      defeitoId: d.Value(defeito.id),
      fase: d.Value(fase),
      lado: d.Value(lado),
      delta: d.Value(double.tryParse(deltaController.text) ?? 0),
      observacao: d.Value(observacaoController.text),
      foto: _imagemSelecionada != null
          ? d.Value(await _imagemSelecionada!.readAsBytes())
          : const d.Value.absent(),
    );

    AppLogger.d(
        '[AnomaliaFormWidget] Anomalia pronta para salvar: ${novaAnomalia.toString()}');
    await controller.salvarOuAtualizarAnomalia(novaAnomalia);
    Get.back();
  }
}
