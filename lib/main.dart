import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:trabalho_final/avaliacaofisica.dart';
import 'package:trabalho_final/definicoes.dart';
import 'package:trabalho_final/metas.dart';
import 'package:trabalho_final/notificacoes.dart';
import 'package:trabalho_final/planotreino.dart';
import 'package:trabalho_final/precario.dart';
import 'package:trabalho_final/questinario.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';
import 'partilhar.dart';
import 'agenda.dart';
import 'login.dart';
import 'horario.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyGymApp());
}

class MyGymApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GymScreen(),
    );
  }
}

class GymScreen extends StatefulWidget {
  @override
  _GymScreenState createState() => _GymScreenState();
}

class _GymScreenState extends State<GymScreen> {
  int _selectedIndex = 0; // Índice do item selecionado no BottomAppBar
  String _userName = 'Utilizador'; // Nome do usuário inicial
  String _numSocio = '---'; // Número de sócio inicial

  @override
  void initState() {
    super.initState();
    _fetchUserData(); // Buscar dados do usuário
  }

  // Função para buscar o nome e número de sócio do usuário logado
  Future<void> _fetchUserData() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final uid = user.uid;

      try {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .get();

        if (userDoc.exists) {
          setState(() {
            _userName = userDoc['name'] ?? 'Utilizador';
            _numSocio = userDoc['num_socio']?.toString() ?? '---';
          });
        }
      } catch (e) {
        print('Erro ao buscar dados do usuário: $e');
      }
    }
  }

  // Função que retorna o widget para a tela de acordo com o índice
  Widget _getCurrentScreen() {
    switch (_selectedIndex) {
      case 1:
        return AgendaPage(); // Tela de Agenda
      case 2:
        return NotificacoesPage();
      case 3:
        return PartilharPage(); // Tela de Partilhar
      default:
        return _buildHomeScreen(); // Tela inicial (home)
    }
  }

  // Função para construir a tela inicial (home)
  Widget _buildHomeScreen() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 50, right: 16, left: 16, bottom: 16),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 8,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (FirebaseAuth.instance.currentUser == null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LoginPage()),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Já tem sessão iniciada!')),
                          );
                        }
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.grey[300],
                        child: Icon(Icons.person, color: Colors.black),
                      ),
                    ),
                    SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _userName, // Exibe o nome do usuário
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Sócio nº $_numSocio', // Exibe o número de sócio
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(Icons.settings_outlined, color: Colors.black),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => definicoesPage()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              childAspectRatio: 2 / 1.5,
              children: [
                _buildGridItem(MdiIcons.armFlex, 'Plano de Treino'),
                _buildGridItem(MdiIcons.commentQuestionOutline, 'Questionários'),
                _buildGridItem(MdiIcons.bullseyeArrow, 'Metas'),
                _buildGridItem(MdiIcons.homeClockOutline, 'Horário'),
                _buildGridItem(MdiIcons.currencyUsd, 'Preçário'),
                _buildGridItem(MdiIcons.heart, 'Avaliação Física'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Função para criar os ícones do BottomAppBar
  Widget _buildBottomIcon(IconData icon, int index) {
    return IconButton(
      icon: Icon(
        icon,
        color: _selectedIndex == index ? Colors.black : Colors.grey[300],
      ),
      onPressed: () {
        final User? user = FirebaseAuth.instance.currentUser;

        // Verificação de login para impedir acesso a Agenda e Notificações
        if (user == null && (index == 1 || index == 2)) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Tem de iniciar sessão primeiro')),
          );
          return;
        }

        setState(() {
          _selectedIndex = index;
        });
      },
    );
  }

  // Função para criar os itens da GridView
  Widget _buildGridItem(IconData icon, String label) {
    return GestureDetector(
      onTap: () {
        final User? user = FirebaseAuth.instance.currentUser;

        // Se o item for "Preçário", permite acessar mesmo sem login
        if (label == 'Preçário') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => precarioPage()),
          );
          return;
        }

        // Se o item for "Horário", permite acessar mesmo sem login
        if (label == 'Horário') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HorarioPage()),
          );
          return;
        }

        // Verificação de login para outros itens (exceto Preçário)
        if (user == null && label != 'Definições' && label != 'Partilhar') {
          // Exibir mensagem se o usuário não estiver logado e tentar acessar páginas restritas
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Tem de iniciar sessão primeiro')),
          );
          return;
        }

        // Navegar para a página correspondente se o usuário estiver logado ou for permitido
        if (label == 'Plano de Treino') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => planotreinoPage()),
          );
        } else if (label == 'Questionários') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => questionarioPage()),
          );
        } else if (label == 'Metas') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => metasPage()),
          );
        } else if (label == 'Horário') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HorarioPage()),
          );
        } else if (label == 'Avaliação Física') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => avaliacaofisicaPage()),
          );
        } else if (label == 'Definições') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => definicoesPage()),
          );
        } else if (label == 'Partilhar') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PartilharPage()),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.red[700],
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 48),
            SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(color: Colors.white, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getCurrentScreen(),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        elevation: 10,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildBottomIcon(Icons.home_outlined, 0),
            _buildBottomIcon(Icons.calendar_today_outlined, 1),
            _buildBottomIcon(Icons.notifications_outlined, 2),
            _buildBottomIcon(MdiIcons.shareVariantOutline, 3),
          ],
        ),
      ),
    );
  }
}
