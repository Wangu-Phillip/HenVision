import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late List<Appointment> appointments;

  @override
  void initState() {
    super.initState();
    appointments = <Appointment>[];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("CALENDAR"),
        centerTitle: true,
      ),
      body: SfCalendar(
        view: CalendarView.week,
        onTap: (CalendarTapDetails details) {
          if (details.targetElement == CalendarElement.calendarCell) {
            final DateTime selectedDate = details.date!;
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Create Appointment'),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        Text('Selected date: $selectedDate'),
                        TextField(
                          decoration: InputDecoration(labelText: 'Appointment Title'),
                          onChanged: (String value) {
                            setState(() {
                              appointments.removeWhere((element) =>
                              element.startTime == selectedDate &&
                                  element.endTime ==
                                      selectedDate.add(Duration(hours: 1)));
                              appointments.add(Appointment(
                                startTime: selectedDate,
                                endTime: selectedDate.add(Duration(hours: 1)),
                                subject: value,
                              ));
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          Navigator.of(context).pop();
                        });
                      },
                      child: Text('Save'),
                    ),
                  ],
                );
              },
            );
          }
        },
        dataSource: AppointmentDataSource(appointments),
      ),
    );
  }
}

class AppointmentDataSource extends CalendarDataSource {
  AppointmentDataSource(List<Appointment> appointments) {
    this.appointments = appointments;
  }
}
