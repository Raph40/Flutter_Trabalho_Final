import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AgendaPage extends StatefulWidget {
  @override
  _AgendaPageState createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> {
  late Map<DateTime, List<String>> _events; // Mapa de eventos por data
  late DateTime _selectedDay;  // Data selecionada
  late DateTime _focusedDay;   // Dia em foco (para navegação no calendário)

  // Definindo o primeiro e o último dia possível para o calendário
  late DateTime _firstDay;
  late DateTime _lastDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    _focusedDay = DateTime.now();

    // Inicializa o primeiro e último dia do calendário
    _firstDay = DateTime.utc(2024, 1, 1);
    _lastDay = DateTime.utc(2024, 12, 31);

    _events = {}; // Inicializa o mapa de eventos vazio

    // Exemplo de como adicionar eventos
    _events = {
      DateTime.utc(2024, 11, 29): ['Aula de Yoga às 10:00'],
      DateTime.utc(2024, 11, 30): ['Aula de Pilates às 14:00'],
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agenda', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        automaticallyImplyLeading: false, // Remove a seta de retorno
      ),
      body: Column(
        children: [
          // Exibe o calendário
          TableCalendar(
            firstDay: _firstDay, // Define o primeiro dia
            lastDay: _lastDay, // Define o último dia
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            eventLoader: _getEventsForDay,
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              leftChevronIcon: Icon(Icons.chevron_left, color: Colors.black),
              rightChevronIcon: Icon(Icons.chevron_right, color: Colors.black),
            ),
          ),

          // Exibe os eventos do dia selecionado
          const SizedBox(height: 24),
          Expanded(
            child: ListView(
              children: _getEventsForDay(_selectedDay).map(
                    (event) => ListTile(
                  title: Text(event),
                  leading: Icon(Icons.event, color: Colors.red),
                ),
              ).toList(),
            ),
          ),
        ],
      ),
    );
  }

  // Função para carregar eventos para um dia específico
  List<String> _getEventsForDay(DateTime day) {
    return _events[day] ?? [];
  }
}
