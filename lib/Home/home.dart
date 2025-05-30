import 'package:carousel_slider/carousel_slider.dart';
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
        title: Text(getCurrentDate(), style: TextStyle(fontSize: 15)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Icon(Icons.calendar_month_outlined),
          ),
        ],
      ),
      body: Padding(
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
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  decoration: BoxDecoration(
                    color: Colors.lightBlueAccent,
                    borderRadius: BorderRadius.circular(250),
                  ),
                   child: Center(
                    child: Image.asset('assets/images/Sad.webp', width: 150, height: 150,),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(250),
                  ),
                   child: Center(
                    child: Image.asset('assets/images/Angry.png', width: 150, height: 150,),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(250),
                  ),
                  child: Center(
                    child: Image.asset('assets/images/Happy.webp', width: 150, height: 150,),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(250),
                  ),
                   child: Center(
                    child: Image.asset('assets/images/Positive.webp', width: 200, height: 200,),
                  ),
                ),
              ],
            ),
          ],
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
