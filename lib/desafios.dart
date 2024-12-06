import 'package:flutter/material.dart';

class desafios extends StatelessWidget {
  const desafios({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: desafiosPage(),
    );
  }
}

class desafiosPage extends StatefulWidget {
  const desafiosPage({super.key});

  @override
  State<desafiosPage> createState() => _desafiosPageState();
}

class _desafiosPageState extends State<desafiosPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Número de abas
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white,
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
                "Desafios",
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
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
              color: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white,
              child: TabBar(
                labelColor: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                unselectedLabelColor: Colors.grey,
                indicatorColor: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                tabs: [
                  Tab(text: 'Masculino'),
                  Tab(text: 'Feminino'),
                  Tab(text: 'Vencedores'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildDesafiosMasculinos(),
                  _buildDesafiosFemininos(),
                  _buildVencedores(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDesafiosMasculinos() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          _buildCard('Reverse Lunges', '', '3 séries de 10 repetições por perna'),
          _buildCard('Deadlifts', '', '5 séries de 5 repetições'),
          _buildCard('Pull-Ups', '', '3 séries de 8 repetições'),
        ],
      ),
    );
  }

  Widget _buildDesafiosFemininos() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          _buildCard('Airbike', '', '1 km no menor tempo possível'),
          _buildCard('Squats', '', '4 séries de 12 repetições'),
          _buildCard('Plank Hold', '', '3 séries de 1 minuto'),
        ],
      ),
    );
  }

  Widget _buildVencedores() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          _buildCard('Reverse Lunges', 'Ricardo Chambel', 'Prémio: Mensalidade gratuita + Luvas novas'),
          _buildCard('Deadlifts', 'Afonso Apura', 'Prémio: Mensalidade gratuita'),
          _buildCard('Airbike', 'Ana Mendes', 'Prémio: Mensalidade gratuita'),
          _buildCard('Squats', 'Maria Gomes', 'Prémio: Mensalidade gratuita + Saco de proteína'),
        ],
      ),
    );
  }

  Widget _buildCard(String title, String winnerName, String description) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Texto no lado esquerdo
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.red[900],
                    ),
                  ),
                  SizedBox(height: 8),
                  // Exibe "Vencedor" apenas se houver um nome fornecido.
                  if (winnerName.isNotEmpty)
                    Text(
                      'Vencedor: $winnerName',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  SizedBox(height: 8),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).brightness == Brightness.dark ? Colors.grey[100] : Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
            // Ícone no lado direito
            Icon(
              winnerName.isNotEmpty ? Icons.emoji_events : Icons.fitness_center,
              color: winnerName.isNotEmpty ? Colors.amber[700] : Colors.black,
              size: 28,
            ),
          ],
        ),
      ),
    );
  }
}
