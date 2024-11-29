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

  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight), // Define o tamanho do AppBar
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white, // Cor de fundo do AppBar
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5), // Cor da sombra
                blurRadius: 6, // Suavidade da sombra
                offset: Offset(0, 3), // Deslocamento da sombra
              ),
            ],
          ),
          child: AppBar(
            backgroundColor: Colors.transparent, // Torna o fundo transparente
            elevation: 0, // Remove sombra nativa
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
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 5, bottom: 5),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey, // Cor da linha preta
                  width: 0.5,          // Espessura da linha
                ),
              ),
            ),
            child: Row(
              children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: 300), // Animação suave
                  width: _isExpanded ? 330.0 : 75.0, // Largura da caixa (expandida/retraída)
                  height: 40.0, // Altura fixa
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(254, 247, 255, 1.0), // Fundo da barra de pesquisa
                    borderRadius: BorderRadius.circular(20), // Bordas mais arredondadas
                    border: Border.all(color: Colors.grey, width: 1), // Borda
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isExpanded = !_isExpanded; // Alterna entre expandido e retraído
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Icon(
                            Icons.search,
                            color: Colors.black,
                            size: 24,
                          ),
                        ),
                      ),
                      if (_isExpanded)
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Pesquisar...',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 10,
                              ),
                            ),
                            style: TextStyle(
                              height: 1.9, // Controla a altura da linha para alinhamento vertical
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.filter_list, color: Colors.black),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.black),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.black),
                  onPressed: () {},
                ),
              ],
            ),
          ),
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

