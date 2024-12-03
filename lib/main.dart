import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:trabalho_final/definicoes.dart';
import 'package:trabalho_final/notificacoes.dart';
import 'package:trabalho_final/planotreino.dart';
import 'package:trabalho_final/questinario.dart';
import 'partilhar.dart';
import 'agenda.dart';

void main() {
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

  // Função que retorna o widget para a tela de acordo com o índice
  Widget _getCurrentScreen() {
    switch (_selectedIndex) {
      case 1:
        return AgendaPage(); // Tela de Agenda
      case 2:
        return notificacoesPage();
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
        // Retângulo arredondado envolvendo a AppBar
        Padding(
          padding: const EdgeInsets.only(top:50, right: 16, left: 16, bottom: 16),
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
                    CircleAvatar(
                      backgroundColor: Colors.grey[300],
                      child: Icon(Icons.person, color: Colors.black),
                    ),
                    SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Utilizador',
                          style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Sócio nº ---',
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

        // GridView com 6 botões
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
                _buildGridItem(MdiIcons.bookCheckOutline, 'Reservas'),
                _buildGridItem(MdiIcons.run, 'Serviços Extra'),
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
        color: _selectedIndex == index ? Colors.black : Colors.grey[300], // Cor do ícone selecionado
      ),
      onPressed: () {
        setState(() {
          _selectedIndex = index; // Atualiza o índice do BottomAppBar
        });
      },
    );
  }

  // Função para criar os itens da GridView
  Widget _buildGridItem(IconData icon, String label) {
    return GestureDetector(
      onTap: () {
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
          /*Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => cidadaniaPage()),
          );*/
        } else if (label == 'Reservas') {
          /*Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => educacaoPage()),
          );*/
        } else if (label == 'Serviços Extra') {
          /*Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => piscinasPage()),
          );*/
        } else if (label == 'Avaliação Fisica') {
          /*Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => piscinasPage()),
          );*/
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
      body: _getCurrentScreen(), // Chama a função que retorna a tela correspondente

      // BottomAppBar com ícones
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        elevation: 10,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildBottomIcon(Icons.home_outlined, 0),
            _buildBottomIcon(Icons.calendar_today_outlined, 1), // Agora a tela de agenda
            _buildBottomIcon(Icons.notifications_outlined, 2),
            _buildBottomIcon(MdiIcons.shareVariantOutline, 3), // Ícone Partilhar
          ],
        ),
      ),
    );
  }
}
