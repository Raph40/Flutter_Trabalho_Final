import 'package:flutter/material.dart';

class Notificacoes extends StatelessWidget {
  const Notificacoes({super.key});

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
  bool _isSelecting = false; // Indica se estamos no modo de seleção
  List<Map<String, String>> filteredNotificacoesList = notificacoesList;
  Set<int> _selectedItems = {}; // Conjunto de índices das notificações selecionadas

  TextEditingController _searchController = TextEditingController();

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
      if (query.isEmpty) {
        filteredNotificacoesList = notificacoesList;
      } else {
        filteredNotificacoesList = notificacoesList.where((notification) {
          return notification['name']!.toLowerCase().startsWith(query);
        }).toList();
      }
    });
  }

  void _toggleSelection(int index) {
    setState(() {
      if (_selectedItems.contains(index)) {
        _selectedItems.remove(index); // Desmarcar
      } else {
        _selectedItems.add(index); // Marcar
      }
    });
  }

  void _showNotificationDetails(Map<String, String> notification) {
    if (!_isSelecting) {  // Exibe os detalhes somente se não estiver em modo de seleção
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Mensagem de: ${notification['name']!}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17, // Tamanho da fonte
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(notification['message']!, style: TextStyle(fontSize: 16)),
                SizedBox(height: 10),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Fechar o diálogo
                },
                child: Text('Fechar'),
              ),
            ],
          );
        },
      );
    }
  }

  void _confirmDelete() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar exclusão'),
          content: Text('Tem certeza de que deseja apagar a(s) notificação(ões) selecionada(s)?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fechar o diálogo
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                _deleteSelectedItems();
                Navigator.of(context).pop(); // Fechar o diálogo
              },
              child: Text('Apagar'),
            ),
          ],
        );
      },
    );
  }

  void _deleteSelectedItems() {
    setState(() {
      // Remover as notificações selecionadas
      List<int> selectedIndices = _selectedItems.toList();
      selectedIndices.sort((a, b) => b.compareTo(a)); // Para não confundir os índices durante a remoção
      for (int index in selectedIndices) {
        notificacoesList.removeAt(index);
      }
      _selectedItems.clear(); // Limpar seleção
      _isSelecting = false; // Voltar para o modo normal
    });
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
              "Notificações",
              style: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              if (_isSelecting)
                IconButton(
                  icon: Icon(Icons.check, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,),
                  onPressed: _confirmDelete, // Confirma a exclusão
                ),
              IconButton(
                icon: Icon(Icons.delete, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,),
                onPressed: () {
                  setState(() {
                    _isSelecting = !_isSelecting; // Ativa/Desativa o modo de seleção
                    _selectedItems.clear(); // Limpar a seleção atual
                  });
                },
              ),
            ],
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
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    width: _isExpanded ? 215.0 : 75.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(254, 247, 255, 1.0),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey, width: 1),
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
                                  vertical: 6.5,
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
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredNotificacoesList.length,
              itemBuilder: (context, index) {
                final notification = filteredNotificacoesList[index];
                final isSelected = _selectedItems.contains(index); // Verifica se a notificação está selecionada
                return GestureDetector(
                  onTap: () {
                    if (_isSelecting) {
                      _toggleSelection(index); // Marca ou desmarca a notificação
                    } else {
                      _showNotificationDetails(notification); // Exibe o popup com os detalhes
                    }
                  },
                  onLongPress: () {
                    if (_isSelecting) {
                      _toggleSelection(index); // Ativa/desativa a seleção com pressionamento longo
                    }
                  },
                  child: Stack(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(notification['image']!),
                          child: isSelected
                              ? Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                            ),
                          )
                              : null,
                        ),
                        title: Text(
                          notification['name']!,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          notification['message']!.length > 50 // Limite de caracteres
                              ? notification['message']!.substring(0, 50) + '...'
                              : notification['message']!,
                          maxLines: 1, // Limita o número de linhas do texto para 1
                          overflow: TextOverflow.ellipsis, // Adiciona reticências quando o texto ultrapassa o limite
                        ),
                        trailing: Text(notification['date']!),
                      ),
                      if (isSelected)
                        Positioned.fill(
                          child: Container(
                            color: Colors.black.withOpacity(0.3),
                          ),
                        ),
                    ],
                  ),
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
    "message": "Jantar de Natal - Boa noite desportistas, no proximo dia 19/12 iremos realizar o nosso jantar de natal no restaurante A Tulipa no pego. Para confirmar por favor falar na receção.",
    "date": "18/11/24",
    "image": "https://cdn.pixabay.com/photo/2021/06/04/10/29/man-6309454_960_720.jpg",
  },
  {
    "name": "Ricardo Chambel",
    "message": "Código de Acesso - Boa tarde desportistas, os código de acesso ao ginásio já estão disponíveis. Para adquirir aos códigos é favor pedir na receção.",
    "date": "30/09/24",
    "image": "https://cdn.pixabay.com/photo/2021/06/04/10/29/man-6309454_960_720.jpg",
  },
  {
    "name": "Ricardo Chambel",
    "message": "Novos planos de treino - Bom dia desportistas, os novos planos de treino estão disponiveis na vossa aplicação.",
    "date": "26/09/24",
    "image": "https://cdn.pixabay.com/photo/2021/06/04/10/29/man-6309454_960_720.jpg",
  },
  {
    "name": "Maria Gomes",
    "message": "Fim do condicionamento de acesso ao Ginásio - Bom dia desportistas, os problemas já estão resolvidos. Obrigado pela vossa compreensão.",
    "date": "13/09/24",
    "image": "https://image.cdn2.seaart.me/2023-12-20/cm1ds6te878c738ime5g/f09c19216210d185f6b888f9d87e1330c383843d_high.webp",
  },
  {
    "name": "Maria Gomes",
    "message": "Condicionamento (temporário) de acesso ao Ginásio - Bom dia desportistas, por motivos técnicos o acesso ao ginásio irá estar condicionado nos próximos dias. Pedimos desculpa.",
    "date": "31/08/24",
    "image": "https://image.cdn2.seaart.me/2023-12-20/cm1ds6te878c738ime5g/f09c19216210d185f6b888f9d87e1330c383843d_high.webp",
  },
];
