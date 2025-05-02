import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/converters/fase_converter.dart';
import 'package:sympla_app/core/storage/converters/lado_converter.dart';

class AdicionarAnomaliaPage extends StatelessWidget {
  final List<EquipamentoTableData> equipamentos;
  final List<DefeitoTableData> defeitos;
  final int perguntaId;
  final Function(Map<String, dynamic>) onSalvar;

  AdicionarAnomaliaPage({
    super.key,
    required this.equipamentos,
    required this.defeitos,
    required this.perguntaId,
    required this.onSalvar,
  });

  final _formKey = GlobalKey<FormState>();

  final Rxn<EquipamentoTableData> equipamentoSelecionado = Rxn();
  final Rxn<DefeitoTableData> defeitoSelecionado = Rxn();
  final Rxn<FaseAnomalia> faseSelecionada = Rxn();
  final Rxn<LadoAnomalia> ladoSelecionado = Rxn();

  final TextEditingController deltaController = TextEditingController();
  final TextEditingController observacaoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Adicionar Anomalia')),
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
                      items: equipamentos.map((e) {
                        return DropdownMenuItem(
                          value: e,
                          child: Text(e.nome),
                        );
                      }).toList(),
                      onChanged: (value) =>
                          equipamentoSelecionado.value = value,
                      validator: (value) =>
                          value == null ? 'Selecione o equipamento' : null,
                    )),
                const SizedBox(height: 16),
                Obx(() => DropdownButtonFormField<DefeitoTableData>(
                      value: defeitoSelecionado.value,
                      decoration: const InputDecoration(labelText: 'Defeito'),
                      items: defeitos.map((d) {
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
                const SizedBox(height: 32),
                ElevatedButton.icon(
                  icon: const Icon(Icons.save),
                  label: const Text('Salvar Anomalia'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final dados = {
                        'perguntaId': perguntaId,
                        'equipamento': equipamentoSelecionado.value,
                        'defeito': defeitoSelecionado.value,
                        'fase': faseSelecionada.value,
                        'lado': ladoSelecionado.value,
                        'delta': deltaController.text,
                        'observacao': observacaoController.text,
                      };
                      onSalvar(dados);
                      Get.back();
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
