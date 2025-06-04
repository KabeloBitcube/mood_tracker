import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mood_tracker/Calendar/calendar.dart';
import 'package:mood_tracker/Mode/mode.dart';
import 'package:mood_tracker/Mood%20Model/moodentry.dart';
import 'package:mood_tracker/Notifications/noti_service.dart';
import 'package:mood_tracker/Stats%20&%20Notis/stats_notis.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  final int notificationCount;

  const HomeScreen({super.key, required this.notificationCount});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int notificationCount = 0;

  String? _selectedMood;
  int? _selectedTime = 1;
  String? _selectedReason;
  final _descriptionController = TextEditingController();
  final List<MoodEntry> _moods = [];

  void _onSave() {
    if (_selectedMood == null ||
        _selectedReason == null ||
        _descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in al fields and select a mood')),
      );
      return;
    }

    final moodEntry = MoodEntry(
      mood: _selectedMood!,
      reason: _selectedReason!,
      description: _descriptionController.text,
      timeOfDay: _selectedTime,
      date: DateTime.now(),
    );

    setState(() {
      _moods.add(moodEntry);
    });

    CalendarScreen(moodEntries: _moods);
  }

  @override
  Widget build(BuildContext context) {
    final modeController = Provider.of<ModeController>(context);

    Future<void> showMyDialog() async {
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(child: const Text('Enter Time of Day')),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 50, right: 50),
                    child: Divider(color: Colors.black),
                  ),
                  SizedBox(height: 10),
                  StatefulBuilder(
                    builder: (context, setState) => Column(
                      children: [
                        ListTile(
                          title: const Text('Morning'),
                          leading: Radio<int>(
                            value: 1,
                            groupValue: _selectedTime,
                            onChanged: (value) {
                              setState(() {
                                _selectedTime = value;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: const Text('Afternoon'),
                          leading: Radio<int>(
                            value: 2,
                            groupValue: _selectedTime,
                            onChanged: (value) {
                              setState(() {
                                _selectedTime = value;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: const Text('Night'),
                          leading: Radio<int>(
                            value: 3,
                            groupValue: _selectedTime,
                            onChanged: (value) {
                              setState(() {
                                _selectedTime = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Save'),
                onPressed: () {
                  _onSave();

                  if (_selectedMood != null &&
                      _selectedReason != null &&
                      _descriptionController.text.isNotEmpty &&
                      _selectedTime != null) {
                    log('Selected mood: $_selectedMood');
                    log('Selected reason: $_selectedReason');
                    log('Description: ${_descriptionController.text}');
                    log('Selected time: $_selectedTime');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Mood added to calendar')),
                    );
                    if (_selectedTime == 1) {
                      NotiService().initNotification().then((_) {
                        Future.delayed(const Duration(seconds: 5), () {
                          NotiService().showNotification(
                            title: "Reminder",
                            body:
                                "Remember to track your mood in the afternoon.",
                          );
                        });
                      });
                    }
                    if (_selectedTime == 2) {
                      NotiService().initNotification().then((_) {
                        Future.delayed(const Duration(seconds: 5), () {
                          NotiService().showNotification(
                            title: "Reminder",
                            body:
                                "Remember to track your mood tonight.",
                          );
                        });
                      });
                    }
                    if (_selectedTime == 3) {
                      NotiService().initNotification().then((_) {
                        Future.delayed(const Duration(seconds: 5), () {
                          NotiService().showNotification(
                            title: "Reminder",
                            body:
                                "Remember to track your mood in the morning.",
                          );
                        });
                      });
                    }
                    notificationCount++;
                    _descriptionController.clear();
                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            modeController.toggleMode();
          },
          icon: Icon(
            modeController.isDarkMode
                ? Icons.light_mode_outlined
                : Icons.dark_mode_outlined,
          ),
        ),
        title: Text(getCurrentDate(), style: TextStyle(fontSize: 15)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {
                // context.push('/calendar');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CalendarScreen(moodEntries: _moods),
                  ),
                );
              },
              icon: Icon(Icons.calendar_month_outlined),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                'How Are You Feeling Today?',
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  wordSpacing: 5,
                ),
              ),
              const SizedBox(height: 10),
              CarouselSlider(
                options: CarouselOptions(height: 250.0),
                items: [
                  GestureDetector(
                    onTap: () {
                      _selectedMood = "Happy";
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(250),
                      ),
                      child: Center(
                        child: Image.asset(
                          'assets/images/Happy.webp',
                          width: 170,
                          height: 170,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _selectedMood = "Sad";
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      decoration: BoxDecoration(
                        color: Colors.lightBlueAccent,
                        borderRadius: BorderRadius.circular(250),
                      ),
                      child: Center(
                        child: Image.asset(
                          'assets/images/Sad.webp',
                          width: 170,
                          height: 170,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _selectedMood = "Angry";
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(250),
                      ),
                      child: Center(
                        child: Image.asset(
                          'assets/images/Angry.png',
                          width: 150,
                          height: 150,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _selectedMood = "Calm";
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(250),
                      ),
                      child: Center(
                        child: Image.asset(
                          'assets/images/Calm.webp',
                          width: 160,
                          height: 160,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 35),
              const Text('What\'s the reason?'),
              const SizedBox(height: 20),
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _selectedReason = "Work";
                      },
                      child: Container(
                        height: 30,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(200),
                        ),
                        child: Center(
                          child: const Text(
                            'Work',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    GestureDetector(
                      onTap: () {
                        _selectedReason = "School";
                      },
                      child: Container(
                        height: 30,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(200),
                        ),
                        child: Center(
                          child: const Text(
                            'School',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    GestureDetector(
                      onTap: () {
                        _selectedReason = "Friends";
                      },
                      child: Container(
                        height: 30,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(200),
                        ),
                        child: Center(
                          child: const Text(
                            'Friends',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    GestureDetector(
                      onTap: () {
                        _selectedReason = "Family";
                      },
                      child: Container(
                        height: 30,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(200),
                        ),
                        child: Center(
                          child: const Text(
                            'Family',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    GestureDetector(
                      onTap: () {
                        _selectedReason = "Hobby";
                      },
                      child: Container(
                        height: 30,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(200),
                        ),
                        child: Center(
                          child: const Text(
                            'Hobby',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    GestureDetector(
                      onTap: () {
                        _selectedReason = "Health";
                      },
                      child: Container(
                        height: 30,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(200),
                        ),
                        child: Center(
                          child: const Text(
                            'Health',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    GestureDetector(
                      onTap: () {
                        _selectedReason = "Relationship";
                      },
                      child: Container(
                        height: 30,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(200),
                        ),
                        child: Center(
                          child: const Text(
                            'Relationship',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    GestureDetector(
                      onTap: () {
                        _selectedReason = "Money";
                      },
                      child: Container(
                        height: 30,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(200),
                        ),
                        child: Center(
                          child: const Text(
                            'Money',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              const Text('Wanna write about it?'),
              const SizedBox(height: 20),
              TextField(
                controller: _descriptionController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: 'Describe how you feel...',
                  hintStyle: TextStyle(fontSize: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(width: 0, style: BorderStyle.none),
                  ),
                  filled: true,
                  contentPadding: EdgeInsets.all(16),
                  fillColor: Colors.grey[450],
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  showMyDialog();
                },
                child: Container(
                  height: 30,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(
                    child: const Text(
                      'Add to calendar',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(left: 50, right: 50),
                child: const Divider(color: Color.fromARGB(255, 7, 7, 7)),
              ),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  GestureDetector(
                    onTap: () {
                      // context.push('/stats_notis');
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => StatsNotis(moodEntries: _moods,)),
                      );
                    },
                    child: Image.asset(
                      'assets/images/Moods.webp',
                      height: 50,
                      width: 50,
                    ),
                  ),
                  Positioned(
                    top: 35,
                    left: 30,
                    child: Container(
                      height: 15,
                      width: 15,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Center(
                        child: Text(
                          '$notificationCount',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

getCurrentDate() {
  var date = DateTime.now().toString();

  var dateParse = DateTime.parse(date);

  //Day
  String day = DateFormat('EEEE').format(DateTime.now());

  //Months
  String? month;

  if (dateParse.month == 5) {
    month = "May";
  }

  if (dateParse.month == 6) {
    month = "June";
  }

  var formattedDate = "$day, $month ${dateParse.day}";

  return formattedDate;
}
