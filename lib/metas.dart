import 'package:flutter/material.dart';

class metas extends StatelessWidget {
  const metas({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: metasPage(),
    );
  }
}

class metasPage extends StatefulWidget {
  const metasPage({super.key});

  @override
  State<metasPage> createState() => _metasPageState();
}

class _metasPageState extends State<metasPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Número de abas
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight), // Manter a altura original do AppBar
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
                "Metas",
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
            // TabBar abaixo do AppBar
            Container(
              color: Colors.white,
              child: TabBar(
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                indicatorColor: Colors.black,
                tabs: [
                  Tab(text: 'Avaliação'),
                  Tab(text: 'Treino'),
                  Tab(text: 'Aulas'),
                ],
              ),
            ),
            // TabBarView abaixo da TabBar
            Expanded(
              child: TabBarView(
                children: [
                  // Conteúdo da aba "Avaliação"
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        SizedBox(height: 40),
                        Text(
                          'Não tem metas definidas!',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  // Conteúdo da aba "Treino"
                  Center(child: Text('Treino', style: TextStyle(fontSize: 18))),
                  // Conteúdo da aba "Aulas"
                  Center(child: Text('Aulas', style: TextStyle(fontSize: 18))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

