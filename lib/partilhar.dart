import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

class PartilharPage extends StatelessWidget {
  final String playStoreLink = 'https://play.google.com/store';

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
          crossAxisAlignment: CrossAxisAlignment.center, // Centraliza os botões
          children: [
            Center(
              child: Image.network(
                'https://media.istockphoto.com/id/886500564/pt/foto/going-to-take-a-before-and-after-training-photo.jpg?s=612x612&w=0&k=20&c=YBq-3H1UsNaf0tVCUVSSApgeLypynnV6GckYKut6Y9Q=',
                height: 180,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            SizedBox(height: 20),

            // Texto explicativo
            Text(
              'Escolha um modo de partilha e o seu amigo receberá um endereço de uma página da internet com todas as instruções para instalar a app e criar a sua conta.',
              style: TextStyle(fontSize: 16, color: Colors.black54),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),

            // Linha de separação no topo
            Divider(color: Colors.grey[300], height: 10),

            // Botões centralizados com linha de separação
            _buildShareOption(MdiIcons.messageTextOutline, 'Mensagem', () => _shareViaMessage(context)),
            Divider(color: Colors.grey[300], height: 10), // Linha de separação
            _buildShareOption(MdiIcons.whatsapp, 'Whatsapp', () => _shareViaWhatsapp()),
            Divider(color: Colors.grey[300], height: 10),
            _buildShareOption(MdiIcons.emailOutline, 'Email', () => _shareViaEmail()),
            Divider(color: Colors.grey[300], height: 10),
            _buildShareOption(MdiIcons.linkVariant, 'Copiar Link', () => _copyLinkToClipboard()),

            // Linha de separação no final
            Divider(color: Colors.grey[300], height: 10),
          ],
        ),
      ),
    );
  }

  // Função para criar as opções de partilha com ícones
  Widget _buildShareOption(IconData icon, String label, Function onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextButton.icon(
        onPressed: () => onPressed(),
        icon: Icon(icon, color: Colors.grey), // Cor cinza para o ícone
        label: Text(
          label,
          style: TextStyle(color: Colors.grey), // Cor cinza para o texto
        ),
        style: ButtonStyle(
          // Remove a cor de fundo
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          // Remove o efeito de hover
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          // Remove o splash
          splashFactory: NoSplash.splashFactory,
          // Define a cor do texto no normal
          foregroundColor: MaterialStateProperty.all(Colors.black),
        ),
      ),
    );
  }

  // Função para compartilhar via mensagem
  void _shareViaMessage(BuildContext context) async {
    final Uri messageUrl = Uri.parse('sms:?body=Instale o nosso app: $playStoreLink');
    if (await canLaunch(messageUrl.toString())) {
      await launch(messageUrl.toString());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Não foi possível abrir o app de mensagens')));
    }
  }

  // Função para compartilhar via WhatsApp
  void _shareViaWhatsapp() async {
    final String whatsappUrl = 'whatsapp://send?text=$playStoreLink';
    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
    } else {
      print('Não foi possível abrir o WhatsApp');
    }
  }

  // Função para compartilhar via email
  void _shareViaEmail() async {
    final Uri emailUrl = Uri.parse('mailto:?subject=Baixe a nossa aplicação&body=$playStoreLink');
    if (await canLaunch(emailUrl.toString())) {
      await launch(emailUrl.toString());
    } else {
      print('Não foi possível abrir o app de e-mail');
    }
  }

  // Função para copiar o link para a área de transferência
  void _copyLinkToClipboard() async {
    await Clipboard.setData(ClipboardData(text: playStoreLink));
    print('Link copiado para a área de transferência');
  }
}
