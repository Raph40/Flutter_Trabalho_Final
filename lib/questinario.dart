import 'package:flutter/material.dart';

class Questionario extends StatelessWidget {
  const Questionario({super.key});

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
  // Lista de questionários com título e data/hora
  final List<Map<String, String>> questionarios = [
    {'titulo': 'Questionário Dias de Treino', 'data': '2024-04-11 06:31'},
    {'titulo': 'Questionário Saúde', 'data': '2024-05-02 14:45'},
    {'titulo': 'Questionário Fitness', 'data': '2024-06-18 09:15'},
    {'titulo': 'Questionário Dieta', 'data': '2024-07-23 12:00'},
  ];

  // Perguntas específicas para cada questionário
  final Map<String, List<String>> perguntas = {
    'Questionário Dias de Treino': [
      'Quantos dias por semana treina?',
      'Qual tipo de treino que prefere?',
      'Você usa algum suplemento?'
    ],
    'Questionário Saúde': [
      'Faz exames médicos regularmente?',
      'Como está seu nível de stresse?',
      'Tem alguma condição de saúde crónica?'
    ],
    'Questionário Fitness': [
      'Qual é o seu objetivo principal com o fitness?',
      'Qual é a sua rotina de exercícios?',
      'Faz acompanhamento com algum profissional?'
    ],
    'Questionário Dieta': [
      'Qual é a sua dieta atual?',
      'Consome frutas e vegetais regularmente?',
      'Tem alguma restrição alimentar?'
    ],
  };

  // Lista para controlar o status de envio de cada questionário
  final List<bool> questionariosEnviados = [false, false, false, false];

  // Função para exibir o popup com perguntas específicas
  void _mostrarPopup(BuildContext context, String titulo, int index) {
    final listaPerguntas = perguntas[titulo] ?? []; // Obtem as perguntas para o título
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            padding: EdgeInsets.all(16),
            height: 500, // Aumenta o tamanho do popup (altura)
            width: 350, // Aumenta a largura do popup
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  titulo,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20), // Espaçamento entre o título e as perguntas
                ...listaPerguntas.map((pergunta) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 5.0), // Mais espaçamento entre perguntas
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          pergunta, // Pergunta
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 8), // Espaçamento entre a pergunta e a caixa de texto
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Resposta',
                            border: InputBorder.none, // Remover a borda para uma linha simples
                          ),
                        ),
                        Divider(), // Adiciona uma linha abaixo da caixa de texto (opcional)
                      ],
                    ),
                  );
                }).toList(),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Fecha o popup
                      },
                      child: Text('Cancelar'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Marca o questionário como enviado
                        setState(() {
                          questionariosEnviados[index] = true;
                        });

                        // Fecha o popup
                        Navigator.of(context).pop();

                        // Exibe o SnackBar
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Questionário enviado com sucesso!')),
                        );
                      },
                      child: Text('Enviar'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              "Questionários",
              style: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: questionarios.length,
        itemBuilder: (context, index) {
          final questionario = questionarios[index];

          // Verifica se o questionário foi enviado
          bool questionarioEnviado = questionariosEnviados[index];

          return GestureDetector(
            onTap: questionarioEnviado
                ? null // Desabilita o clique se o questionário foi enviado
                : () => _mostrarPopup(context, questionario['titulo']!, index),
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                ),
              ),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Texto do questionário
                      Text(
                        questionario['titulo']!,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        questionario['data']!,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  // A seta verde de envio, que aparece no canto direito quando enviado
                  if (questionarioEnviado)
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 24,
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
