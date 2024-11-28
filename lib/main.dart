import 'package:flutter/material.dart';

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

class GymScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Bem-vindo, [Nome do Utilizador]!',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white, // Cor do topo: branco
        elevation: 1, // Pequena sombra para destacar
        actions: [
          IconButton(
            icon: const Icon(Icons.person, color: Colors.black),
            onPressed: () {
              // Lógica para alterar foto de perfil
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Header com informações do usuário
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nome do Utilizador',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  'Nº de Sócio: 12345',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
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
                  _buildGridItem(Icons.fitness_center, 'Plano de Treino'),
                  _buildGridItem(Icons.quiz, 'Questionários'),
                  _buildGridItem(Icons.flag, 'Metas'),
                  _buildGridItem(Icons.calendar_today, 'Reservas'),
                  _buildGridItem(Icons.add_circle, 'Serviços Extra'),
                  _buildGridItem(Icons.check_circle, 'Avaliação Física'),
                ],
              ),
            ),
          ),
        ],
      ),

      // BottomAppBar com ícones
      bottomNavigationBar: BottomAppBar(
        color: Colors.white, // Cor do rodapé: branco
        elevation: 10, // Sombra para destacar
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.home, color: Colors.black),
              onPressed: () {
                // Lógica para botão Home
              },
            ),
            IconButton(
              icon: const Icon(Icons.calendar_today, color: Colors.black),
              onPressed: () {
                // Lógica para botão Calendário
              },
            ),
            IconButton(
              icon: const Icon(Icons.notifications, color: Colors.black),
              onPressed: () {
                // Lógica para botão Notificações
              },
            ),
            IconButton(
              icon: const Icon(Icons.share, color: Colors.black),
              onPressed: () {
                // Lógica para botão Partilhar
              },
            ),
          ],
        ),
      ),
    );
  }

  // Função para criar os itens da GridView
  Widget _buildGridItem(IconData icon, String label) {
    return GestureDetector(
      onTap: () {
        // Lógica para cada botão
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.red,
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
}
