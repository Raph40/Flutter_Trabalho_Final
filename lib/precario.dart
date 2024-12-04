import 'package:flutter/material.dart';

class precario extends StatelessWidget {
  const precario({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: precarioPage(),
    );
  }
}

class precarioPage extends StatelessWidget {
  const precarioPage({super.key});

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
              "Preçário",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              PricingCard(
                title: 'Mensalidade',
                price: '29.99€',
                details: [
                  'Sem fidelização;',
                  'Acesso ao ginásio;',
                  'Aulas de grupo;',
                  'Avaliação física;',
                  'Planos de treino;',
                  'Código de entrada;',
                ],
                buttonLabel: 'Obter plano',
              ),
              SizedBox(height: 16),
              PricingCard(
                title: 'Diária',
                price: '5.99€',
                details: [
                  'Acesso ao ginásio;',
                  'Aulas de grupo;',
                ],
                buttonLabel: 'Obter plano',
              ),
              SizedBox(height: 16),
              PricingCard(
                title: 'Cartão 10 Acessos',
                price: '29.99€',
                details: [
                  'Acesso ao ginásio 10 vezes;',
                ],
                buttonLabel: 'Obter plano',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PricingCard extends StatelessWidget {
  final String title;
  final String price;
  final List<String> details;
  final String buttonLabel;

  PricingCard({
    required this.title,
    required this.price,
    required this.details,
    required this.buttonLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              price,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 8),
            ...details.map((detail) => Text(
              '• $detail',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
            )),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Ação do botão
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[700],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Center(
                child: Text(buttonLabel, style: TextStyle(color: Colors.white),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

