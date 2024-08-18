import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart'; 
import 'package:intl/intl.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  Map<DateTime, List<String>> _sessions = {
    DateTime(2024, 8, 20): ['Paciente: Igor - 10:00', 'Paciente: Julia - 14:50'],
    DateTime(2024, 8, 22): ['Paciente: Guilherme - 15:00', 'Paciente: Maria - 17:50'],
  };

  List<String> _getEventsForDay(DateTime day) {
    return _sessions[DateTime(day.year, day.month, day.day)] ?? [];
  }

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
  }

  void _addSession(BuildContext context) {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  DateTime _selectedDate = _selectedDay;

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Adicionar Sessão"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: "Nome do Paciente"),
              ),
              TextField(
                controller: _timeController,
                decoration: InputDecoration(labelText: "Hora (HH:MM)"),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: _selectedDate,
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2030),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      _selectedDate = pickedDate;
                    });
                  }
                },
                child: Text("Selecionar Data"),
              ),
              SizedBox(height: 10),
              Text("Data: ${DateFormat('dd/MM/yyyy').format(_selectedDate)}"),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Cancelar"),
          ),
          TextButton(
            onPressed: () {
              final String name = _nameController.text;
              final String time = _timeController.text;
              if (name.isNotEmpty && time.isNotEmpty) {
                setState(() {
                  final DateTime sessionDate = DateTime(
                    _selectedDate.year,
                    _selectedDate.month,
                    _selectedDate.day,
                  );
                  if (_sessions[sessionDate] == null) {
                    _sessions[sessionDate] = [];
                  }
                  _sessions[sessionDate]!.add("Paciente: $name - $time");
                });
                Navigator.of(context).pop();
              }
            },
            child: Text("Salvar"),
          ),
        ],
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Agenda das Sessões"),
        backgroundColor: Color(0xFF9A4DFF),
      ),
      body: Column(
        children: [
          TableCalendar(
            locale: 'pt_BR', 
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            startingDayOfWeek: StartingDayOfWeek.sunday, 
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            eventLoader: _getEventsForDay,
            calendarStyle: CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: Color(0xFF9A4DFF),
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: Colors.purpleAccent,
                shape: BoxShape.circle,
              ),
              markerDecoration: BoxDecoration(
                color: Colors.deepPurple,
                shape: BoxShape.circle,
              ),
              outsideDaysVisible: false,
            ),
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              titleTextStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            daysOfWeekStyle: DaysOfWeekStyle(
              weekendStyle: TextStyle(color: Colors.red),
            ),
          ),
          SizedBox(height: 30),
          Expanded(
            child: Center(
              child: _getEventsForDay(_selectedDay).isNotEmpty
              ? ListView(
                children: _getEventsForDay(_selectedDay).map((session) {
                  return ListTile(
                    title: Text(session),
                  );
                }).toList(),
              )
              : Text(
                "Nenhuma sessão para este dia",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addSession(context),
        child: Icon(Icons.add),
        backgroundColor: Color(0xFF9A4DFF),
      ),
    );
  }
}