import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class StatsNotis extends StatelessWidget {
  const StatsNotis({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Center(child: Text('Average mood this week')),
          SizedBox(height: 80,),
          SizedBox(
            height: 150,
            width: 150,
            child: PieChart(
              duration: const Duration(milliseconds: 750),
              curve: Curves.easeInQuint,
              PieChartData(
                centerSpaceRadius: 85.0,
                sections: [
                  PieChartSectionData(
                    value: 5,
                    color: Colors.red,
                    showTitle: false,
                    radius: 42,
                  ),
                  PieChartSectionData(
                    value: 4,
                    color: Colors.lightBlue,
                    showTitle: false,
                    radius: 42,
                  ),
                  PieChartSectionData(
                    value: 3,
                    color: Colors.yellow,
                    showTitle: false,
                    radius: 42,
                  ),
                  PieChartSectionData(
                    value: 10,
                    color: Colors.green,
                    showTitle: false,
                    radius: 42,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 80,),
          Padding(
            padding: const EdgeInsets.only(left: 40, right: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Angry'),
                Text('Sad'),
                Text('Happy'),
                Text('Positive'),
              ],
            ),
          ),
          SizedBox(height: 5,),
          Padding(
            padding: const EdgeInsets.only(left: 35, right: 35),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 2,
                  width: 65,
                  decoration: BoxDecoration(
                    color: Colors.red
                  ),
                ),
                Container(
                  height: 2,
                  width: 65,
                  decoration: BoxDecoration(
                    color: Colors.lightBlue
                  ),
                ),
                Container(
                  height: 2,
                  width: 65,
                  decoration: BoxDecoration(
                    color: Colors.amber
                  ),
                ),
                Container(
                  height: 2,
                  width: 65,
                  decoration: BoxDecoration(
                    color: Colors.lightGreen
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
