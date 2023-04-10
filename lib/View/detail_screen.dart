import 'package:covid_tracker_app/world_states.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  String image, name;
  int totalCases,
      totalDeaths,
      totalRecovered,
      active,
      critical,
      todayRecovered,
      test;

  DetailScreen(
      {super.key,
      required this.image,
      required this.name,
      required this.totalCases,
      required this.totalDeaths,
      required this.totalRecovered,
      required this.active,
      required this.critical,
      required this.todayRecovered,
      required this.test});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
             Padding(
               padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.067),
               child: Card(
                 child: Column(
                   children: [
                     ReuseRow(title: 'Cases', value: widget.totalCases.toString()),
                     ReuseRow(title: 'Deaths', value: widget.totalDeaths.toString()),
                     ReuseRow(title: 'Recovered', value: widget.totalRecovered.toString()),
                     ReuseRow(title: 'Critical', value: widget.critical.toString()),
                     ReuseRow(title: 'TodayRecovered', value: widget.todayRecovered.toString()),
                     ReuseRow(title: 'Active', value: widget.active.toString()),
                     ReuseRow(title: 'Test', value: widget.test.toString()),
                   ],
                 ),
               ),
             ),
              CircleAvatar(
                radius:  50,
                backgroundImage: NetworkImage(widget.image),
              )
            ],
          )
        ],
      ),
    );
  }
}
