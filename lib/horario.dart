import 'package:flutter/material.dart';

class HorarioPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Horário do Ginásio'),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Primeiro Bloco de Horário
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 8,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'Horário de abertura/fecho do ginásio:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Table(
                        border: TableBorder.all(
                          color: Colors.black45,
                          style: BorderStyle.solid,
                          width: 1,
                        ),
                        children: [
                          TableRow(
                            decoration: BoxDecoration(
                              color: Colors.red[900],
                            ),
                            children: [
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Dia',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 16),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Horário',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 16),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          _buildHorarioRow('Segunda-feira', '06:00 - 23:00'),
                          _buildHorarioRow('Terça-feira', '06:00 - 23:00'),
                          _buildHorarioRow('Quarta-feira', '06:00 - 23:00'),
                          _buildHorarioRow('Quinta-feira', '06:00 - 23:00'),
                          _buildHorarioRow('Sexta-feira', '06:00 - 23:00'),
                          _buildHorarioRow('Sábado', '08:00 - 22:00'),
                          _buildHorarioRow('Domingo', '08:00 - 22:00'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),

              // Segundo Bloco de Horário
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 8,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'Horário de aulas de grupo com o PT:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Table(
                        border: TableBorder.all(
                          color: Colors.black45,
                          style: BorderStyle.solid,
                          width: 1,
                        ),
                        children: [
                          TableRow(
                            decoration: BoxDecoration(
                              color: Colors.red[900],
                            ),
                            children: [
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Dia',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 16),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Horário',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 16),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          _buildHorarioRow('Segunda-feira', '10:30 - 20:30'),
                          _buildHorarioRow('Terça-feira', '10:30 - 21:00'),
                          _buildHorarioRow('Quarta-feira', '10:30 - 20:45'),
                          _buildHorarioRow('Quinta-feira', '10:30 - 21:00'),
                          _buildHorarioRow('Sexta-feira', '10:30 - 19:30'),
                          _buildHorarioRow('Sábado', '---'),
                          _buildHorarioRow('Domingo', '---'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),

              // Texto adicional no fundo da página
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Para usufruir do ginásio fora do horário regular de aulas, é necessário utilizar um código de acesso. Solicitamos a gentileza de dirigir-se à receção para obter o referido código.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Função para criar as linhas de horário
  TableRow _buildHorarioRow(String dia, String horario) {
    return TableRow(
      children: [
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(dia),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(horario),
          ),
        ),
      ],
    );
  }
}
