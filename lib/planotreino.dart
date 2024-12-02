import 'package:flutter/material.dart';

class planotreino extends StatelessWidget {
  const planotreino({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: planotreinoPage(),
    );
  }
}

class planotreinoPage extends StatefulWidget {
  const planotreinoPage({super.key});

  @override
  State<planotreinoPage> createState() => _planotreinoPageState();
}

class _planotreinoPageState extends State<planotreinoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Container(
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: Text(
              "Histórico",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.black87,
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Plano B',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Adaptação + Ganho de massa muscular',
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '15-03-2024 + 10-05-2024',
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.fitness_center,
                  color: Colors.white,
                  size: 40,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                _buildExerciseItem('Bicicleta Vertical', true),
                _buildExerciseItem('Puxador à frente pega larga em máquina', false),
                _buildExerciseItem('Remo puxador pega fechada em máquina', false),
                _buildExerciseItem('Pull-over horizontal com halteres', false),
                _buildExerciseItem('Remada baixa máquina cavalo', false),
                _buildExerciseItem('Curl alternado com halteres', false),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () {
                // Ação para iniciar plano
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text(
                'Iniciar Plano',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExerciseItem(String title, bool isActive) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isActive ? Colors.grey[200] : Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(
            Icons.fitness_center,
            color: isActive ? Colors.red : Colors.grey,
            size: 30,
          ),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

