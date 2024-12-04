import 'package:flutter/material.dart';

class avaliacaofisica extends StatelessWidget {
  const avaliacaofisica({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: avaliacaofisicaPage(),
    );
  }
}

class avaliacaofisicaPage extends StatefulWidget {
  const avaliacaofisicaPage({super.key});

  @override
  State<avaliacaofisicaPage> createState() => _avaliacaofisicaPageState();
}

class _avaliacaofisicaPageState extends State<avaliacaofisicaPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
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
              TabBar(
                labelColor: Colors.black,
                indicatorColor: Colors.blue,
                tabs: [
                  Tab(text: 'Tabela'),
                  Tab(text: 'Gráfico'),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    ListView(
                      padding: EdgeInsets.all(16.0),
                      children: cardData.map((card) {
                        return Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                          elevation: 4,
                          margin: EdgeInsets.only(bottom: 16.0),
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  card['title'],
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 8.0),
                                Column(
                                  children: (card['entries'] as List<Map<String, String>>).map((entry) {
                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.circle, // Usa o ícone armazenado no 'icon'
                                              size: 16.0, // Ajuste o tamanho do ícone
                                              color: Colors.red, // Cor do ícone (pode ajustar conforme necessário)
                                            ),
                                            SizedBox(width: 8.0), // Espaçamento entre o ícone e o texto
                                            Text(entry['data']!, style: TextStyle(fontSize: 16)), // Exibe a data
                                          ],
                                        ),
                                        Text(entry['valor']!, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                                        Text(entry['resultado']!, style: TextStyle(fontSize: 16, color: Colors.blue)),
                                      ],
                                    );
                                  }).toList(),
                                )
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    Center(child: Text('Gráfico em construção...')),
                  ],
                ),
              ),
            ],
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                LegendItem(color: Colors.red, label: 'Registo do Profissional'),
                LegendItem(color: Colors.grey, label: 'Meta Prof.'),
                LegendItem(color: Colors.blue, label: 'Meu Registo'),
                LegendItem(color: Colors.green, label: 'Minha Meta'),
              ],
            ),
          ),
        ),
    );
  }
}

class LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  LegendItem({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 4),
        Text(label, style: TextStyle(fontSize: 14)),
      ],
    );
  }
}

List<Map<String, dynamic>> cardData = [
  {
    'title': 'Massa Muscular Total',
    'entries': [
      {'data': '27 ago. 2024', 'valor': '55.200', 'resultado': '+4%'},
      {'data': '09 mai. 2024', 'valor': '53.300', 'resultado': '+3%'},
      {'data': '18 mar. 2024', 'valor': '51.900', 'resultado': '='},
    ],
  },
  {
    'title': 'I. Massa Corporal',
    'entries': [
      {'data': '27 ago. 2024', 'valor': '19.7', 'resultado': 'ver mais'},
      {'data': '09 mai. 2024', 'valor': '18.9', 'resultado': 'ver mais'},
      {'data': '18 mar. 2024', 'valor': '18.4', 'resultado': 'ver mais'},
    ],
  },
  {
    'title': 'Idade Metabólica',
    'entries': [
      {'data': '27 ago. 2024', 'valor': '12', 'resultado': '='},
      {'data': '09 mai. 2024', 'valor': '12', 'resultado': '='},
      {'data': '18 mar. 2024', 'valor': '12', 'resultado': '='},
    ],
  },
];

