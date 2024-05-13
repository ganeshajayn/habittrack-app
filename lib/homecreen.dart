import 'dart:async';

import 'package:flutter/material.dart';
import 'package:habittracker/utlitities/habittiles.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
//overall habitsummary
  List habitlist = [
    ['Exercise', false, 0, 1],
    ['Read', false, 0, 3],
    ['Meditate ', false, 0, 4],
    ['Code', false, 0, 2],
    ['writing', false, 0, 4],
  ];
  void habitstarted(int index) {
    var starttime = DateTime.now();
    // print(starttime);
    int elapsedtime = habitlist[index][2];

    //habit started or stopped
    setState(() {
      habitlist[index][1] = !habitlist[index][1];
    });
    if (habitlist[index][1]) {
      Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          if (!habitlist[index][1]) {
            timer.cancel();
          }
          // calculate the time comparing
          var currenttime = DateTime.now();
          habitlist[index][2] = elapsedtime +
              currenttime.second -
              starttime.second +
              60 * (currenttime.minute - starttime.minute) +
              60 * 60 * (currenttime.hour - starttime.hour);
        });
      });
    }
  }

  void settingstarted(BuildContext context, int index) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Setting for " + habitlist[index][0]),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          backgroundColor: Colors.grey[900],
          title: const Text("Consistency breeds excellence."),
          centerTitle: false,
          elevation: 30,
        ),
        body: ListView.builder(
            itemCount: habitlist.length,
            itemBuilder: (context, index) {
              return Habittiles(
                  habitname: habitlist[index][0],
                  ontap: () {
                    habitstarted(index);
                  },
                  settingtapped: () {
                    settingstarted(context, index); // Pass the context here
                  },
                  timespent: habitlist[index][2],
                  timegoal: habitlist[index][3],
                  habitstareeted: habitlist[index][1]);
            }));
  }
}
