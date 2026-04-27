import 'package:flutter/material.dart';

class Appointments {
  Appointments(this.subject, this.fromDate, this.toDate, this.appointment,
      this.isAllDay);

  String subject;
  DateTime fromDate;
  DateTime toDate;
  Color appointment;
  bool isAllDay;
}

// Relative to now so everyone can see these events when opening the prototype
class Util {
  static List<Appointments> getMockAppointments() {
    return [
      Appointments(
        '15:00 - PCR Test in Athens',
        DateTime.now().add(Duration(days: 1)),
        DateTime.now().add(Duration(days: 1, minutes: 30)),
        Colors.red,
        true,
      ),
      Appointments(
        '12:00 - Flight from Athens to Copenhagen',
        DateTime.now().add(Duration(days: 2)),
        DateTime.now().add(Duration(days: 2, hours: 1)),
        Colors.red,
        true,
      ),
      Appointments(
        '20:00 - Flight from Copenhagen to Athens',
        DateTime.now().add(Duration(days: 10)),
        DateTime.now().add(Duration(days: 10, minutes: 30)),
        Colors.red,
        true,
      ),
    ];
  }
}
