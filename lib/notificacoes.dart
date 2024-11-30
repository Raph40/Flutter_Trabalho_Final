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
  bool _isExpanded = false;
  TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> filteredNotificacoesList = notificacoesList;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterNotifications);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterNotifications() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      // Se não houver texto na pesquisa, mostramos todas as notificações
      if (query.isEmpty) {
        filteredNotificacoesList = notificacoesList;
      } else {
        filteredNotificacoesList = notificacoesList.where((notification) {
          // Verifica se o nome começa com o texto digitado
          return notification['name']!.toLowerCase().startsWith(query);
        }).toList();
      }
    });
  }

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
                  color: Colors.grey,
                  width: 0.5,
                ),
              ),
            ),
            child: Row(
              children: [
                // A mudança aqui é no GestureDetector que agora envolve a área inteira da pesquisa
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isExpanded = !_isExpanded; // Alterna entre expandido e retraído
                    });
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    width: _isExpanded ? 330.0 : 75.0, // Largura depende do estado expandido
                    height: 40.0, // Altura fixa
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(254, 247, 255, 1.0), // Cor de fundo
                      borderRadius: BorderRadius.circular(20), // Bordas arredondadas
                      border: Border.all(color: Colors.grey, width: 1), // Borda
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Icon(
                            Icons.search,
                            color: Colors.black,
                            size: 24,
                          ),
                        ),
                        if (_isExpanded)
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              decoration: InputDecoration(
                                hintText: 'Pesquisar...',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 10,
                                ),
                              ),
                              style: TextStyle(
                                height: 1.9,
                              ),
                            ),
                          ),
                      ],
                    ),
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
              itemCount: filteredNotificacoesList.length,
              itemBuilder: (context, index) {
                final notification = filteredNotificacoesList[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: notification['image']!.startsWith('http')
                        ? NetworkImage(notification['image']!)
                        : AssetImage(notification['image']!) as ImageProvider,
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
    "name": "Ricardo Chambel",
    "message": "Jantar de Natal",
    "date": "18/11/24",
    "image": "https://cdn.pixabay.com/photo/2021/06/04/10/29/man-6309454_960_720.jpg",
  },
  {
    "name": "Ricardo Chambel",
    "message": "Código de Acesso",
    "date": "30/09/24",
    "image": "https://cdn.pixabay.com/photo/2021/06/04/10/29/man-6309454_960_720.jpg",
  },
  {
    "name": "Ricardo Chambel",
    "message": "Novo plano de treino",
    "date": "26/09/24",
    "image": "https://cdn.pixabay.com/photo/2021/06/04/10/29/man-6309454_960_720.jpg",
  },
  {
    "name": "Maria Gomes",
    "message": "Fim do condicionamento de acesso ao Ginásio",
    "date": "13/09/24",
    "image": "https://image.cdn2.seaart.me/2023-12-20/cm1ds6te878c738ime5g/f09c19216210d185f6b888f9d87e1330c383843d_high.webp",
  },
  {
    "name": "Maria Gomes",
    "message": "Condicionamento (temporário) de acesso ao Ginásio",
    "date": "31/08/24",
    "image": "https://image.cdn2.seaart.me/2023-12-20/cm1ds6te878c738ime5g/f09c19216210d185f6b888f9d87e1330c383843d_high.webp",
  },
];
