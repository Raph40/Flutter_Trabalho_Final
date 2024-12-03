import 'package:flutter/material.dart';

class questionario extends StatelessWidget {
  const questionario({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: questionarioPage(),
    );
  }
}

class questionarioPage extends StatefulWidget {
  const questionarioPage({super.key});

  @override
  State<questionarioPage> createState() => _questionarioPageState();
}

class _questionarioPageState extends State<questionarioPage> {
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
              "Questionário",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16), // Espaçamento interno
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey, // Cor da linha
              width: 1.0, // Espessura da linha para maior visibilidade
            ),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center, // Centraliza verticalmente os itens
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min, // Garante que a coluna use apenas o espaço necessário
                children: [
                  Text(
                    'Questionário Motivacional',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4), // Espaçamento entre os textos
                  Text(
                    '2024-04-11   06:31',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8), // Espaçamento entre o texto e o ícone
            Icon(
              Icons.car_rental, // Ícone
              color: Colors.grey, // Cor do ícone
              size: 24, // Tamanho do ícone
            ),
          ],
        ),
      ),
    );
  }
}

