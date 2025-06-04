import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mood_tracker/Mode/mode.dart';
import 'package:mood_tracker/Mood%20Model/moodentry.dart';
import 'package:provider/provider.dart';

class StatsNotis extends StatelessWidget {
  final List<MoodEntry> moodEntries;
  final List<String> notifications;

  const StatsNotis({
    super.key,
    required this.moodEntries,
    required this.notifications,
  });

  @override
  Widget build(BuildContext context) {
    final modeController = Provider.of<ModeController>(context);

    final Map<String, Color> moodColorMap = {
      'Happy': Colors.amber,
      'Sad': Colors.lightBlue,
      'Angry': Colors.red,
      'Calm': Colors.lightGreen,
    };

    final Map<String, int> moodCount = {};

    for (var entry in moodEntries) {
      moodCount[entry.mood] = (moodCount[entry.mood] ?? 0) + 1;
    }

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

    //Mood message
    Text getMoodMessage() {
      if (highestValue == "Happy") {
        return Text(
          'Seems like a good week!',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
        );
      }
      if (highestValue == "Sad") {
        return Text(
          'I\'m sorry. You\'ll have a better week next time.',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
        );
      }
      if (highestValue == "Angry") {
        return Text(
          'Seems rough. Try taking a walk to calm down.',
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

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(child: Text('Average mood this week')),
            SizedBox(height: 80),
            SizedBox(
              height: 150,
              width: 150,
              child: PieChart(
                duration: const Duration(milliseconds: 750),
                curve: Curves.easeInQuint,
                moodCount.isNotEmpty
                    ? PieChartData(centerSpaceRadius: 80, sections: sections)
                    : PieChartData(
                        centerSpaceRadius: 80,
                        sections: [
                          PieChartSectionData(
                            value: 10,
                            color: Colors.grey[350],
                            showTitle: false,
                            radius: 40,
                          ),
                        ],
                      ),
              ),
            ),
            SizedBox(height: 80),
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
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: getMoodMessage(),
            ),
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
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Notifications',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    SizedBox(height: 20),
                    Expanded(
                      child: notifications.isEmpty
                          ? Center(
                              child: const Text(
                                'No notifications',
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontSize: 12,
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
                                          borderRadius: BorderRadius.circular(
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

                    SizedBox(height: 100),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.delete_outline),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
