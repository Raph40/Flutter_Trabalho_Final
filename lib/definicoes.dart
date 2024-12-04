import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:colorful_iconify_flutter/icons/emojione.dart';
import 'package:trabalho_final/main.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

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
  String _activeIcon = "portugal";

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    tz.initializeTimeZones(); // Initialize timezones
    _initializeNotifications();
  }

  // Função para inicializar o FlutterLocalNotificationsPlugin
  void _initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('app_icon');
    const InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  // Função para agendar uma notificação
  Future<void> _scheduleNotification() async {
    final tz.TZDateTime scheduledDate = tz.TZDateTime.now(tz.local).add(Duration(seconds: 5)); // Use TZDateTime
    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Notificação Programada',
      'Essa notificação foi programada',
      scheduledDate,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'your_channel_id',
          'your_channel_name',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  // Função que será chamada quando o SwitchListTile for alterado
  void _toggleNotifications(bool value) {
    setState(() {
      notificacoes = value;
    });
    if (notificacoes) {
      _scheduleNotification(); // Se as notificações forem ativadas, agendamos uma
    } else {
      flutterLocalNotificationsPlugin.cancelAll(); // Cancelar todas as notificações
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
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
                    activeTrackColor: Colors.red[700],
                    title: Text('Notificações'),
                    subtitle: Text('Ligar e desligar as notificações.'),
                    value: notificacoes,
                    onChanged: (bool value) {
                     _toggleNotifications(value); // Controla as notificações
                    },
                  ),
                  SwitchListTile(
                    activeTrackColor: Colors.red[700],
                    title: Text('Modo Light e Dark'),
                    subtitle: Text('Tema Light e Dark para a aplicação.'),
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
                    onTap: () => _launchURL('https://play.google.com/'),
                  ),
                  ListTile(
                    title: Text('Política de Privacidade'),
                    subtitle: Text(
                        'Consulte a forma como nós recolhemos e tratamos os seus dados pessoais.'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () => _launchURL('https://onvirtualgym.com/privacy-policy/'),
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
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        icon: Opacity(
                          opacity: _activeIcon == "portugal" ? 1.0 : 0.3,
                          child: Iconify(
                            Emojione.flag_for_portugal,
                            size: 40,
                            color: null,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            _selectedLanguage = "Português";
                            _activeIcon = "portugal";
                          });
                        },
                      ),
                      Padding(padding: EdgeInsets.only(right: 20.0)),
                      IconButton(
                        icon: Opacity(
                          opacity: _activeIcon == "inglês" ? 1.0 : 0.3,
                          child: Iconify(
                            Emojione.flag_for_united_kingdom,
                            size: 40,
                            color: null,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            _selectedLanguage = "Inglês";
                            _activeIcon = "inglês";
                          });
                        },
                      ),
                      Padding(padding: EdgeInsets.only(right: 20.0)),
                      IconButton(
                        icon: Opacity(
                          opacity: _activeIcon == "francês" ? 1.0 : 0.3,
                          child: Iconify(
                            Emojione.flag_for_france,
                            size: 40,
                            color: null,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            _selectedLanguage = "Francês";
                            _activeIcon = "francês";
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(
                          MdiIcons.facebook,
                          size: 40,
                          color: Colors.blue,
                        ),
                        onPressed: () => _launchURL('https://www.facebook.com/gymvirtual/'),
                      ),
                      Text(
                        'Facebook',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(
                          MdiIcons.linkedin,
                          size: 40,
                          color: Colors.blue[700],
                        ),
                        onPressed: () => _launchURL('https://pt.linkedin.com/'),
                      ),
                      Text(
                        'LinkedIn',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(
                          MdiIcons.instagram,
                          size: 40,
                          color: Colors.purple,
                        ),
                        onPressed: () => _launchURL('https://www.instagram.com/'),
                      ),
                      Text(
                        'Instagram',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ],
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
                    onTap: () async {
                      final User? user = FirebaseAuth.instance.currentUser; // Verifica se o usuário está autenticado

                      if (user == null) {
                        // Se não houver usuário logado, mostra um aviso
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Não tem sessão iniciada.')),
                        );
                      } else {
                        // Se o usuário estiver logado, termina a sessão
                        try {
                          await FirebaseAuth.instance.signOut();
                          // Redireciona para a tela de login e remove a pilha de navegação anterior
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => MyGymApp()),
                                (route) => false,
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Erro ao terminar sessão: $e')),
                          );
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          ),

          // Direitos Reservados
          Center(
            child: Text(
              'Todos os direitos reservados a @GymVirtual',
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

void _launchURL(String url) async {
  final Uri uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } else {
    throw 'Não foi possível abrir o link: $url';
  }
}
