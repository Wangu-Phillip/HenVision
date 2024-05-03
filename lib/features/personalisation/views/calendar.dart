// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_calendar/calendar.dart';
//
// class Calendar extends StatefulWidget {
//   const Calendar({Key? key}) : super(key: key);
//
//   @override
//   State<Calendar> createState() => _CalendarState();
// }
//
// class _CalendarState extends State<Calendar> {
//   late List<Appointment> appointments;
//
//   @override
//   void initState() {
//     super.initState();
//     appointments = <Appointment>[];
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         title: Text("CALENDAR"),
//         centerTitle: true,
//       ),
//       body: SfCalendar(
//         view: CalendarView.week,
//         onTap: (CalendarTapDetails details) {
//           if (details.targetElement == CalendarElement.calendarCell) {
//             final DateTime selectedDate = details.date!;
//             showDialog(
//               context: context,
//               builder: (BuildContext context) {
//                 return AlertDialog(
//                   title: Text('Create Event'),
//                   content: SingleChildScrollView(
//                     child: ListBody(
//                       children: <Widget>[
//                         Text('Selected date: $selectedDate'),
//                         TextField(
//                           decoration: InputDecoration(labelText: 'Event Title'),
//                           onChanged: (String value) {
//                             setState(() {
//                               appointments.removeWhere((element) =>
//                               element.startTime == selectedDate &&
//                                   element.endTime ==
//                                       selectedDate.add(Duration(hours: 1)));
//                               appointments.add(Appointment(
//                                 startTime: selectedDate,
//                                 endTime: selectedDate.add(Duration(hours: 1)),
//                                 subject: value,
//                               ));
//                             });
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                   actions: <Widget>[
//                     TextButton(
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                       },
//                       child: Text('Cancel'),
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         setState(() {
//                           Navigator.of(context).pop();
//                         });
//                       },
//                       child: Text('Save'),
//                     ),
//                   ],
//                 );
//               },
//             );
//           }
//         },
//         dataSource: AppointmentDataSource(appointments),
//       ),
//     );
//   }
// }
//
// class AppointmentDataSource extends CalendarDataSource {
//   AppointmentDataSource(List<Appointment> appointments) {
//     this.appointments = appointments;
//   }
// }


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late List<Appointment> appointments;
  final eventController = TextEditingController();

  @override
  void initState() {
    super.initState();
    appointments = <Appointment>[];
    _fetchTasks();
  }

  Future<void> _fetchTasks() async {
    final tasks = await FirebaseFirestore.instance.collection('events').get();
    tasks.docs.forEach((doc) {
      final task = doc.data();
      if (task != null) {
        final title = task['title'];
        final startTime = (task['startTime'] as Timestamp).toDate();
        final endTime = (task['endTime'] as Timestamp).toDate();
        appointments.add(Appointment(
          startTime: startTime,
          endTime: endTime,
          subject: title,
        ));
      }
    });
    setState(() {});
  }

  Future<void> _saveTask(DateTime selectedDate, String title) async {
    await FirebaseFirestore.instance.collection('events').add({
      'title': title,
      'startTime': selectedDate,
      'endTime': selectedDate.add(Duration(hours: 1)),
    });
    appointments.add(Appointment(
      startTime: selectedDate,
      endTime: selectedDate.add(Duration(hours: 1)),
      subject: title,
    ));

    eventController.clear();
    setState(() {});
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
                  title: Text('Create Event'),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        Text('Selected date: $selectedDate'),
                        TextField(
                          controller: eventController,
                          decoration: InputDecoration(labelText: 'Event Title'),
                          onChanged: (String value) {
                            setState(() {});
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
                        final title = eventController.text.trim(); // Use the actual value from the text field
                        _saveTask(selectedDate, title);
                        Navigator.of(context).pop();
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



