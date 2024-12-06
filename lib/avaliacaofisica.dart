import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

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
                "Avaliação Física",
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
            TabBar(
              labelColor: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
              indicatorColor: Theme.of(context).primaryColor,
              tabs: [
                Tab(text: 'Tabela'),
                Tab(text: 'Gráfico'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  ListView.builder(
                    padding: EdgeInsets.all(16.0),
                    itemCount: tabelaDados.length,
                    itemBuilder: (context, index) {
                      final card = tabelaDados[index];
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        elevation: 4,
                        margin: EdgeInsets.only(bottom: 16.0),
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                card['titulo'],
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 16),
                              Table(
                                columnWidths: {
                                  0: FlexColumnWidth(1),
                                  1: FlexColumnWidth(3),
                                  2: FlexColumnWidth(3),
                                  3: FlexColumnWidth(3),
                                },
                                children: [
                                  // Subtítulos
                                  TableRow(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(vertical: 8.0), // Adiciona padding
                                        child: Center(
                                          child: Text(
                                            "Tipo",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(vertical: 8.0),
                                        child: Center(
                                          child: Text(
                                            "Data",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(vertical: 8.0),
                                        child: Center(
                                          child: Text(
                                            "Valor",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(vertical: 8.0),
                                        child: Center(
                                          child: Text(
                                            "Resultado",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  // Linhas dos dados
                                  ...card['linhas'].map<TableRow>(
                                        (linha) => TableRow(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(vertical: 4.0),
                                          child: Center(
                                            child: Icon(
                                              linha['tipo'],
                                              size: 16.0,
                                              color: linha['tipoCor'],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(vertical: 4.0),
                                          child: Center(
                                            child: Text(
                                              linha['data'],
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(vertical: 4.0),
                                          child: Center(
                                            child: Text(
                                              linha['valor'],
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(vertical: 4.0),
                                          child: Center(
                                            child: Text(
                                              linha['resultado'],
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.blue,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ).toList(),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: BarChart(
                      BarChartData(
                        gridData: FlGridData(show: false),
                        titlesData: FlTitlesData(show: true),
                        borderData: FlBorderData(show: true),
                        barGroups: [
                          BarChartGroupData(x: 0, barRods: [
                            BarChartRodData(toY: 8, color: Colors.blue),
                          ]),
                          BarChartGroupData(x: 1, barRods: [
                            BarChartRodData(toY: 12, color: Colors.blue),
                          ]),
                          BarChartGroupData(x: 2, barRods: [
                            BarChartRodData(toY: 6, color: Colors.blue),
                          ]),
                        ],
                      ),
                    ),
                  ),
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

  const LegendItem({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 4),
        Text(label, style: TextStyle(fontSize: 10),),
      ],
    );
  }
}

List<Map<String, dynamic>> tabelaDados = const [
  {
    'titulo': 'Massa Muscular Total',
    'linhas': [
      {
        'tipo': Icons.circle,
        'tipoCor': Colors.red,
        'data': '27 ago. 2024',
        'valor': '55.200',
        'resultado': '⬆ 4%',
      },
      {
        'tipo': Icons.circle,
        'tipoCor': Colors.red,
        'data': '09 mai. 2024',
        'valor': '53.300',
        'resultado': '⬆ 3%',
      },
      {
        'tipo': Icons.circle,
        'tipoCor': Colors.red,
        'data': '18 mar. 2024',
        'valor': '51.900',
        'resultado': '=',
      },
    ],
  },
  {
    'titulo': 'Massa Corporal',
    'linhas': [
      {
        'tipo': Icons.circle,
        'tipoCor': Colors.red,
        'data': '27 ago. 2024',
        'valor': '19.7',
        'resultado': '⬆ 3%',
      },
      {
        'tipo': Icons.circle,
        'tipoCor': Colors.red,
        'data': '09 mai. 2024',
        'valor': '18.9',
        'resultado': '⬆ 2%',
      },
      {
        'tipo': Icons.circle,
        'tipoCor': Colors.red,
        'data': '18 mar. 2024',
        'valor': '18.4',
        'resultado': '=',
      },
    ],
  },
  {
    'titulo': 'Idade Metabólica',
    'linhas': [
      {
        'tipo': Icons.circle,
        'tipoCor': Colors.red,
        'data': '27 ago. 2024',
        'valor': '12',
        'resultado': '=',
      },
      {
        'tipo': Icons.circle,
        'tipoCor': Colors.red,
        'data': '09 mai. 2024',
        'valor': '12',
        'resultado': '=',
      },
      {
        'tipo': Icons.circle,
        'tipoCor': Colors.red,
        'data': '18 mar. 2024',
        'valor': '12',
        'resultado': '=',
      },
    ],
  },
  {
    'titulo': '% Água Total',
    'linhas': [
      {
        'tipo': Icons.circle,
        'tipoCor': Colors.red,
        'data': '27 ago. 2024',
        'valor': '64',
        'resultado': '⬇ 1%',
      },
      {
        'tipo': Icons.circle,
        'tipoCor': Colors.red,
        'data': '09 mai. 2024',
        'valor': '64.9',
        'resultado': '⬆ 2%',
      },
      {
        'tipo': Icons.circle,
        'tipoCor': Colors.red,
        'data': '18 mar. 2024',
        'valor': '63.7',
        'resultado': '=',
      },
    ],
  },
  {
    'titulo': 'Nível Gordura Visceral',
    'linhas': [
      {
        'tipo': Icons.circle,
        'tipoCor': Colors.red,
        'data': '27 ago. 2024',
        'valor': '1',
        'resultado': '=',
      },
      {
        'tipo': Icons.circle,
        'tipoCor': Colors.red,
        'data': '09 mai. 2024',
        'valor': '1',
        'resultado': '=',
      },
      {
        'tipo': Icons.circle,
        'tipoCor': Colors.red,
        'data': '18 mar. 2024',
        'valor': '1',
        'resultado': '=',
      },
    ],
  },
  {
    'titulo': 'Peso',
    'linhas': [
      {
        'tipo': Icons.circle,
        'tipoCor': Colors.red,
        'data': '27 ago. 2024',
        'valor': '63.900',
        'resultado': '⬆ 5%',
      },
      {
        'tipo': Icons.circle,
        'tipoCor': Colors.red,
        'data': '09 mai. 2024',
        'valor': '61.100',
        'resultado': '⬆ 3%',
      },
      {
        'tipo': Icons.circle,
        'tipoCor': Colors.red,
        'data': '18 mar. 2024',
        'valor': '59.600',
        'resultado': '=',
      },
    ],
  },
  {
    'titulo': 'Altura',
    'linhas': [
      {
        'tipo': Icons.circle,
        'tipoCor': Colors.red,
        'data': '27 ago. 2024',
        'valor': '180',
        'resultado': '=',
      },
      {
        'tipo': Icons.circle,
        'tipoCor': Colors.red,
        'data': '09 mai. 2024',
        'valor': '180',
        'resultado': '=',
      },
      {
        'tipo': Icons.circle,
        'tipoCor': Colors.red,
        'data': '18 mar. 2024',
        'valor': '180',
        'resultado': '=',
      },
    ],
  },
];

