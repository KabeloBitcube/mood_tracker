import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mood_tracker/Home/home.dart';
import 'package:mood_tracker/Mode/mode.dart';
import 'package:mood_tracker/Mood%20Model/moodentry.dart';
import 'package:provider/provider.dart';

class StatsNotis extends StatelessWidget {
  //Mood entries and notifications parameters to pass to the Stats and notfications screen 
  final List<MoodEntry> moodEntries;
  final List<String> notifications;

  const StatsNotis({
    super.key,
    required this.moodEntries,
    required this.notifications,
  });

  @override
  Widget build(BuildContext context) {
    final modeController = Provider.of<ModeController>(context); //Mode provider controller that controls colors based on dark/light mode

    //Mood colors to map on chart
    final Map<String, Color> moodColorMap = {
      'Happy': Colors.amber,
      'Sad': Colors.lightBlue,
      'Angry': Colors.red,
      'Calm': Colors.lightGreen,
    };

    //Stores the number of times a mood was selected 
    final Map<String, int> moodCount = {};


    //Increment a mood count by 1 each time it is selected
    //Keep mood count at 0 if not selected
    for (var entry in moodEntries) {
      moodCount[entry.mood] = (moodCount[entry.mood] ?? 0) + 1;
    }


    //Setting pie chart data sections
    final sections = moodCount.entries.map((entry) {
      return PieChartSectionData(
        value: entry.value.toDouble(),
        color: moodColorMap[entry.key] ?? Colors.grey,
        showTitle: false,
        radius: 40,
      );
    }).toList();

    //Calculating highest mood selected
    int happyCounter = 0;
    int sadCounter = 0;
    int angryCounter = 0;
    int calmCounter = 0;
    int noMood = 0;

    for (var mood in moodEntries) {
      if (mood.mood == "Happy") {
        happyCounter++;
      }
      if (mood.mood == "Sad") {
        sadCounter++;
      }
      if (mood.mood == "Angry") {
        angryCounter++;
      }
      if (mood.mood == "Calm") {
        calmCounter++;
      }
      if (mood.mood.isEmpty) {
        noMood;
      }
    }

    String? highestValue;

    Map<Object?, Object?>? points = {
      "Happy": happyCounter,
      "Sad": sadCounter,
      "Angry": angryCounter,
      "Calm": calmCounter,
      "No Mood": noMood,
    };

    highestValue =
        points.entries.reduce((a, b) {
              final aValue = a.value;
              final bValue = b.value;

              if (aValue is! int) {
                return b;
              }

              if (bValue is! int) {
                return a;
              }

              return aValue > bValue ? a : b;
            }).key
            as String?;

    log('$highestValue');

    //Setting mood message based on highest mood selected
    Text getMoodMessage() {
      if (highestValue == "Happy") {
        return Text(
          'Seems like a good week!',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
        );
      }
      if (highestValue == "Sad") {
        return Text(
          'That sucks. Hope you feel better soon.',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
        );
      }
      if (highestValue == "Angry") {
        return Text(
          'Seems rough. Try taking a walk to relax.',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
        );
      }
      if (highestValue == "Calm") {
        return Text(
          'That\'s great! Keep enjoying yourself.',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
        );
      }
      if (highestValue == "No Mood") {
        return Text(
          'Start tracking your mood.',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
        );
      }

      return Text('Start tracking your mood!');
    }

    log("Notification length: ${notifications.length}");

    return Scaffold(
      appBar: AppBar(),
      body:
          SingleChildScrollView(
                child: Column(
                  children: [
                    Center(child: Text('Average mood this week')),
                    SizedBox(height: 80),
                    SizedBox(
                      height: 150,
                      width: 150,
                      //Pie chart
                      //Display blank pie chart if there are no mood entries
                      child: PieChart(
                        duration: const Duration(milliseconds: 750),
                        curve: Curves.easeInQuint,
                        moodCount.isNotEmpty
                            ? PieChartData(
                                centerSpaceRadius: 80,
                                sections: sections,
                              )
                            : PieChartData(
                                centerSpaceRadius: 80,
                                sections: [
                                  PieChartSectionData(
                                    value: 10,
                                    color: modeController.isDarkMode
                                        ? Colors.grey[900]
                                        : Colors.grey[350],
                                    showTitle: false,
                                    radius: 40,
                                  ),
                                ],
                              ),
                      ),
                    ),
                    SizedBox(height: 80),
                    //Mood color indicators 
                    Padding(
                      padding: const EdgeInsets.only(left: 40, right: 45),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Angry'),
                          Text('Sad'),
                          Text('Happy'),
                          Text('Calm'),
                        ],
                      ),
                    ),
                    SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.only(left: 35, right: 35),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 2,
                            width: 65,
                            decoration: BoxDecoration(color: Colors.red),
                          ),
                          Container(
                            height: 2,
                            width: 65,
                            decoration: BoxDecoration(color: Colors.lightBlue),
                          ),
                          Container(
                            height: 2,
                            width: 65,
                            decoration: BoxDecoration(color: Colors.amber),
                          ),
                          Container(
                            height: 2,
                            width: 65,
                            decoration: BoxDecoration(color: Colors.lightGreen),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    //Display mood message
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: getMoodMessage()
                          .animate()
                          .fade(duration: Duration(seconds: 2))
                          .scale(),
                    ),
                    //Notification container
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Container(
                        height: 250,
                        width: 500,
                        decoration: BoxDecoration(
                          color: modeController.isDarkMode
                              ? Colors.grey[900]
                              : Colors.grey[350],
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  'Notifications',
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            //Display notifications
                            //Display message if there are no notifications
                            SizedBox(
                              height: 100,
                              width: 350,
                              child: notifications.isEmpty
                                  ? Center(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          left: 15,
                                        ),
                                        child: const Text(
                                          'No notifications at the moment.',
                                          style: TextStyle(
                                            fontStyle: FontStyle.italic,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    )
                                  : ListView.builder(
                                      itemCount: notifications.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Container(
                                                height: 10,
                                                width: 10,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        100,
                                                      ),
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Text(
                                                notifications[index],
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontStyle: FontStyle.italic,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                            ),

                            SizedBox(height: 10),
                            //Delete notifications and display success snackbar
                            //Show no notifications snackbar if there are no notifications to delte
                            Center(
                              child: notifications.isEmpty
                                  ? IconButton(
                                      onPressed: () {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text('No notifications.'),
                                          ),
                                        );
                                      },
                                      icon: Icon(Icons.delete_outline),
                                    )
                                  : IconButton(
                                      onPressed: () {
                                        notifications.clear();
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Notifications deleted.',
                                            ),
                                          ),
                                        );
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => HomeScreen(
                                              notificationCount: 0,
                                            ),
                                          ),
                                        );
                                      },
                                      icon: Icon(Icons.delete_outline),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
              .animate()
              .fadeIn(duration: 200.ms)
              .slideX(begin: 0.2, duration: 1000.ms, curve: Curves.easeOut), //Right fade in animation
    );
  }
}
