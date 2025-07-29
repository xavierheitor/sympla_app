import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sympla_app/core/domain/dto/mpdj/medicao_resistencia_isolamento_medicoes_table_dto.dart';
import 'package:sympla_app/core/domain/dto/mpdj/medicao_resistencia_isolamento_table_dto.dart';
import 'package:sympla_app/core/storage/converters/estado_disjuntor_converter.dart';
import 'package:sympla_app/core/storage/converters/fase_isolamento_converter.dart';
import 'package:sympla_app/core/storage/converters/posicao_disjuntor_ensaio_converter.dart';
import 'package:sympla_app/modules/mp_dj/mp_dj_form_controller.dart';

/// 📋 Página para cadastro de medições de resistência de isolamento
///
/// 🔧 FUNCIONALIDADES:
/// - Cadastro de múltiplas medições de resistência de isolamento
/// - Configuração de posições do disjuntor (Linha, Terra, Guarda)
/// - Medições de resistência por fase (A, B, C)
/// - Configurações ambientais (temperatura, umidade)
///
/// 🎯 FLUXO DE USO:
/// 1. Usuário acessa a página
/// 2. Preenche configurações gerais (tensão, temperatura, umidade)
/// 3. Define posições do disjuntor
/// 4. Insere medições de resistência por fase
/// 5. Salva os dados no banco local
///
/// 🔄 INTEGRAÇÃO:
/// - Usa MpDjFormController para gerenciar estado
/// - Salva dados via AtividadeService
/// - Integra com sistema de sincronização
class EtapaResistenciaIsolamentoPage extends StatefulWidget {
  const EtapaResistenciaIsolamentoPage({super.key});

  @override
  State<EtapaResistenciaIsolamentoPage> createState() => _EtapaResistenciaIsolamentoPageState();
}

class _EtapaResistenciaIsolamentoPageState extends State<EtapaResistenciaIsolamentoPage> {
  /// 🎛️ Controller principal do módulo MPDJ
  /// Gerencia o estado global do formulário e operações de salvamento
  final controller = Get.find<MpDjFormController>();

  /// 📊 Lista de medições sendo editadas na tela
  /// Cada item representa uma medição de resistência de isolamento
  final List<_MedicaoFields> _medicoes = [];

  /// 🔽 Valores disponíveis para os dropdowns de posição
  /// Define as opções: entrada, saida, terra
  final _dropdownValues = PosicaoDisjuntorEnsaio.values;

  /// 🔽 Valores disponíveis para os dropdowns de fase
  /// Define as opções: ABC, A, B, C
  final _faseValues = FaseIsolamento.values;

  /// 🔧 Controllers para configurações do ensaio (fixas, não mudam por medição)
  final TextEditingController _tensaoController = TextEditingController();
  final TextEditingController _temperaturaController = TextEditingController();
  final TextEditingController _umidadeController = TextEditingController();

  @override
  void initState() {
    super.initState();

    /// 🔄 Inicializa a página carregando dados existentes ou criando nova medição
    _preencherCamposSeExistir();
  }

  @override
  void dispose() {
    /// 🧹 Limpa os controllers das configurações do ensaio
    _tensaoController.dispose();
    _temperaturaController.dispose();
    _umidadeController.dispose();

    /// 🧹 Limpa os controllers das medições
    for (final medicao in _medicoes) {
      medicao.dispose();
    }

    super.dispose();
  }

  /// 📥 Carrega dados salvos do banco para preencher os campos
  ///
  /// 🔧 LÓGICA:
  /// 1. Busca configurações gerais do ensaio
  /// 2. Busca medições específicas
  /// 3. Se existem dados: converte DTOs para campos de formulário
  /// 4. Se não existem: cria uma nova medição vazia
  ///
  /// 🔄 CONVERSÕES:
  /// - Enum → Enum (para dropdowns)
  /// - double → String (para campos de texto)
  /// - Tratamento de valores nulos
  void _preencherCamposSeExistir() {
    /// 📋 Lista de configurações gerais já salvas no banco
    final lista = controller.isolamentos;

    if (lista.isNotEmpty) {
      /// 📊 Carrega configurações do ensaio (só na primeira configuração)
      final config = lista.first;
      _tensaoController.text = config.tensaoKv.toString();
      _temperaturaController.text = config.temperaturaDisjuntor?.toString() ?? '';
      _umidadeController.text = config.umidadeRelativaAr?.toString() ?? '';

      /// 🔄 Para cada configuração, busca as medições específicas
      for (final config in lista) {
        // TODO: Implementar busca de medições específicas por config.id
        // Por enquanto, cria uma medição vazia
        _adicionarMedicao();
      }
    } else {
      /// ➕ Se não há dados salvos, cria uma medição vazia para o usuário preencher
      _adicionarMedicao();
    }
  }

  /// ➕ Adiciona uma nova medição à lista
  ///
  /// 🔧 LÓGICA:
  /// 1. Calcula o próximo número sequencial
  /// 2. Cria novo _MedicaoFields com campos vazios
  /// 3. Adiciona à lista e atualiza a UI
  ///
  /// 📝 NUMERAÇÃO:
  /// - Se lista vazia: número 1
  /// - Se já existem: próximo número após o maior existente
  void _adicionarMedicao() {
    setState(() {
      /// 🔢 Calcula o próximo número sequencial
      final proximoNumero = _medicoes.isEmpty
          ? 1 // Primeira medição
          : _medicoes.map((e) => e.numero).reduce((a, b) => a > b ? a : b) +
              1; // Próximo após o maior

      /// 🆕 Cria nova medição vazia e adiciona à lista
      final novaMedicao = _MedicaoFields(numero: proximoNumero);
      novaMedicao.setUpdateCallback(() => setState(() {}));
      _medicoes.add(novaMedicao);
    });
  }

  /// 🗑️ Remove uma medição da lista pelo índice
  ///
  /// ⚠️ VALIDAÇÃO:
  /// - Só permite remover se há mais de 1 medição
  /// - Mantém pelo menos uma medição sempre
  ///
  /// 🔄 ATUALIZAÇÃO:
  /// - Remove da lista
  /// - Atualiza a UI automaticamente
  void _removerMedicao(int index) {
    setState(() {
      /// 🗑️ Remove a medição do índice especificado
      _medicoes.removeAt(index);
    });
  }

  /// 💾 Salva todas as medições no banco de dados
  ///
  /// 🔧 FLUXO DE SALVAMENTO:
  /// 1. Valida se o formulário existe
  /// 2. Converte campos de formulário para DTOs
  /// 3. Chama o controller para salvar no banco
  /// 4. Controller atualiza a lista de isolamentos
  ///
  /// ⚠️ VALIDAÇÕES:
  /// - Verifica se formulário existe
  /// - Trata valores nulos nos campos numéricos
  /// - Converte strings para doubles com segurança
  ///
  /// 🔄 CONVERSÕES:
  /// - String → double (campos numéricos)
  /// - Enum → String (posições)
  /// - _MedicaoFields → MedicaoResistenciaIsolamentoTableDto
  void _salvar() {
    /// 🆔 ID do formulário MPDJ atual
    final id = controller.formulario.value?.id;

    /// ⚠️ Validação: formulário deve existir
    if (id == null) {
      Get.snackbar('Erro', 'Formulário não encontrado');
      return;
    }

    /// 🔧 Cria configuração geral do ensaio
    final configuracao = MedicaoResistenciaIsolamentoTableDto(
      id: 0, // Novo registro (será gerado pelo banco)
      mpDjFormId: id, // ID do formulário pai
      tensaoKv: double.tryParse(_tensaoController.text.trim()) ?? 0.0, // Valor obrigatório
      temperaturaDisjuntor: double.tryParse(_temperaturaController.text.trim()),
      umidadeRelativaAr: double.tryParse(_umidadeController.text.trim()),
    );

    /// 🔄 Converte cada medição do formulário para DTO de medições específicas
    final medicoes = _medicoes.map((m) {
      return MedicaoResistenciaIsolamentoMedicoesTableDto(
        id: 0, // Novo registro (será gerado pelo banco)
        mpDjResistenciaIsolamentoId: 0, // Será definido após salvar a configuração
        dataMedicao: DateTime.now(),
        linha: m.linha,
        terra: m.terra,
        guarda: m.guarda,
        fase: m.fase,
        estadoDisjuntor: m.estadoDisjuntor,
        resistencia30s: double.tryParse(m.resistencia30s.text.trim()),
        resistencia1min: double.tryParse(m.resistencia1min.text.trim()),
        resistencia2min: double.tryParse(m.resistencia2min.text.trim()),
        resistencia3min: double.tryParse(m.resistencia3min.text.trim()),
        resistencia4min: double.tryParse(m.resistencia4min.text.trim()),
        resistencia5min: double.tryParse(m.resistencia5min.text.trim()),
        resistencia6min: double.tryParse(m.resistencia6min.text.trim()),
        resistencia7min: double.tryParse(m.resistencia7min.text.trim()),
        resistencia8min: double.tryParse(m.resistencia8min.text.trim()),
        resistencia9min: double.tryParse(m.resistencia9min.text.trim()),
        resistencia10min: double.tryParse(m.resistencia10min.text.trim()),
      );
    }).toList();

    /// 💾 Chama o controller para salvar no banco e atualizar estado
    // TODO: Atualizar controller para salvar configuração + medições
    controller.salvarIsolamentos([configuracao]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// 📱 AppBar com título e botões de ação
      appBar: AppBar(
        title: const Text('Resistência de Isolamento'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(), // Volta para tela anterior
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _salvar, // Salva todas as medições
          ),
        ],
      ),

      /// 📄 Corpo da página com lista de medições
      body: Obx(() {
        /// ⏳ Mostra loading enquanto carrega dados
        if (controller.carregando.value) {
          return const Center(child: CircularProgressIndicator());
        }

        /// 📜 Lista rolável com todas as medições
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              /// 🔧 Card de configurações do ensaio (fixas, não mudam por medição)
              Card(
                elevation: 2,
                margin: const EdgeInsets.all(8),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '🔧 Configurações do Ensaio',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),

                      /// 📊 Configurações padrão do ensaio (não mudam por medição)
                      _textField(_tensaoController, 'Tensão aplicada (KV)'),
                      _textField(_temperaturaController, 'Temperatura ambiente (°C)'),
                      _textField(_umidadeController, 'Umidade relativa do ar(%)'),
                    ],
                  ),
                ),
              ),

              /// 🔄 Renderiza cada medição como um card
              ..._medicoes.asMap().entries.map((entry) {
                final index = entry.key; // Índice para remoção
                final m = entry.value; // Dados da medição

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        /// 🏷️ Cabeçalho do card com número e botão de remoção
                        Row(
                          children: [
                            Text('Medição ${m.numero}',
                                style: const TextStyle(fontWeight: FontWeight.bold)),
                            const Spacer(),

                            /// 🗑️ Botão de remoção (só aparece se há mais de 1 medição)
                            if (_medicoes.length > 1)
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _removerMedicao(index),
                              )
                          ],
                        ),

                        /// 🔌 Dropdowns para posições do disjuntor
                        /// 🔌 Dropdowns para posições do disjuntor
                        Row(
                          children: [
                            _dropdown('Linha', m.linha, (v) => setState(() => m.linha = v!)),
                            const SizedBox(width: 8),
                            _dropdown('Terra', m.terra, (v) => setState(() => m.terra = v!)),
                            const SizedBox(width: 8),
                            _dropdown('Guarda', m.guarda, (v) => setState(() => m.guarda = v!)),
                          ],
                        ),
                        const SizedBox(height: 12),

                        /// ⚡ Seleção de fase e estado do disjuntor
                        Row(
                          children: [
                            _faseDropdown('Fase', m.fase, (v) => setState(() => m.fase = v!)),
                            const SizedBox(width: 8),
                            _estadoDisjuntorDropdown('Estado do Disjuntor', m.estadoDisjuntor,
                                (v) => setState(() => m.estadoDisjuntor = v!)),
                          ],
                        ),
                        const SizedBox(height: 16),

                        /// 📊 Tabela de medições de resistência (11 campos)
                        const Text(
                          '📊 Medições de Resistência (GΩ)',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(height: 8),

                        /// 🔢 Grid com 11 campos de resistência
                        GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 3,
                          childAspectRatio: 2.5,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          children: [
                            _textField(m.resistencia30s, '30s', onChanged: () => setState(() {})),
                            _textField(m.resistencia1min, '1min', onChanged: () => setState(() {})),
                            _textField(m.resistencia2min, '2min'),
                            _textField(m.resistencia3min, '3min'),
                            _textField(m.resistencia4min, '4min'),
                            _textField(m.resistencia5min, '5min'),
                            _textField(m.resistencia6min, '6min'),
                            _textField(m.resistencia7min, '7min'),
                            _textField(m.resistencia8min, '8min'),
                            _textField(m.resistencia9min, '9min'),
                            _textField(m.resistencia10min, '10min',
                                onChanged: () => setState(() {})),
                          ],
                        ),
                        const SizedBox(height: 16),

                        /// 📈 Cálculo automático dos índices IA e IP com classificação e cor
                        Builder(
                          builder: (context) {
                            /// 🔢 Lê valores dos campos de resistência
                            final r30s = double.tryParse(m.resistencia30s.text.trim());
                            final r1min = double.tryParse(m.resistencia1min.text.trim());
                            final r10min = double.tryParse(m.resistencia10min.text.trim());

                            /// 📊 Calcula índices IA e IP
                            double? ia =
                                (r30s != null && r30s > 0 && r1min != null) ? r1min / r30s : null;
                            double? ip = (r1min != null && r1min > 0 && r10min != null)
                                ? r10min / r1min
                                : null;

                            /// 🏷️ Função para classificar valores em faixas
                            (String, Color) classificar(
                                double? valor, List<(double, String, Color)> faixas) {
                              if (valor == null) return ('-', Colors.grey);
                              for (final (limite, label, cor) in faixas) {
                                if (valor < limite) return (label, cor);
                              }
                              return (faixas.last.$2, faixas.last.$3); // Última faixa
                            }

                            /// 📋 Faixas de classificação para IA
                            final iaFaixas = [
                              (1.0, 'Pobre', Colors.red),
                              (1.4, 'Duvidoso', Colors.orange),
                              (1.6, 'Aceitável', Colors.blue),
                              (double.infinity, 'Bom', Colors.green),
                            ];

                            /// 📋 Faixas de classificação para IP
                            final ipFaixas = [
                              (1.0, 'Pobre', Colors.red),
                              (2.0, 'Duvidoso', Colors.orange),
                              (4.0, 'Aceitável', Colors.blue),
                              (double.infinity, 'Bom', Colors.green),
                            ];

                            /// 🎨 Classifica os índices
                            final (iaClass, iaColor) = classificar(ia, iaFaixas);
                            final (ipClass, ipColor) = classificar(ip, ipFaixas);

                            /// 📊 Retorna widget com índices calculados
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  '📈 Índices de Isolamento',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'IA (R1min / R30s): ${ia?.toStringAsFixed(2) ?? '-'} - $iaClass',
                                  style: TextStyle(color: iaColor, fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  'IP (R10min / R1min): ${ip?.toStringAsFixed(2) ?? '-'} - $ipClass',
                                  style: TextStyle(color: ipColor, fontWeight: FontWeight.w600),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }),

              /// ➕ Botão para adicionar nova medição
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: _adicionarMedicao,
                icon: const Icon(Icons.add),
                label: const Text('Adicionar Medição'),
              ),
            ],
          ),
        );
      }),
    );
  }

  /// 🔽 Widget para dropdown de posições do disjuntor
  ///
  /// 🔧 FUNCIONALIDADES:
  /// - Dropdown com opções: entrada, saida, terra
  /// - Valor selecionado é atualizado automaticamente
  /// - Layout responsivo (Expanded)
  ///
  /// 📝 PARÂMETROS:
  /// - label: Texto do label do campo
  /// - valorSelecionado: Valor atual selecionado
  /// - onChanged: Callback quando valor muda
  Widget _dropdown(String label, PosicaoDisjuntorEnsaio valorSelecionado,
      ValueChanged<PosicaoDisjuntorEnsaio?> onChanged) {
    return Expanded(
      child: DropdownButtonFormField<PosicaoDisjuntorEnsaio>(
        value: valorSelecionado, // Valor atual
        decoration: InputDecoration(labelText: label), // Label do campo
        items: _dropdownValues
            .map((e) => DropdownMenuItem(value: e, child: Text(e.name.toUpperCase())))
            .toList(), // Lista de opções
        onChanged: onChanged, // Callback de mudança
      ),
    );
  }

  /// ⚡ Widget para dropdown de fases do ensaio
  ///
  /// 🔧 FUNCIONALIDADES:
  /// - Dropdown com opções: ABC, A, B, C
  /// - Valor selecionado é atualizado automaticamente
  /// - Layout responsivo (Expanded)
  ///
  /// 📝 PARÂMETROS:
  /// - label: Texto do label do campo
  /// - valorSelecionado: Valor atual selecionado
  /// - onChanged: Callback quando valor muda
  Widget _faseDropdown(
      String label, FaseIsolamento valorSelecionado, ValueChanged<FaseIsolamento?> onChanged) {
    return Expanded(
      child: DropdownButtonFormField<FaseIsolamento>(
        value: valorSelecionado, // Valor atual
        decoration: InputDecoration(labelText: label), // Label do campo
        items: _faseValues
            .map((e) => DropdownMenuItem(value: e, child: Text(e.label)))
            .toList(), // Lista de opções
        onChanged: onChanged, // Callback de mudança
      ),
    );
  }

  /// 🔌 Widget para dropdown de estado do disjuntor
  ///
  /// 🔧 FUNCIONALIDADES:
  /// - Dropdown com opções: Aberto, Fechado
  /// - Valor selecionado é atualizado automaticamente
  /// - Layout responsivo (Expanded)
  ///
  /// 📝 PARÂMETROS:
  /// - label: Texto do label do campo
  /// - valorSelecionado: Valor atual selecionado
  /// - onChanged: Callback quando valor muda
  Widget _estadoDisjuntorDropdown(
      String label, EstadoDisjuntor valorSelecionado, ValueChanged<EstadoDisjuntor?> onChanged) {
    return Expanded(
      child: DropdownButtonFormField<EstadoDisjuntor>(
        value: valorSelecionado, // Valor atual
        decoration: InputDecoration(labelText: label), // Label do campo
        items: EstadoDisjuntor.values
            .map((e) => DropdownMenuItem(value: e, child: Text(e.label)))
            .toList(), // Lista de opções
        onChanged: onChanged, // Callback de mudança
      ),
    );
  }

  /// 📝 Widget para campo de texto numérico
  ///
  /// 🔧 FUNCIONALIDADES:
  /// - Campo de texto com teclado numérico
  /// - Suporte a decimais
  /// - Label configurável
  /// - Atualização automática dos índices
  ///
  /// 📝 PARÂMETROS:
  /// - c: Controller do campo de texto
  /// - label: Texto do label do campo
  /// - onChanged: Callback opcional para mudanças (usado nos campos de resistência)
  Widget _textField(TextEditingController c, String label, {VoidCallback? onChanged}) {
    return TextField(
      controller: c, // Controller para gerenciar o texto
      decoration: InputDecoration(labelText: label), // Label do campo
      keyboardType:
          const TextInputType.numberWithOptions(decimal: true), // Teclado numérico com decimais
      onChanged: (_) => onChanged?.call(), // Chama callback quando texto muda
    );
  }
}

/// 🔧 Usa as extensões dos converters importados

/// 📊 Classe que representa os campos de uma medição de resistência de isolamento
///
/// 🔧 FUNCIONALIDADES:
/// - Armazena todos os dados de uma medição
/// - Gerencia controllers de texto para cada campo
/// - Define valores padrão para posições
/// - Limpa recursos quando descartada
/// - Calcula índices IA e IP reativamente
///
/// 📝 CAMPOS:
/// - numero: Identificador único da medição
/// - linha/terra/guarda: Posições do disjuntor (enums)
/// - fase: Fase selecionada para medição (ABC, A, B, C)
/// - estadoDisjuntor: Estado do disjuntor (aberto/fechado)
/// - resistencias: 11 campos de resistência (30s até 10min)
class _MedicaoFields {
  /// 🔢 Número sequencial da medição (1, 2, 3...)
  final int numero;

  /// 🔌 Posições do disjuntor durante o ensaio
  /// Valores padrão seguros para cada posição
  PosicaoDisjuntorEnsaio linha = PosicaoDisjuntorEnsaio.entrada; // Posição da linha
  PosicaoDisjuntorEnsaio terra = PosicaoDisjuntorEnsaio.saida; // Posição da terra
  PosicaoDisjuntorEnsaio guarda = PosicaoDisjuntorEnsaio.terra; // Posição da guarda

  /// ⚡ Fase selecionada para medição
  FaseIsolamento fase = FaseIsolamento.abc;

  /// 🔌 Estado do disjuntor durante o ensaio
  EstadoDisjuntor estadoDisjuntor = EstadoDisjuntor.fechado; // Estado padrão

  /// 📊 Controllers para as 11 medições de resistência
  /// Cada controller representa uma medição em um tempo específico
  final TextEditingController resistencia30s = TextEditingController();
  final TextEditingController resistencia1min = TextEditingController();
  final TextEditingController resistencia2min = TextEditingController();
  final TextEditingController resistencia3min = TextEditingController();
  final TextEditingController resistencia4min = TextEditingController();
  final TextEditingController resistencia5min = TextEditingController();
  final TextEditingController resistencia6min = TextEditingController();
  final TextEditingController resistencia7min = TextEditingController();
  final TextEditingController resistencia8min = TextEditingController();
  final TextEditingController resistencia9min = TextEditingController();
  final TextEditingController resistencia10min = TextEditingController();

  /// 🏗️ Construtor que recebe o número da medição
  _MedicaoFields({required this.numero}) {
    /// 🔄 Adiciona listeners para tornar os cálculos reativos
    _adicionarListeners();
  }

  /// 🔄 Adiciona listeners aos controllers para atualização automática
  void _adicionarListeners() {
    resistencia30s.addListener(_atualizarIndices);
    resistencia1min.addListener(_atualizarIndices);
    resistencia10min.addListener(_atualizarIndices);
  }

  /// 📈 Atualiza os índices quando os valores mudam
  void _atualizarIndices() {
    // Força rebuild do widget quando os valores mudam
    // Usa setState do widget pai através de callback
    if (_onUpdate != null) {
      _onUpdate!();
    }
  }

  /// 🔄 Callback para atualizar o widget pai
  VoidCallback? _onUpdate;

  /// 🔧 Define o callback de atualização
  void setUpdateCallback(VoidCallback callback) {
    _onUpdate = callback;
  }

  /// 🧹 Método para limpar recursos dos controllers
  ///
  /// ⚠️ IMPORTANTE: Sempre chamar este método para evitar memory leaks
  /// Os controllers devem ser descartados quando não mais necessários
  void dispose() {
    /// 🗑️ Remove listeners antes de descartar
    resistencia30s.removeListener(_atualizarIndices);
    resistencia1min.removeListener(_atualizarIndices);
    resistencia10min.removeListener(_atualizarIndices);

    /// 🗑️ Descarta todos os controllers de resistência
    resistencia30s.dispose();
    resistencia1min.dispose();
    resistencia2min.dispose();
    resistencia3min.dispose();
    resistencia4min.dispose();
    resistencia5min.dispose();
    resistencia6min.dispose();
    resistencia7min.dispose();
    resistencia8min.dispose();
    resistencia9min.dispose();
    resistencia10min.dispose();
  }
}
