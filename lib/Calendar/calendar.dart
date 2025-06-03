import 'package:flutter/material.dart';
import 'package:mood_tracker/Mood%20Model/moodentry.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  final List<MoodEntry> moodEntries;

  const CalendarScreen({super.key, required this.moodEntries});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  List<MoodEntry> _selectedMoods = [];

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _updateMoodsForSelectedDay(_focusedDay);
  }

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
          const SizedBox(height: 20,),
          Expanded(
            child: _selectedMoods.isEmpty 
            ? Center(
              child: const Text('No mood entries for this day.'),
            ) : ListView.builder(
              itemCount: _selectedMoods.length,
              itemBuilder: (context, index) {
                final mood = _selectedMoods[index];
                final String? time;

                if (mood.timeOfDay == 1){
                  time = "Morning";
                }
                else if (mood.timeOfDay == 2){
                  time = "Afternoon";
                }
                else{
                  time = "Night";
                }

                return Card(
                  margin: EdgeInsets.all(8),
                  child: ListTile(
                    title: Text('Mood: ${mood.mood} - $time'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Reason: ${mood.reason}'),
                        Text('Description: ${mood.description}')
                      ],
                    ),
                  ),
                );
              },
            ),
          )
          // Container(
          //   height: 494.2,
          //   width: MediaQuery.of(context).size.width,
          //   decoration: BoxDecoration(
          //     color: Colors.blueGrey,
          //     borderRadius: BorderRadius.only(
          //       topLeft: Radius.circular(50),
          //       topRight: Radius.circular(50),
          //     ),
          //   ),
          //   child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.center,
          //       children: [
          //         Padding(
          //           padding: const EdgeInsets.only(
          //             top: 20,
          //             right: 150,
          //             left: 150,
          //           ),
          //           child: Divider(thickness: 2),
          //         ),
          //         Text(
          //           'Tuesday, 2 June',
          //           style: TextStyle(color: Colors.white),
          //         ),
          //         SizedBox(height: 20),
          //         Padding(
          //           padding: const EdgeInsets.only(
          //             left: 30,
          //             right: 45,
          //             top: 10,
          //           ),
          //           child: Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             children: [
          //               Text('Morning', style: TextStyle(color: Colors.white)),
          //               Text(
          //                 'Afternoon',
          //                 style: TextStyle(color: Colors.white),
          //               ),
          //               Text('Night', style: TextStyle(color: Colors.white)),
          //             ],
          //           ),
          //         ),
          //         Padding(
          //           padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
          //           child: Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             children: [
          //               Container(
          //                 height: 30,
          //                 width: 100,
          //                 decoration: BoxDecoration(
          //                   color: Colors.lightBlue,
          //                   borderRadius: BorderRadius.circular(200),
          //                 ),
          //                 child: Center(
          //                   child: Image.asset('assets/images/Sad.webp'),
          //                 ),
          //               ),
          //               Container(
          //                 height: 30,
          //                 width: 100,
          //                 decoration: BoxDecoration(
          //                   color: Colors.amber,
          //                   borderRadius: BorderRadius.circular(200),
          //                 ),
          //                 child: Center(
          //                   child: Image.asset('assets/images/Happy.webp'),
          //                 ),
          //               ),
          //               Container(
          //                 height: 30,
          //                 width: 100,
          //                 decoration: BoxDecoration(
          //                   color: Colors.red,
          //                   borderRadius: BorderRadius.circular(200),
          //                 ),
          //                 child: Center(
          //                   child: Image.asset('assets/images/Angry.png'),
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //         SizedBox(height: 5),
          //         Divider(thickness: 1),
          //         SizedBox(height: 10),
          //         Row(
          //           mainAxisAlignment: MainAxisAlignment.start,
          //           children: [
          //             Text(
          //               'Reason',
          //               style: TextStyle(
          //                 color: Colors.white,
          //                 fontSize: 20,
          //                 fontWeight: FontWeight.bold,
          //               ),
          //             ),
          //           ],
          //         ),
          //         TextField(
          //           keyboardType: TextInputType.text,
          //           decoration: InputDecoration(
          //             hintStyle: TextStyle(fontSize: 16),
          //             border: OutlineInputBorder(
          //               borderRadius: BorderRadius.circular(8),
          //               borderSide: BorderSide(
          //                 width: 0,
          //                 style: BorderStyle.none,
          //               ),
          //             ),
          //             filled: true,
          //             contentPadding: EdgeInsets.all(16),
          //             fillColor: Colors.black54,
          //           ),
          //         ),
          //         SizedBox(height: 20,),
          //         Row(
          //           mainAxisAlignment: MainAxisAlignment.start,
          //           children: [
          //             Text(
          //               'Description',
          //               style: TextStyle(
          //                 color: Colors.white,
          //                 fontSize: 20,
          //                 fontWeight: FontWeight.bold,
          //               ),
          //             ),
          //           ],
          //         ),
          //         TextField(
          //           keyboardType: TextInputType.text,
          //           maxLines: 4,
          //           decoration: InputDecoration(
          //             hintStyle: TextStyle(fontSize: 16),
          //             border: OutlineInputBorder(
          //               borderRadius: BorderRadius.circular(8),
          //               borderSide: BorderSide(
          //                 width: 0,
          //                 style: BorderStyle.none,
          //               ),
          //             ),
          //             filled: true,
          //             contentPadding: EdgeInsets.all(16),
          //             fillColor: Colors.black54,
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
