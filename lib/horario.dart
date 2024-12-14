import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HorarioPage extends StatelessWidget {
  final double latitude = 39.45975350835327;
  final double longitude = -8.20065003409381;

  void _abrirMapa() async {
    final googleMapsUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    } else {
      throw 'Não foi possível abrir o mapa.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.grey[100],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight), // Manter a altura original do AppBar
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
              "Horário do Ginásio",
              style: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
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
                  padding: EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'Horário de abertura/fecho do ginásio:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
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
                            color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
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

              // Botão para abrir o Google Maps
              SizedBox(
                width: double.infinity, // O botão ocupa toda a largura disponível
                child: ElevatedButton.icon(
                  onPressed: _abrirMapa,
                  icon: Icon(Icons.location_on, color: Colors.red[900]),
                  label: Text(
                    'Localização do ginásio',
                    style: TextStyle(color: Colors.red[900]),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    backgroundColor: Colors.white, // Cor de fundo branca para contraste
                    shadowColor: Colors.grey.withOpacity(0.5), // Cor da sombra semelhante aos cartões
                    elevation: 8, // Altura da sombra igual aos cartões
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16), // Borda arredondada igual aos cartões
                    ),
                  ),
                ),
              ),
              // Texto adicional no fundo da página
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Para usufruir do ginásio fora do horário regular de aulas, é necessário utilizar um código de acesso. Solicitamos a gentileza de dirigir-se à receção para obter o referido código.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).brightness == Brightness.dark ? Colors.grey[100] : Colors.grey[700],
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
