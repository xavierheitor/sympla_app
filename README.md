# 📱 Sympla App - Manual Completo

## 📋 Índice

1. [Visão Geral](#visão-geral)
2. [Arquitetura do Projeto](#arquitetura-do-projeto)
3. [Gerenciamento de Etapas de Atividade](#gerenciamento-de-etapas-de-atividade)
4. [Sistema de Sincronização](#sistema-de-sincronização)
5. [Fluxo de Navegação](#fluxo-de-navegação)
6. [Como Adicionar uma Nova Tela](#como-adicionar-uma-nova-tela)
7. [Estrutura de Dados](#estrutura-de-dados)
8. [Tratamento de Erros](#tratamento-de-erros)
9. [Logging e Debug](#logging-e-debug)
10. [Configuração e Deploy](#configuração-e-deploy)

---

## 🎯 Visão Geral

O **Sympla App** é uma aplicação Flutter desenvolvida para gerenciar atividades técnicas em campo. O app permite que técnicos executem atividades seguindo um fluxo estruturado de etapas, com sincronização offline/online e gerenciamento completo de dados.

### 🚀 Principais Funcionalidades

- **Autenticação** com matrícula e senha
- **Gerenciamento de Atividades** com fluxo de etapas
- **Sincronização Offline/Online** com banco local SQLite
- **Formulários Dinâmicos** (APR, Checklist, Anomalias)
- **Assinaturas Digitais** com captura de assinatura
- **Captura de Imagens** para anomalias
- **Múltiplos Tipos de Atividade** (IV/IT/IU, MPBB, MPDJ)

---

## 🏗️ Arquitetura do Projeto

### 📁 Estrutura de Pastas

```
lib/
├── core/                    # 🧠 Núcleo da aplicação
│   ├── constants/          # 📋 Constantes e configurações
│   ├── core_app/           # 🔧 Lógica principal
│   │   ├── bindings/       # 🔗 Injeção de dependências
│   │   ├── controllers/    # 🎮 Controllers globais
│   │   ├── services/       # ⚙️ Serviços principais
│   │   └── session/        # 🔐 Gerenciamento de sessão
│   ├── domain/             # 🏛️ Camada de domínio
│   │   ├── dto/           # 📦 Objetos de transferência
│   │   └── repositories/   # 🗄️ Abstrações de repositórios
│   ├── errors/             # ❌ Tratamento de erros
│   ├── logger/             # 📝 Sistema de logs
│   ├── network/            # 🌐 Cliente HTTP
│   ├── storage/            # 💾 Banco de dados local
│   └── sync/               # 🔄 Sistema de sincronização
├── modules/                # 📦 Módulos da aplicação
│   ├── home/              # 🏠 Tela principal
│   ├── login/             # 🔑 Autenticação
│   ├── apr/               # 📋 Análise Preliminar de Risco
│   ├── checklist/         # ✅ Checklist
│   ├── resumo_anomalias/  # 🚨 Resumo de Anomalias
│   ├── mp_bb/             # 🔋 Medições MPBB
│   ├── mp_dj/             # ⚡ Medições MPDJ
│   └── splash/            # 🌊 Tela de carregamento
└── routes/                # 🛣️ Configuração de rotas
```

### 🎯 Padrões Arquiteturais

#### **Clean Architecture**

- **Domain Layer**: Regras de negócio e entidades
- **Data Layer**: Repositórios e fontes de dados
- **Presentation Layer**: Controllers e Views

#### **GetX Pattern**

- **Controllers**: Gerenciamento de estado reativo
- **Bindings**: Injeção de dependências
- **Routes**: Navegação declarativa

---

## 🔄 Gerenciamento de Etapas de Atividade

### 📊 Visão Geral do Sistema

O sistema de etapas é o coração da aplicação, controlando o fluxo de execução das atividades. Cada atividade segue um fluxo predefinido baseado no seu tipo.

### 🎯 Componentes Principais

#### **1. AtividadeController**

```dart
class AtividadeController extends GetxController {
  final RxList<AtividadeTableDto> atividades = <AtividadeTableDto>[].obs;
  final Rx<AtividadeTableDto?> atividadeEmAndamento = Rx<AtividadeTableDto?>(null);
  final Rx<EtapaAtividade?> etapaAtual = Rx<EtapaAtividade?>(null);
}
```

**Responsabilidades:**

- Gerenciar lista de atividades
- Controlar atividade em andamento
- Navegar entre etapas
- Persistir mudanças de status

#### **2. AtividadeEtapaService**

```dart
class AtividadeEtapaService {
  Future<EtapaAtividade> etapaInicial(AtividadeTableDto atividade);
  Future<EtapaAtividade?> proximaEtapa(AtividadeTableDto atividade, EtapaAtividade atual);
  Future<void> executar(AtividadeTableDto atividade, EtapaAtividade etapa);
}
```

**Responsabilidades:**

- Calcular próxima etapa baseada no tipo de atividade
- Executar navegação para cada etapa
- Controlar lógica de pular etapas

### 🔄 Fluxo de Etapas

#### **Tipos de Atividade e suas Etapas:**

1. **IV/IT/IU** (Inspeção Visual/Inspeção Térmica/Inspeção Ultrassônica)

   ```
   APR → Checklist → Resumo Anomalias → Finalizada
   ```

2. **MPBB** (Medições de Baterias)

   ```
   APR → Checklist → Resumo Anomalias → Formulário MPBB → Finalizada
   ```

3. **MPDJ** (Medições de Disjuntores)

   ```
   APR → Checklist → Resumo Anomalias → Formulário MPDJ → Finalizada
   ```

#### **Configuração das Etapas:**

```dart
// lib/core/constants/etapas_atividade.dart
final Map<TipoAtividadeMobile, List<EtapaAtividade>> fluxoPorTipoAtividade = {
  TipoAtividadeMobile.ivItIu: [
    EtapaAtividade.apr,
    EtapaAtividade.checklist,
    EtapaAtividade.resumoAnomalias,
    EtapaAtividade.finalizada,
  ],
  // ... outros tipos
};
```

### 🚀 Como Funciona o Fluxo

#### **1. Iniciar Atividade**

```dart
// 1. Usuário seleciona atividade na Home
// 2. AtividadeController.iniciarAtividade() é chamado
// 3. Status muda para "emAndamento"
// 4. AtividadeEtapaService.etapaInicial() calcula primeira etapa
// 5. Navegação automática para primeira tela
```

#### **2. Avançar Etapa**

```dart
// 1. Usuário completa etapa atual
// 2. Controller chama AtividadeEtapaService.proximaEtapa()
// 3. Se há próxima etapa: navega automaticamente
// 4. Se não há: finaliza atividade e volta para Home
```

#### **3. Finalizar Atividade**

```dart
// 1. Status muda para "concluido"
// 2. Atividade em andamento é limpa
// 3. Usuário retorna para Home
// 4. Lista de atividades é atualizada
```

### 🎛️ Controle de Etapas

#### **Etapas Obrigatórias vs Opcionais:**

```dart
final Map<EtapaAtividade, bool> etapasSempreMostram = {
  EtapaAtividade.apr: true,           // ✅ Sempre aparece
  EtapaAtividade.checklist: true,     // ✅ Sempre aparece
  EtapaAtividade.resumoAnomalias: true, // ✅ Sempre aparece
  EtapaAtividade.mpBbForm: false,     // ⚠️ Pode ser pulada
  EtapaAtividade.mpDjForm: false,     // ⚠️ Pode ser pulada
};
```

#### **Lógica de Pular Etapas:**

```dart
Future<bool> desejaPularEtapa(EtapaAtividade etapa) async {
  // Futuramente: verificar configurações, dados existentes, etc.
  return false; // Por enquanto, nenhuma etapa é pulada
}
```

---

## 🔄 Sistema de Sincronização

### 📊 Visão Geral

O sistema de sincronização permite que o app funcione offline, sincronizando dados quando há conexão com a internet.

### 🏗️ Arquitetura da Sincronização

#### **1. SyncManager**

```dart
class SyncManager {
  final Map<String, SyncableRepository> _repos = {};
  
  Future<SyncResult> sincronizarTudo({bool force = false});
  Future<void> sincronizarModulo(String nomeEntidade, {bool force = false});
}
```

**Responsabilidades:**

- Coordenar sincronização de todos os módulos
- Gerenciar repositórios sincronizáveis
- Controlar sincronização forçada vs inteligente

#### **2. SyncableRepository**

```dart
abstract class SyncableRepository<T> {
  String get nomeEntidade;
  Future<List<T>> buscarDaApi();
  Future<void> sincronizarComBanco(List<T> dados);
  Future<bool> estaVazio(String nomeEntidade);
}
```

**Responsabilidades:**

- Definir interface para repositórios sincronizáveis
- Buscar dados da API
- Persistir dados no banco local

### 🔄 Fluxo de Sincronização

#### **1. Sincronização Inicial (Splash)**

```dart
// 1. App inicia na Splash
// 2. Verifica se usuário está logado
// 3. Executa SyncManager.sincronizarTudo()
// 4. Se sucesso: vai para Home
// 5. Se falha mas tem dados locais: vai para Home
// 6. Se falha e sem dados: vai para ErroSplash
```

#### **2. Sincronização Manual**

```dart
// 1. Usuário clica no botão de sincronizar
// 2. Executa SyncManager.sincronizarModulo('atividade', force: true)
// 3. Atualiza lista de atividades
// 4. Mostra feedback visual (loading/sucesso/erro)
```

#### **3. Sincronização Inteligente**

```dart
// 1. Verifica se módulo está vazio localmente
// 2. Se vazio: sincroniza automaticamente
// 3. Se não vazio: pula sincronização (economia de dados)
```

### 📦 Módulos Sincronizáveis

#### **Módulos Disponíveis:**

- **atividade**: Lista de atividades disponíveis
- **equipamento**: Dados dos equipamentos
- **defeito**: Catálogo de defeitos
- **apr**: Modelos de APR
- **checklist**: Modelos de checklist
- **tecnico**: Lista de técnicos

#### **Exemplo de Implementação:**

```dart
class AtividadeRepositoryImpl implements AtividadeRepository, SyncableRepository<AtividadeTableDto> {
  @override
  String get nomeEntidade => 'atividade';
  
  @override
  Future<List<AtividadeTableDto>> buscarDaApi() async {
    final response = await dioClient.get(ApiConstants.atividades);
    return (response.data as List).map((json) => AtividadeTableDto.fromJson(json)).toList();
  }
  
  @override
  Future<void> sincronizarComBanco(List<AtividadeTableDto> dados) async {
    await atividadeDao.sincronizar(dados);
  }
}
```

### 🔄 Estratégias de Sincronização

#### **1. Sincronização Completa**

```dart
// Usada no splash e sincronização manual
await syncManager.sincronizarTudo(force: true);
```

#### **2. Sincronização Inteligente**

```dart
// Usada em background e inicialização
await syncManager.sincronizarTudo(force: false);
```

#### **3. Sincronização de Módulo Específico**

```dart
// Usada quando precisa atualizar dados específicos
await syncManager.sincronizarModulo('atividade', force: true);
```

---

## 🛣️ Fluxo de Navegação

### 📊 Visão Geral

O sistema de navegação usa GetX com rotas nomeadas e middlewares para controle de acesso.

### 🎯 Configuração de Rotas

#### **1. Definição de Rotas**

```dart
// lib/core/constants/route_names.dart
abstract class Routes {
  static const login = '/login';
  static const splash = '/splash';
  static const home = '/home';
  static const apr = '/apr';
  static const checklist = '/checklist';
  // ... outras rotas
}
```

#### **2. Configuração de Páginas**

```dart
// lib/routes/app_pages.dart
class AppPages {
  static const initial = Routes.splash;
  
  static final routes = [
    GetPage(
      name: Routes.home,
      page: () => HomePage(),
      binding: HomeBinding(),
      middlewares: [AuthMiddleware()],
    ),
    // ... outras páginas
  ];
}
```

### 🔐 Middlewares

#### **AuthMiddleware**

```dart
class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final session = Get.find<SessionManager>();
    return session.estaLogado ? null : RouteSettings(name: Routes.login);
  }
}
```

**Responsabilidades:**

- Verificar se usuário está autenticado
- Redirecionar para login se necessário
- Proteger rotas que requerem autenticação

### 🔄 Fluxo de Navegação

#### **1. Inicialização**

```
Splash → Verifica Login → Home (se logado) ou Login (se não logado)
```

#### **2. Autenticação**

```
Login → Valida Credenciais → Splash → Home
```

#### **3. Execução de Atividade**

```
Home → Seleciona Atividade → Etapa 1 → Etapa 2 → ... → Finalizada → Home
```

#### **4. Navegação Manual**

```
Home → Drawer → APR List → APR Detail → Home
```

---

## ➕ Como Adicionar uma Nova Tela

### 📋 Passo a Passo Completo

#### **1. Definir a Rota**

```dart
// lib/core/constants/route_names.dart
abstract class Routes {
  // ... rotas existentes
  static const novaTela = '/nova-tela';
}
```

#### **2. Criar a Estrutura do Módulo**

```
lib/modules/nova_tela/
├── nova_tela_binding.dart
├── nova_tela_controller.dart
├── nova_tela_page.dart
├── nova_tela_service.dart
└── widgets/
    └── componente_widget.dart
```

#### **3. Implementar o Controller**

```dart
// lib/modules/nova_tela/nova_tela_controller.dart
class NovaTelaController extends GetxController {
  final NovaTelaService service;
  
  final dados = <DadoModel>[].obs;
  final carregando = false.obs;
  final erro = ''.obs;
  
  NovaTelaController(this.service);
  
  @override
  Future<void> onInit() async {
    super.onInit();
    await carregarDados();
  }
  
  Future<void> carregarDados() async {
    carregando.value = true;
    try {
      final resultado = await service.buscarDados();
      dados.assignAll(resultado);
    } catch (e) {
      erro.value = e.toString();
    } finally {
      carregando.value = false;
    }
  }
}
```

#### **4. Implementar a Page**

```dart
// lib/modules/nova_tela/nova_tela_page.dart
class NovaTelaPage extends StatelessWidget {
  final controller = Get.find<NovaTelaController>();
  
  NovaTelaPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nova Tela'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        if (controller.carregando.value) {
          return const Center(child: CircularProgressIndicator());
        }
        
        if (controller.erro.isNotEmpty) {
          return Center(
            child: Text('Erro: ${controller.erro.value}'),
          );
        }
        
        return ListView.builder(
          itemCount: controller.dados.length,
          itemBuilder: (context, index) {
            final dado = controller.dados[index];
            return ListTile(
              title: Text(dado.titulo),
              subtitle: Text(dado.descricao),
              onTap: () => controller.selecionarDado(dado),
            );
          },
        );
      }),
    );
  }
}
```

#### **5. Implementar o Service**

```dart
// lib/modules/nova_tela/nova_tela_service.dart
class NovaTelaService {
  final NovaTelaRepository repository;
  
  NovaTelaService(this.repository);
  
  Future<List<DadoModel>> buscarDados() async {
    return await repository.buscarTodos();
  }
  
  Future<void> salvarDado(DadoModel dado) async {
    await repository.salvar(dado);
  }
}
```

#### **6. Implementar o Binding**

```dart
// lib/modules/nova_tela/nova_tela_binding.dart
class NovaTelaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NovaTelaRepositoryImpl(Get.find(), Get.find()));
    Get.lazyPut(() => NovaTelaService(Get.find()));
    Get.lazyPut(() => NovaTelaController(Get.find()));
  }
}
```

#### **7. Registrar a Rota**

```dart
// lib/routes/app_pages.dart
static final routes = [
  // ... rotas existentes
  GetPage(
    name: Routes.novaTela,
    page: () => NovaTelaPage(),
    binding: NovaTelaBinding(),
  ),
];
```

#### **8. Adicionar ao Drawer (se necessário)**

```dart
// lib/modules/home/widgets/app_drawer.dart
ListTile(
  leading: const Icon(Icons.new_releases),
  title: const Text('Nova Tela'),
  onTap: () {
    Navigator.pop(context);
    Get.toNamed(Routes.novaTela);
  },
),
```

### 🎯 Exemplo Prático: Adicionando uma Tela de Configurações

#### **1. Estrutura Criada:**

```
lib/modules/configuracoes/
├── configuracoes_binding.dart
├── configuracoes_controller.dart
├── configuracoes_page.dart
├── configuracoes_service.dart
└── widgets/
    ├── tema_selector_widget.dart
    └── sincronizacao_widget.dart
```

#### **2. Controller com Configurações:**

```dart
class ConfiguracoesController extends GetxController {
  final temaEscuro = false.obs;
  final sincronizacaoAutomatica = true.obs;
  final intervaloSync = 30.obs; // minutos
  
  void alternarTema() {
    temaEscuro.value = !temaEscuro.value;
    Get.changeThemeMode(
      temaEscuro.value ? ThemeMode.dark : ThemeMode.light
    );
  }
  
  void alterarIntervaloSync(int minutos) {
    intervaloSync.value = minutos;
    // Salvar configuração
  }
}
```

#### **3. Page com Interface Intuitiva:**

```dart
class ConfiguracoesPage extends StatelessWidget {
  final controller = Get.find<ConfiguracoesController>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Configurações')),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Tema Escuro'),
            subtitle: const Text('Alternar entre tema claro e escuro'),
            value: controller.temaEscuro.value,
            onChanged: (_) => controller.alternarTema(),
          ),
          SwitchListTile(
            title: const Text('Sincronização Automática'),
            subtitle: const Text('Sincronizar dados automaticamente'),
            value: controller.sincronizacaoAutomatica.value,
            onChanged: (value) => controller.sincronizacaoAutomatica.value = value,
          ),
          ListTile(
            title: const Text('Intervalo de Sincronização'),
            subtitle: Text('${controller.intervaloSync.value} minutos'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => _mostrarDialogIntervalo(),
          ),
        ],
      ),
    );
  }
}
```

---

## 📊 Estrutura de Dados

### 🗄️ Banco de Dados Local (SQLite + Drift)

#### **Tabelas Principais:**

- **UsuarioTable**: Dados do usuário logado
- **AtividadeTable**: Atividades disponíveis
- **EquipamentoTable**: Equipamentos para inspeção
- **DefeitoTable**: Catálogo de defeitos
- **AnomaliaTable**: Anomalias encontradas
- **AprTable**: Respostas de APR
- **ChecklistTable**: Respostas de checklist

#### **Exemplo de Tabela:**

```dart
class AtividadeTable extends Table {
  TextColumn get uuid => text()();
  TextColumn get titulo => text()();
  TextColumn get descricao => text().nullable()();
  TextColumn get status => textEnum<StatusAtividade>()();
  TextColumn get equipamentoId => text().nullable()();
  DateTimeColumn get dataCriacao => dateTime()();
  DateTimeColumn get dataAtualizacao => dateTime().nullable()();
}
```

### 📦 DTOs (Data Transfer Objects)

#### **Estrutura de DTO:**

```dart
class AtividadeTableDto {
  final String uuid;
  final String titulo;
  final String? descricao;
  final StatusAtividade status;
  final String? equipamentoId;
  final DateTime dataCriacao;
  final DateTime? dataAtualizacao;
  
  // Construtor, fromJson, toJson, copyWith...
}
```

### 🔄 Mapeamento API ↔ Local

#### **Repository Pattern:**

```dart
abstract class AtividadeRepository {
  Future<List<AtividadeTableDto>> buscarTodas();
  Future<AtividadeTableDto?> buscarPorId(String id);
  Future<void> salvar(AtividadeTableDto atividade);
  Future<void> atualizar(AtividadeTableDto atividade);
  Future<void> deletar(String id);
}
```

---

## ❌ Tratamento de Erros

### 🛡️ Sistema de Exceções

#### **Hierarquia de Exceções:**

```dart
sealed class AppException implements Exception {
  final String mensagem;
  final TipoErro tipo;
  final StackTrace? stack;
}

class ApiException extends AppException {
  final int? statusCode;
}

class NetworkException extends AppException {
  final Uri? uri;
  final int? statusCode;
  final dynamic response;
}

class AuthException extends AppException {}

class LocalException extends AppException {}
```

#### **ErrorHandler:**

```dart
class ErrorHandler {
  static AppException tratar(dynamic error, [StackTrace? stack]) {
    if (error is AppException) return error;
    
    if (error is DioException) {
      // Tratar erros de rede
      return NetworkException(...);
    }
    
    return LocalException("Erro inesperado", stack: stack);
  }
  
  static MensagemErro mensagemUsuario(Object error) {
    // Retornar mensagens amigáveis para o usuário
  }
}
```

### 🔄 Tratamento em Controllers

#### **Padrão de Tratamento:**

```dart
Future<void> executarAcao() async {
  try {
    carregando.value = true;
    await service.executarAcao();
  } catch (e, s) {
    final tratado = ErrorHandler.tratar(e, s);
    erro.value = tratado.mensagem;
    
    Get.snackbar(
      'Erro',
      tratado.mensagem,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  } finally {
    carregando.value = false;
  }
}
```

---

## 📝 Logging e Debug

### 🔍 Sistema de Logs

#### **AppLogger:**

```dart
class AppLogger {
  static void i(dynamic msg, {String? tag}) => _log(msg, 'INFO', _green, tag);
  static void d(dynamic msg, {String? tag}) => _log(msg, 'DEBUG', _blue, tag);
  static void w(dynamic msg, {String? tag}) => _log(msg, 'WARN', _yellow, tag);
  static void e(dynamic msg, {String? tag, dynamic error, StackTrace? stackTrace});
  static void v(dynamic msg, {String? tag}) => _log(msg, 'VERBOSE', _cinza, tag);
}
```

#### **Uso em Controllers:**

```dart
AppLogger.d('🔄 Carregando atividades do banco', tag: 'AtividadeController');
AppLogger.i('✅ ${lista.length} atividades carregadas');
AppLogger.e('❌ Erro ao carregar atividades: $e', stackTrace: s);
```

### 🐛 Debug e Desenvolvimento

#### **Configurações de Debug:**

```dart
// main.dart
Get.config(
  enableLog: true,
  logWriterCallback: (text, {bool isError = false}) {
    if (isError) {
      AppLogger.e('[GETX] $text', tag: 'GetX');
    } else {
      AppLogger.d('[GETX] $text', tag: 'GetX');
    }
  },
);
```

#### **Logs de Rede:**

```dart
// dio_client.dart
onRequest: (options, handler) {
  AppLogger.v('➡️ [API REQUEST]');
  AppLogger.v('🔹 Method: ${options.method}');
  AppLogger.v('🔹 URL: ${options.uri}');
  handler.next(options);
},
```

---

## ⚙️ Configuração e Deploy

### 🔧 Configurações do Projeto

#### **Dependências Principais:**

```yaml
dependencies:
  flutter:
    sdk: flutter
  dio: ^5.8.0+1          # Cliente HTTP
  drift: ^2.13.0         # ORM para SQLite
  get: ^4.7.2            # Gerenciamento de estado
  signature: ^5.5.0      # Captura de assinatura
  image_picker: ^1.1.2   # Captura de imagens
  intl: ^0.20.2          # Internacionalização
```

#### **Configurações de API:**

```dart
// lib/core/constants/api_constants.dart
abstract class ApiConstants {
  static const baseUrl = 'http://192.168.0.100:3001/api';
  static const maxRefreshAttempts = 3;
}
```

### 🚀 Build e Deploy

#### **Android:**

```bash
# Build APK
flutter build apk --release

# Build App Bundle
flutter build appbundle --release
```

#### **iOS:**

```bash
# Build para iOS
flutter build ios --release
```

### 📱 Configurações de Plataforma

#### **Android (android/app/build.gradle):**

```gradle
android {
    compileSdkVersion 34
    
    defaultConfig {
        applicationId "com.example.sympla_app"
        minSdkVersion 21
        targetSdkVersion 34
        versionCode 1
        versionName "1.0.0"
    }
}
```

#### **iOS (ios/Runner/Info.plist):**

```xml
<key>NSCameraUsageDescription</key>
<string>Este app precisa acessar a câmera para capturar fotos de anomalias</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>Este app precisa acessar a galeria para selecionar fotos</string>
```

---

## 🎯 Conclusão

O **Sympla App** é uma aplicação robusta e bem estruturada que segue as melhores práticas de desenvolvimento Flutter. A arquitetura modular, sistema de etapas flexível e sincronização offline/online tornam o app adequado para uso em campo, onde a conectividade pode ser instável.

### 🚀 Próximos Passos Sugeridos

1. **Implementar Testes**: Adicionar testes unitários, widget tests e integration tests
2. **Melhorar UX**: Adicionar animações, feedback visual e microinterações
3. **Otimizar Performance**: Implementar lazy loading e cache inteligente
4. **Expandir Funcionalidades**: Adicionar relatórios, exportação de dados, etc.
5. **Monitoramento**: Implementar crashlytics e analytics

### 📞 Suporte

Para dúvidas sobre a implementação ou sugestões de melhorias, consulte a documentação ou entre em contato com a equipe de desenvolvimento.

---

*Documentação gerada em: ${DateTime.now().toString()}*

# sympla_app

A new Flutter project.

comando gerar banco
flutter pub run build_runner build --delete-conflicting-outputs

  🚀 Passo a passo para depurar via Wi-Fi

1. Conecte o dispositivo via USB

Só pra ativar o modo adb tcpip.

adb usb
adb devices

2. Coloque o dispositivo em modo de escuta via TCP/IP

Por padrão, a porta é 5555.

adb tcpip 5555

3. Descubra o IP do dispositivo

adb shell ip route

4. Conecte-se via Wi-Fi

Agora que temos o IP:

adb connect 192.168.0.123:5555

Se tudo der certo:

5. Desconecte o cabo USB

A partir de agora, você pode instalar, depurar, logar (adb logcat), tudo via Wi-Fi 😎

⸻
