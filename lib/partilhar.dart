import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class PartilharPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Partilhar App',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        automaticallyImplyLeading: false, // Remove a seta de retorno
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,  // Centraliza os botões
          children: [
            Center(
              child: Image.network(
                'https://media.istockphoto.com/id/886500564/pt/foto/going-to-take-a-before-and-after-training-photo.jpg?s=612x612&w=0&k=20&c=YBq-3H1UsNaf0tVCUVSSApgeLypynnV6GckYKut6Y9Q=',
                height: 200,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            SizedBox(height: 24),

            // Texto explicativo
            Text(
              'Escolha um modo de partilha e o seu amigo receberá um endereço de uma página da internet com todas as instruções para instalar a app e criar a sua conta.',
              style: TextStyle(fontSize: 16, color: Colors.black54),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),

            // Linha de separação no topo
            Divider(color: Colors.grey[300], height: 20),

            // Botões centralizados com linha de separação
            _buildShareOption(MdiIcons.messageTextOutline, 'Mensagem'),
            Divider(color: Colors.grey[300], height: 20),  // Linha de separação
            _buildShareOption(MdiIcons.whatsapp, 'Whatsapp'),
            Divider(color: Colors.grey[300], height: 20),
            _buildShareOption(MdiIcons.emailOutline, 'Email'),
            Divider(color: Colors.grey[300], height: 20),
            _buildShareOption(MdiIcons.linkVariant, 'Copiar Link'),

            // Linha de separação no final
            Divider(color: Colors.grey[300], height: 20),
          ],
        ),
      ),
    );
  }

  // Função para criar as opções de partilha com ícones
  Widget _buildShareOption(IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextButton.icon(
        onPressed: () {
          // Lógica para cada botão de partilha
        },
        icon: Icon(icon, color: Colors.grey),  // Cor cinza para o ícone
        label: Text(
          label,
          style: TextStyle(color: Colors.grey),  // Cor cinza para o texto
        ),
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          foregroundColor: Colors.black,  // Define a cor do ícone
        ),
      ),
    );
  }
}
