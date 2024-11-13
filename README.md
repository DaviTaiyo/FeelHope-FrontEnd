# FeelHope-FrontEnd

README
FeelHope-FrontEnd
FeelHope é um aplicativo desenvolvido para auxiliar profissionais da saúde mental, como psicólogos, no acompanhamento dos sentimentos e emoções de seus pacientes. Este projeto foi desenvolvido como parte de um Trabalho de Conclusão de Curso (TCC).

Tecnologias Utilizadas
Flutter: Framework principal utilizado para o desenvolvimento do aplicativo, permitindo a criação de interfaces modernas e responsivas.
Dart: Linguagem de programação utilizada com o Flutter para construir toda a lógica e funcionalidades do aplicativo.
Provider: Gerenciador de estado utilizado para controlar e compartilhar estados entre os componentes de forma eficiente.
HTTP: Biblioteca para fazer requisições à API do backend, facilitando a comunicação entre o frontend e o servidor.
Shared Preferences: Utilizada para o armazenamento local de dados do usuário, como tokens de autenticação.
Estrutura do Projeto
components: Contém widgets reutilizáveis que ajudam a compor as telas, como botões, campos de texto com gradiente, menus laterais e ícones personalizados.

models: Define os modelos de dados principais utilizados no app, como Usuario, Sentimento, Relatorio e Recomendacao. Estes modelos ajudam a estruturar as informações manipuladas pelo aplicativo.

services: Contém os serviços responsáveis pela comunicação com o backend. Estes serviços fazem requisições HTTP para operações de CRUD nos dados de Usuario, Sentimento, Relatorio, e Recomendacao.

views: Agrupadas em subpastas para melhor organização.

main.dart: Arquivo principal onde o app é inicializado e configurado, incluindo o tema e o provedor de estado.

Como Executar
Clone o repositório:
bash
Copiar código
Front-End git clone https://github.com/DaviTaiyo/FeelHope-FrontEnd.git
Back-End git clone https://github.com/DaviTaiyo/Feelhope_Backend.git
Navegue até o diretório do projeto:
bash
Copiar código
cd FeelHope-FrontEnd
Instale as dependências:
bash
Copiar código
flutter pub get
Execute o projeto:
bash
Copiar código
flutter run

/lib
├── components
│   ├── Files.dart
│   ├── Files.dart
│   ├── Files.dart
│   ├── Files.dart
│   ├── Files.dart
│   ├── Files.dart
│   ├── Files.dart
│   ├── Files.dart
│   ├── Files.dart
│   ├── Files.dart
│   ├── Files.dart
│   └── Files.dart
├── models
│   ├── Files.dart
│   ├── Files.dart
│   ├── Files.dart
│   └── Files.dart
├── services
│   ├── Files.dart
│   ├── Files.dart
│   ├── Files.dart
│   ├── Files.dart
│   └── Files.dart
├── views
│   ├── authView
│   │   ├── Files.dart
│   │   └── Files.dart
│   ├── psychoView
│   │   ├── Files.dart
│   │   └── Files.dart
│   └── userView
│       ├── Files.dart
│       └── Files.dart
├── Files.dart
└── main.dart
