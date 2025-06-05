import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mood_tracker/Mode/mode.dart';
import 'package:mood_tracker/Mood%20Model/moodentry.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  //Mood Entries list to pass to the calendar screen 
  final List<MoodEntry> moodEntries;

  const CalendarScreen({super.key, required this.moodEntries});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _focusedDay = DateTime.now(); //Sets focused day on calendar
  DateTime? _selectedDay; //Sets selected day on calendar
  List<MoodEntry> _selectedMoods = []; //List to display moods on the selected day

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay; //Set focused day as the day selected 
    _updateMoodsForSelectedDay(_focusedDay); //Call function to display mood entries on the selected day
  }


  //Function to display mood entries on the selected day
  void _updateMoodsForSelectedDay(DateTime day) {
    final dateOnly = DateTime(day.year, day.month, day.day);

    setState(() {
      _selectedMoods = widget.moodEntries
          .where(
            (entry) =>
                entry.date.year == dateOnly.year &&
                entry.date.month == dateOnly.month &&
                entry.date.day == dateOnly.day,
          )
          .toList();
    });
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          //Calendar
          TableCalendar(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
              _updateMoodsForSelectedDay(selectedDay);
            },
            headerStyle: HeaderStyle(
              titleCentered: true,
              formatButtonVisible: false,
            ),
          ),
          const SizedBox(height: 20),
          //Display mood entries or show a message if there are no mood entries on the selected day 
          Expanded(
            child: _selectedMoods.isEmpty
                ? Center(child: const Text('No mood entries for this day.'))
                : ListView.builder(
                    itemCount: _selectedMoods.length,
                    itemBuilder: (context, index) {
                      final mood = _selectedMoods[index]; 
                      final String? time;

                      //If statement to set time of day based on time of day value 
                      if (mood.timeOfDay == 1) {
                        time = "Morning";
                      } else if (mood.timeOfDay == 2) {
                        time = "Afternoon";
                      } else {
                        time = "Night";
                      }

                      //Color function to set card color based on mood parameter
                      Color getCardColor(String mood) {
                        if (mood == "Sad") {
                          return Colors.lightBlue;
                        }
                        if (mood == "Happy") {
                          return Colors.amber;
                        }
                        if (mood == "Angry") {
                          return Colors.red;
                        }
                        if (mood == "Calm") {
                          return Colors.lightGreen;
                        }
                        return Colors.grey;
                      }

                      //String function to set card mood image based on mood parameter
                      String getMoodImage(String mood) {
                        if (mood == "Sad") {
                          return 'assets/images/Sad.webp';
                        }
                        if (mood == "Happy") {
                          return 'assets/images/Happy.webp';
                        }
                        if (mood == "Angry") {
                          return 'assets/images/Angry.png';
                        }
                        if (mood == "Calm") {
                          return 'assets/images/Calm.webp';
                        }
                        return 'assets/images/Happy.webp';
                      }

                      final modeController = Provider.of<ModeController>(context); //Mood provider controller that controls colors based on dark/light mode

                      //Returns card with mood entry details
                      return Card(
                        color: getCardColor(mood.mood),
                        margin: EdgeInsets.all(8),
                        child: ListTile(
                          title: Text(time, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: modeController.isDarkMode ? Colors.white : Colors.black),),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(mood.reason, style: TextStyle(fontWeight: FontWeight.bold, color: modeController.isDarkMode ? Colors.white : Colors.black,),),
                              Text(mood.description, style: TextStyle(fontWeight: FontWeight.bold, color: modeController.isDarkMode ? Colors.white : Colors.black,)),
                            ],
                          ),
                          trailing: Image.asset(getMoodImage(mood.mood)),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ).animate()
            .fadeIn(duration: 200.ms)
            .slideX(begin: 0.2, duration: 1000.ms, curve: Curves.easeOut), //Right fade in effect 
    );
  }
}
