import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            // Light/Dark mode toggle
          },
          icon: Icon(Icons.dark_mode_outlined),
        ),
        title: Text(getCurrentDate(), style: TextStyle(fontSize: 15),),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Icon(Icons.calendar_month_outlined),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Center(child: Text('Home!'))],
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
