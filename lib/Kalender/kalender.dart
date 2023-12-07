import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:kebaya_boutiq/home_page.dart';
import 'package:kebaya_boutiq/keuangan/inputiuran.dart';
import 'package:kebaya_boutiq/pages/inputabsensi.dart';
import '../pages/Absensi_Models.dart';

void main() {
  runApp(Calendar());
}

class Calendar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CalendarApp(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CalendarApp extends StatefulWidget {
  @override
  _CalendarAppState createState() => _CalendarAppState();
}

class _CalendarAppState extends State<CalendarApp> {
  late DateTime _selectedDay;
  late DateTime _focusedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  Map<DateTime, List<Event>> events = {};

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    _focusedDay = DateTime.now();
  }

  List<Event> _getEventsForDay(DateTime day) {
    return events[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Kalender dengan Catatan',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.pink,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          TableCalendar(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            calendarFormat: _calendarFormat,
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _focusedDay = focusedDay;
                _selectedDay = selectedDay;
              });
            },
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            onPageChanged: (focusedDay) {
              setState(() {
                _focusedDay = focusedDay;
              });
            },
            eventLoader: (day) {
              return _getEventsForDay(day);
            },
          ),
          Expanded(
            child: _buildEventList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addEvent(context);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.pink,
      ),
    );
  }

  Widget _buildEventList() {
    final selectedEvents = _getEventsForDay(_selectedDay);
    return ListView.builder(
      itemCount: selectedEvents.length,
      itemBuilder: (context, index) {
        final event = selectedEvents[index];
        return ListTile(
          title: Row(
            children: [
              Icon(Icons.edit, color: Colors.pink),
              SizedBox(width: 8),
              Text(
                event.title,
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.pink),
              ),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.calendar_today),
                  SizedBox(width: 8),
                  Text(DateFormat('dd/MM/yyyy').format(event.date)),
                ],
              ),
              Text(
                event.note,
                style: TextStyle(color: Colors.pink),
              ),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.assignment),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InputAbsensiPage(
                        kegiatan: '',
                        kegiatanController: TextEditingController(),
                        selectedDate: DateTime.now(),
                        tanggalController: TextEditingController(),
                        absensi: Absensi(
                          nama: 'Nama Anggota',
                          jabatan: 'Jabatan',
                          hadir: '',
                          tidakHadir: '',
                          tanggal: DateTime.now(),
                          kegiatan: '',
                          alasanTidakHadir: '',
                        ),
                      ),
                    ),
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.attach_money),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InputIuranPage(),
                    ),
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  _editEvent(context, event);
                },
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  _deleteEvent(event);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _addEvent(BuildContext context) async {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController noteController = TextEditingController();
    DateTime selectedDate = _selectedDay;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tambah Catatan'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                cursorColor: Colors.pink,
                decoration: InputDecoration(
                    labelText: 'Title',
                    labelStyle: TextStyle(color: Colors.pink),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.pink, width: 2.0),
                    )),
              ),
              TextField(
                controller: noteController,
                cursorColor: Colors.pink,
                decoration: InputDecoration(
                    labelText: 'Note',
                    labelStyle: TextStyle(color: Colors.pink),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.pink, width: 2.0),
                    )),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Batal',
                style: TextStyle(
                  color: Colors.pink,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                final title = titleController.text;
                final note = noteController.text;

                if (title.isNotEmpty) {
                  final newEvent = Event(title, note, selectedDate);

                  setState(() {
                    if (events[selectedDate] != null) {
                      events[selectedDate]!.add(newEvent);
                    } else {
                      events[selectedDate] = [newEvent];
                    }
                  });

                  Navigator.of(context).pop();
                }
              },
              child: Text('Simpan'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.pink),
              ),
            ),
          ],
        );
      },
    );
  }

  void _editEvent(BuildContext context, Event event) async {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController noteController = TextEditingController();

    titleController.text = event.title;
    noteController.text = event.note;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Edit Catatan',
            style: TextStyle(color: Colors.pink),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                cursorColor: Colors.pink,
                decoration: InputDecoration(
                    labelText: 'Judul',
                    labelStyle: TextStyle(
                      color: Colors.pink,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.pink, width: 2.0),
                    )),
              ),
              TextField(
                controller: noteController,
                cursorColor: Colors.pink,
                decoration: InputDecoration(
                    labelText: 'Catatan',
                    labelStyle: TextStyle(color: Colors.pink),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.pink, width: 2.0),
                    )),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                final title = titleController.text;
                final note = noteController.text;

                if (title.isNotEmpty) {
                  final editedEvent = Event(title, note, event.date);

                  setState(() {
                    events[event.date]!.remove(event);
                    events[event.date]!.add(editedEvent);
                  });

                  Navigator.of(context).pop();
                }
              },
              child: Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  void _deleteEvent(Event event) {
    setState(() {
      events[event.date]!.remove(event);
    });
  }
}

class Event {
  final String title;
  final String note;
  final DateTime date;

  Event(this.title, this.note, this.date);
}
