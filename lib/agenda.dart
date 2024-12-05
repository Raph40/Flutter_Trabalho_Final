import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class AgendaPage extends StatefulWidget {
  @override
  _AgendaPageState createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> {
  late Map<DateTime, List<String>> _events;
  late DateTime _selectedDay;
  late DateTime _focusedDay;
  late DateTime _firstDay;
  late DateTime _lastDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    _focusedDay = DateTime.now();
    _firstDay = DateTime.utc(2024, 1, 1);
    _lastDay = DateTime.utc(2025, 12, 31);

    _events = {
      DateTime.utc(2024, 11, 4): ['Entrada no clube às 19:00'],
      DateTime.utc(2024, 11, 29): ['Aula de Yoga às 10:00'],
      DateTime.utc(2024, 11, 30): ['Aula de Pilates às 14:00'],
      DateTime.utc(2024, 12, 30): ['Aula de Step às 14:00'],
      DateTime.utc(2024, 12, 12): ['Entrada no clube às 19:00'],
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Agenda',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        automaticallyImplyLeading: false, // Remove a seta de retorno
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Calendário com eventos
            TableCalendar(
              firstDay: _firstDay,
              lastDay: _lastDay,
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
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Colors.red[500],
                  shape: BoxShape.circle,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Exibe os eventos do dia selecionado
            Expanded(
              child: _getEventsForDay(_selectedDay).isEmpty
                  ? Center(
                child: Text(
                  'Sem eventos para o dia selecionado',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              )
                  : ListView.separated(
                itemCount: _getEventsForDay(_selectedDay).length,
                separatorBuilder: (context, index) => Divider(
                  color: Colors.grey[300],
                  height: 10,
                ),
                itemBuilder: (context, index) {
                  String event = _getEventsForDay(_selectedDay)[index];
                  return ListTile(
                    leading: Icon(Icons.event, color: Colors.red),
                    title: Text(
                      event,
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Função para carregar eventos para um dia específico
  List<String> _getEventsForDay(DateTime day) {
    return _events[day] ?? [];
  }
}
