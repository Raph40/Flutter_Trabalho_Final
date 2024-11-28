import 'package:flutter/material.dart';

class notificacoes extends StatelessWidget {
  const notificacoes({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: notificacoesPage(),
    );
  }
}

class notificacoesPage extends StatefulWidget {
  const notificacoesPage({super.key});

  @override
  State<notificacoesPage> createState() => _notificacoesPageState();
}

class _notificacoesPageState extends State<notificacoesPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NotificacoesPage(),
    );
  }
}

class NotificacoesPage extends StatefulWidget {
  const NotificacoesPage({super.key});

  @override
  State<NotificacoesPage> createState() => _NotificacoesPageState();
}

class _NotificacoesPageState extends State<NotificacoesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Notificações",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          // Barra de Ações estilizada
          Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white, Color(0xFFF8F4FF)], // Gradiente suave.
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(30), // Bordas arredondadas.
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 8,
                  offset: Offset(0, 3), // Sombra levemente deslocada.
                ),
              ],
            ),
            child: Row(
              children: [
                // Ícone de Pesquisa na Esquerda
                IconButton(
                  icon: Icon(Icons.search, color: Colors.grey),
                  onPressed: () {
                    // Ação do botão de pesquisa.
                  },
                ),
                Spacer(), // Espaço flexível entre os itens.

                // Ícones alinhados à direita
                IconButton(
                  icon: Icon(Icons.filter_list, color: Colors.grey),
                  onPressed: () {
                    // Ação do botão de filtro.
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.grey),
                  onPressed: () {
                    // Ação do botão de deletar.
                  },
                ),
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.grey),
                  onPressed: () {
                    // Ação do botão de editar.
                  },
                ),
              ],
            ),
          ),
          // Lista de notificações
          Expanded(
            child: ListView.builder(
              itemCount: notificacoesList.length,
              itemBuilder: (context, index) {
                final notification = notificacoesList[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(notification['image']!),
                  ),
                  title: Text(
                    notification['name']!,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(notification['message']!),
                  trailing: Text(notification['date']!),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

List<Map<String, String>> notificacoesList = [
  {
    "name": "Carlos Carvalho",
    "message": "Jantar de Natal",
    "date": "18/11/24",
    "image": "assets/carlos.png", // Substitua pelo caminho correto da imagem
  },
  {
    "name": "Carlos Carvalho (4)",
    "message": "Código de Acesso",
    "date": "30/09/24",
    "image": "assets/carlos.png",
  },
  {
    "name": "Carlos Carvalho",
    "message": "Novo plano de treino",
    "date": "26/09/24",
    "image": "assets/carlos.png",
  },
  {
    "name": "Mariana Torres",
    "message": "Condicionamento (temporário) de acesso ao Ginásio",
    "date": "13/09/24",
    "image": "assets/mariana.png",
  },
  {
    "name": "Mariana Torres",
    "message": "Condicionamento (temporário) de acesso ao Ginásio",
    "date": "31/08/24",
    "image": "assets/mariana.png",
  },
];

