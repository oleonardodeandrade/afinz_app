# Afinz App

Aplicativo de transferências bancárias desenvolvido como parte do desafio técnico da Afinz.

## Arquitetura

Este projeto foi desenvolvido utilizando **Clean Architecture** com o padrão **BLoC** para gerenciamento de estado. A estrutura do projeto está organizada da seguinte forma:

### Camadas da Arquitetura

- **Presentation**: Contém as interfaces de usuário (widgets, pages) e os BLoCs responsáveis por gerenciar o estado da aplicação.
- **Domain**: Define as entidades de negócio, casos de uso e interfaces de repositórios.
- **Data**: Implementa os repositórios e fontes de dados (APIs, banco de dados local).

### Estrutura de Pastas

```
lib/
├── core/
│   ├── config/          # Configurações globais (API, HTTP)
│   ├── error/           # Tratamento centralizado de erros
│   └── injection.dart   # Configuração de injeção de dependências
├── features/
│   ├── app/             # Feature principal do app
│   ├── profile/         # Feature de perfil do usuário
│   └── transfer/        # Feature de transferência
└── shared/              # Componentes compartilhados
    └── widgets/         # Widgets reutilizáveis
```

### Motivações para a Escolha da Arquitetura

1. **Clean Architecture**:
   - Separação clara de responsabilidades
   - Facilidade para testes unitários
   - Baixo acoplamento entre camadas
   - Escalabilidade e manutenibilidade

2. **BLoC (Business Logic Component)**:
   - Separação entre UI e lógica de negócio
   - Gerenciamento de estado previsível e testável
   - Facilidade para lidar com operações assíncronas
   - Integração nativa com o Flutter

3. **Injeção de Dependências (GetIt)**:
   - Desacoplamento de componentes
   - Facilidade para mockar dependências em testes
   - Gerenciamento eficiente do ciclo de vida das instâncias

## Recursos e Funcionalidades

- Visualização de saldo e informações da conta
- Transferência de valores para outras contas
- Validação de dados em tempo real
- Tratamento de erros e feedback ao usuário
- Testes unitários para garantir a qualidade do código

## Tecnologias Utilizadas

- **Flutter**: Framework para desenvolvimento multiplataforma
- **Bloc/Flutter_Bloc**: Gerenciamento de estado
- **Dio**: Cliente HTTP para comunicação com APIs
- **GetIt**: Injeção de dependências
- **Intl**: Formatação de valores monetários
- **Mockito**: Framework para testes unitários
- **Flutter DotEnv**: Gerenciamento de variáveis de ambiente

## Requisitos

- Flutter SDK: 3.19.0 ou superior
- Dart: 3.3.0 ou superior

## Como Executar o Projeto

### 1. Configuração do Ambiente

Certifique-se de ter o Flutter instalado e configurado corretamente:

```bash
flutter doctor
```

### 2. Clone o Repositório

```bash
git clone https://github.com/oleonardodeandrade/afinz_app.git
cd afinz_app
```

### 3. Instale as Dependências

```bash
flutter pub get
```

### 4. Configure as Variáveis de Ambiente

Crie um arquivo `.env` na raiz do projeto com as seguintes variáveis:

```
API_TOKEN=TOKEN-TEST-AFINZ
BASE_URL=https://interview.mattlabz.tech
```

### 5. Execute o Aplicativo

```bash
flutter run
```

## Testes

Para executar os testes unitários:

```bash
flutter test
```

## Observações

- O token de autenticação para a API é `TOKEN-TEST-AFINZ`
- As transferências devem ser feitas para a agência 3212 e conta 9073

## Possíveis Melhorias Futuras

- Implementação de persistência local com SharedPreferences ou Hive
- Cache de dados para melhor performance offline
- Implementação de testes de integração e widgets
- Suporte para múltiplos idiomas
- Implementação de temas claro/escuro
