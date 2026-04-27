// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:theme_example/helpers/country.dart';
import 'package:theme_example/helpers/utils.dart';
import 'package:theme_example/helpers/appointments.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:searchfield/searchfield.dart';
import 'package:intl/intl.dart';

import 'SettingsScreen.dart';

//import 'package:add_2_calendar/add_2_calendar.dart';

class myCalendarScreen extends StatefulWidget {
  @override
  State<myCalendarScreen> createState() => _CalendarScreenState();
}

List<Appointments> more_appointments = [];

class _CalendarScreenState extends State<myCalendarScreen> {
  // ignore: non_constant_identifier_names
  Category departure_region;
  Category destination_region;
  DateTime _flightDateTime;
  DateTime _vaccDate;
  bool ok = false;
  String certificate_type = 'PCR test';
  TimeOfDay _flightTime = TimeOfDay(hour: 12, minute: 0);
  TimeOfDay _vaccTime = TimeOfDay(hour: 12, minute: 0);
  String _errortext;
  List<Category> categories = Utils.getMockedCategories();
  List<String> reglist = Utils.getMockedCategories()
      .map((el) => '${el.region},${el.country}')
      .toList();
  List<String> certs = ['Vaccination', 'PCR test', 'rapid test'];
  @override
  void initState() {
    super.initState();
    setState(() {});
    _errortext = "";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(children: [
      SfCalendar(
          view: CalendarView.month,
          dataSource: _getCalendarDataSource(),
          monthViewSettings: const MonthViewSettings(
            navigationDirection: MonthNavigationDirection.horizontal,
            showAgenda: true,
            agendaViewHeight: 300,
          )),
      Positioned(
        bottom: 100,
        right: 100,
        child: RaisedButton(
          onPressed: () {
            opendialog_flight().then((value) {
              if (ok == true) {
                _flightDateTime = new DateTime(
                    _flightDateTime.year,
                    _flightDateTime.month,
                    _flightDateTime.day,
                    _flightTime.hour,
                    _flightTime.minute);
                setState(() {
                  more_appointments.add(Appointments(
                    DateFormat("kk:mm").format(_flightDateTime) +
                        ' - Flight from ${departure_region.region} to ${destination_region.region}',
                    _flightDateTime,
                    _flightDateTime.add(Duration(hours: 1)),
                    Colors.red,
                    true,
                  ));
                });
                // Add alert box here
                flight_popup(departure_region, destination_region);
              }
              ok = false;
              departure_region = null;
              destination_region = null;
              _flightDateTime = null;
            });
          },
          child: const Icon(
            Icons.airplanemode_active,
            size: 50,
          ),
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(15),
        ),
      ),
      Positioned(
        bottom: 100,
        left: 100,
        child: RaisedButton(
          onPressed: () {
            opendialog_cert().then((value) {
              if (ok == true) {
                _vaccDate = new DateTime(_vaccDate.year, _vaccDate.month,
                    _vaccDate.day, _vaccTime.hour, _vaccTime.minute);
                setState(() {
                  more_appointments.add(Appointments(
                    DateFormat("kk:mm").format(_vaccDate) +
                        ' - ${certificate_type}',
                    _vaccDate,
                    _vaccDate.add(Duration(minutes: 15)),
                    Colors.red,
                    true,
                  ));
                });
                // Add alert box here
              }
              ok = false;
              departure_region = null;
              destination_region = null;
              _flightDateTime = null;
            });
          },
          child: const Icon(
            Icons.medication,
            size: 50,
          ),
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(15),
        ),
      )
    ]));
  }

  // ignore: non_constant_identifier_names
  Future opendialog_flight() => showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
          builder: (context, setState) => Dialog(
              backgroundColor: Theme.of(context).canvasColor,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              insetPadding: const EdgeInsets.all(10),
              child: Builder(
                builder: (context) {
                  // Get available height and width of the build area of this widget. Make a choice depending on the size.
                  var height = MediaQuery.of(context).size.height;
                  var width = MediaQuery.of(context).size.width;
                  return SizedBox(
                      height: height * 0.80,
                      width: width * 0.65,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 40, left: 25),
                              child: Text(
                                'Add a Flight',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 40,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 20, left: 25),
                              child: Text(
                                'Departure Region',
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: SearchField(
                                hint: 'Search',
                                searchInputDecoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.purple,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.purple.withOpacity(0.8),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onTap: (value) {
                                  setState(() {
                                    List<String> selected_ctr =
                                        value?.split(",");
                                    List<Category> tmp = categories
                                        .where((u) =>
                                            (u.region == selected_ctr[0] &&
                                                u.country == selected_ctr[1]))
                                        .toList();
                                    departure_region = tmp[0];
                                  });
                                },
                                suggestions: reglist,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 20, left: 25),
                              child: Text(
                                'Destination Region',
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: SearchField(
                                hint: 'Search',
                                searchInputDecoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.purple,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.purple.withOpacity(0.8),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onTap: (value) {
                                  setState(() {
                                    List<String> selected_ctr =
                                        value?.split(",");
                                    List<Category> tmp = categories
                                        .where((u) =>
                                            (u.region == selected_ctr[0] &&
                                                u.country == selected_ctr[1]))
                                        .toList();
                                    destination_region = tmp[0];
                                  });
                                },
                                suggestions: reglist,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 20, left: 25),
                              child: Text(
                                'Date of Flight:',
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 20),
                                child: RaisedButton(
                                    child: Text(
                                        '${_flightDateTime != null ? DateFormat("dd-MM-yyyy").format(_flightDateTime ?? "") : 'Pick a Date'}'),
                                    color: Theme.of(context).backgroundColor,
                                    onPressed: () {
                                      showDatePicker(
                                        context: context,
                                        initialDate:
                                            _flightDateTime ?? DateTime.now(),
                                        firstDate: DateTime(2020),
                                        lastDate: DateTime(2040),
                                      ).then((date) {
                                        setState(() {
                                          if (date != null) {
                                            _flightDateTime = date;
                                          }
                                        });
                                      });
                                    })),
                            const Padding(
                              padding: EdgeInsets.only(top: 10, left: 25),
                              child: Text(
                                'Time of Flight:',
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 20),
                                child: RaisedButton(
                                    child: Text(
                                        '${_flightTime.hour}:${_flightTime.minute.toString().padLeft(2, '0')}'),
                                    color: Theme.of(context).backgroundColor,
                                    onPressed: () {
                                      showTimePicker(
                                        context: context,
                                        initialTime: _flightTime,
                                      ).then((time) {
                                        setState(() {
                                          if (time != null) {
                                            _flightTime = time;
                                          }
                                        });
                                      });
                                    })),
                            Padding(
                              padding: EdgeInsets.only(top: 20, left: 25),
                              child: Text(
                                _errortext,
                                textAlign: TextAlign.left,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 20),
                                child: RaisedButton(
                                    child: Text('OK'),
                                    color: Theme.of(context).backgroundColor,
                                    onPressed: () {
                                      if (_flightDateTime != null &&
                                          destination_region != null &&
                                          departure_region != null) {
                                        setState(() {
                                          ok = true;
                                        });
                                        Navigator.pop(context);
                                      } else {
                                        if (departure_region == null) {
                                          setState(() {
                                            _errortext =
                                                "Please insert the departure region";
                                          });
                                        } else if (destination_region == null) {
                                          setState(() {
                                            _errortext =
                                                "Please insert the flight destination";
                                          });
                                        } else if (_flightDateTime == null) {
                                          setState(() {
                                            _errortext =
                                                "Please insert the Date of the flight";
                                          });
                                        }
                                      }
                                    }))
                          ],
                        ),
                      ));
                },
              ))));

  // ignore: non_constant_identifier_names
  Future opendialog_cert() => showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
          builder: (context, setState) => Dialog(
              backgroundColor: Theme.of(context).canvasColor,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              insetPadding: const EdgeInsets.all(10),
              child: Builder(
                builder: (context) {
                  // Get available height and width of the build area of this widget. Make a choice depending on the size.
                  var height = MediaQuery.of(context).size.height;
                  var width = MediaQuery.of(context).size.width;
                  return SizedBox(
                      height: height * 0.80,
                      width: width * 0.65,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 40, left: 25),
                              child: Text(
                                'Add an appointment',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 35,
                                ),
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(
                                    top: 40, left: 25, right: 25),
                                child: DropdownButtonHideUnderline(
                                    child: Theme(
                                        data: Theme.of(context).copyWith(
                                          primaryColor: Colors.blue.shade100,
                                        ),
                                        child: DropdownButton(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                          dropdownColor:
                                              Theme.of(context).backgroundColor,
                                          value: certificate_type,

                                          // Down Arrow Icon
                                          icon: const Icon(
                                              Icons.keyboard_arrow_down),

                                          // Array list of items
                                          items: certs.map((String items) {
                                            return DropdownMenuItem(
                                              value: items,
                                              child: Text(items),
                                            );
                                          }).toList(),
                                          // After selecting the desired option,it will
                                          // change button value to selected value
                                          onChanged: (String newValue) {
                                            setState(() {
                                              certificate_type = newValue;
                                            });
                                          },
                                        )))),
                            const Padding(
                              padding: EdgeInsets.only(top: 20, left: 25),
                              child: Text(
                                'Pick a date:',
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 20),
                                child: RaisedButton(
                                    child: Text(
                                        '${_vaccDate != null ? DateFormat("dd-MM-yyyy").format(_vaccDate ?? "") : 'Pick a Date'}'),
                                    color: Theme.of(context).backgroundColor,
                                    onPressed: () {
                                      showDatePicker(
                                        context: context,
                                        initialDate:
                                            _vaccDate ?? DateTime.now(),
                                        firstDate: DateTime(2020),
                                        lastDate: DateTime(2040),
                                      ).then((date) {
                                        setState(() {
                                          if (date != null) {
                                            _vaccDate = date;
                                          }
                                        });
                                      });
                                    })),
                            const Padding(
                              padding: EdgeInsets.only(top: 10, left: 25),
                              child: Text(
                                'Time of appointment:',
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 20),
                                child: RaisedButton(
                                    child: Text(
                                        '${_flightTime.hour}:${_flightTime.minute.toString().padLeft(2, '0')}'),
                                    color: Theme.of(context).backgroundColor,
                                    onPressed: () {
                                      showTimePicker(
                                        context: context,
                                        initialTime: _vaccTime,
                                      ).then((time) {
                                        setState(() {
                                          if (time != null) {
                                            _vaccTime = time;
                                          }
                                        });
                                      });
                                    })),
                            Padding(
                              padding: EdgeInsets.only(top: 20, left: 25),
                              child: Text(
                                _errortext,
                                textAlign: TextAlign.left,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 20),
                                child: RaisedButton(
                                    child: Text('OK'),
                                    color: Theme.of(context).backgroundColor,
                                    onPressed: () {
                                      if (_vaccDate != null) {
                                        setState(() {
                                          ok = true;
                                        });
                                        Navigator.pop(context);
                                      } else {
                                        setState(() {
                                          _errortext =
                                              "Please insert the date of the appointment.";
                                        });
                                      }
                                    }))
                          ],
                        ),
                      ));
                },
              ))));
  // Text on the flight confirmation popup
  String restrictions_text(Category country1, Category country2) {
    String s = "";
    if (country1.restrictions[1] == 'Airport: Vaccination AND PCR Test' ||
        country2.restrictions[1] == 'Airport: Vaccination AND PCR Test') {
      s = 'to get a PCR test';
      if (vaccinated == false) {
        s += ' and you will need to get vaccinated';
      }
    } else if (country1.restrictions[1] == 'Airport: Vaccination OR PCR Test' ||
        country2.restrictions[1] == 'Airport: Vaccination OR PCR Test') {
      if (vaccinated == false) {
        s += 'to get a PCR test';
      } else {
        s = 'your vaccination certificate';
      }
    } else if (country1.restrictions[1] == 'Airport: PCR Test' ||
        country2.restrictions[1] == 'Airport: PCR Test') {
      s += 'to get a PCR test';
    } else if (country1.restrictions[1] == 'Airport: Rapid Test' ||
        country2.restrictions[1] == 'Airport: Rapid Test') {
      s += 'to get a PCR test';
    } else {
      // For the highly unlikely event of no restrictions in both countries
      s = 'to have fun';
    }
    return s;
  }

  // Flight confirmation popup
  Future flight_popup(country1, country2) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            backgroundColor: Theme.of(context).backgroundColor,
            title: Text('Certificate added succesfully'),
            content: Text(
                "Have a nice flight to ${country2.region}. \nDon't forget ${restrictions_text(country1, country2)}."),
          ));
}

_AppointmentDataSource _getCalendarDataSource() {
  List<Appointments> appointments = Util.getMockAppointments();
  List<Appointments> newlist = new List.from(appointments)
    ..addAll(more_appointments);
  return _AppointmentDataSource(newlist);
}

class _AppointmentDataSource extends CalendarDataSource {
  _AppointmentDataSource(List<Appointments> source) {
    appointments = source;
  }
  @override
  DateTime getStartTime(int index) {
    return appointments[index].fromDate;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments[index].toDate;
  }

  @override
  bool isAllDay(int index) {
    return appointments[index].isAllDay;
  }

  @override
  String getSubject(int index) {
    return appointments[index].subject;
  }

  get(int index) {
    return appointments[index].appointment;
  }
}
