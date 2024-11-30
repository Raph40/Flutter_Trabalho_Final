import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class definicoes extends StatelessWidget {
  const definicoes({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: definicoesPage(),
    );
  }
}

class definicoesPage extends StatefulWidget {
  const definicoesPage({super.key});

  @override
  State<definicoesPage> createState() => _definicoesPageState();
}

class _definicoesPageState extends State<definicoesPage> {

  bool notificacoes = true;
  bool login = true;

  String _selectedLanguage = 'Português';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight), // Define o tamanho do AppBar
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white, // Cor de fundo do AppBar
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5), // Cor da sombra
                blurRadius: 6, // Suavidade da sombra
                offset: Offset(0, 3), // Deslocamento da sombra
              ),
            ],
          ),
          child: AppBar(
            backgroundColor: Colors.transparent, // Torna o fundo transparente
            elevation: 0, // Remove sombra nativa
            centerTitle: true,
            title: Text(
              "Definições",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          // Grupo 1: Conta
          Card(
            elevation: 4,
            margin: EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SwitchListTile(
                    title: Text('Notificações'),
                    subtitle:
                    Text('Configure as definições do centro de Notificações.'),
                    value: notificacoes,
                    onChanged: (bool value) {
                      setState(() {
                        notificacoes = value;
                      });
                    },
                  ),
                  SwitchListTile(
                    title: Text('Login Automático'),
                    subtitle: Text(
                        'Deseja que o login seja feito automaticamente quando entra na aplicação?'),
                    value: login,
                    onChanged: (bool value) {
                      setState(() {
                        login = value;
                      });
                    },
                  ),
                  ListTile(
                    title: Text('Avalie a Aplicação'),
                    subtitle: Text('Partilhe a sua avaliação da nossa aplicação.'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {},
                  ),
                  ListTile(
                    title: Text('Fale connosco'),
                    subtitle: Text(
                        'Partilhe connosco os seus comentários/sugestões sobre a nossa aplicação.'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {},
                  ),
                  ListTile(
                    title: Text('Política de Privacidade'),
                    subtitle: Text(
                        'Consulte a forma como nós recolhemos e tratamos os seus dados pessoais.'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
          // Grupo 4: Lingua
          Text(
            'Língua',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Título da linguagem selecionada
                  Row(
                    children: [
                      SizedBox(width: 10),
                      Text(
                        _selectedLanguage,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  // Lista de opções de idiomas
                  Column(
                    children: _languages.map((language) {
                      return ListTile(
                        title: Text(language['name']),
                        trailing: Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          setState(() {
                            _selectedLanguage = language['name'];
                          });
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
          // Grupo 5: Social
          Text(
            'Social',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Card(
            elevation: 4,
            margin: EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text('Seguir @OnVirtualGym'),
                    subtitle: Text('Siga-nos no Facebook.'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {},
                  ),
                  ListTile(
                    title: Text('Seguir @OnVirtualGym'),
                    subtitle: Text('Siga-nos no LinkedIn.'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {},
                  ),
                  ListTile(
                    title: Text('Seguir @OnVirtualGym'),
                    subtitle: Text('Siga-nos no Instagram.'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),

          // Grupo 6: Informações
          Text(
            'Sobre',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Card(
            elevation: 4,
            margin: EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text('Versão'),
                    subtitle: Text('2.77'),
                  ),
                ],
              ),
            ),
          ),

          // Grupo 6: Sair
          Text(
            'Sair',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Card(
            elevation: 4,
            margin: EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text('Terminar Sessão'),
                    trailing: Icon(Icons.logout),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),

          // Direitos Reservados
          Center(
            child: Text(
              'Todos os direitos reservados a quêm? Ao Caralho',
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

List<Map<String, dynamic>> _languages = [
  {"name": "Português", "icon": Icons.flag_circle},
  {"name": "Inglês (Britânico)", "icon": Icons.language},
  {"name": "Alemão", "icon": Icons.translate},
];

List<Map<String, String>> definicoesList = [
  {
    "title": "Notificações",
    "description": "Configure as definições do centro de Notificações.",
    "icon": "notifications", // Nome do ícone do Material Icons
  },
  {
    "title": "Login Automático",
    "description": "Deseja que o login seja feito automaticamente quando entra na aplicação?",
    "icon": "login",
  },
  {
    "title": "Avalie a Aplicação",
    "description": "Partilhe a sua avaliação da nossa aplicação.",
    "icon": "star_rate",
  },
  {
    "title": "Fale Connosco",
    "description": "Partilhe connosco os seus comentários/sugestões sobre a nossa aplicação.",
    "icon": "chat",
  },
  {
    "title": "Política de Privacidade",
    "description": "Consulte a forma como recolhemos e tratamos os seus dados pessoais.",
    "icon": "policy",
  },
  {
    "title": "Barra de Navegação",
    "description": "Configure os atalhos visíveis na Barra de Navegação do App.",
    "icon": "navigation",
  },
  {
    "title": "Língua",
    "description": "Selecione o idioma da aplicação.",
    "icon": "language",
  },
  {
    "title": "Versão",
    "description": "2.77",
    "icon": "info",
  },
  {
    "title": "Terminar Sessão",
    "description": "Sair da aplicação.",
    "icon": "logout",
  },
];