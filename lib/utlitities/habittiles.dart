import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Habittiles extends StatelessWidget {
  final String habitname;
  final VoidCallback ontap;
  final VoidCallback settingtapped;
  final int timespent;
  final int timegoal;
  final bool habitstareeted;
  const Habittiles(
      {super.key,
      required this.habitname,
      required this.ontap,
      required this.settingtapped,
      required this.timespent,
      required this.timegoal,
      required this.habitstareeted});
//convert seconds into minisec
  String formataminsec(int totalseconds) {
    String secs = (totalseconds % 60).toString();
    String min = (totalseconds / 60).toStringAsFixed(5);
    if (secs.length == 1) {
      secs = "0" + secs;
    }
    if (min[1] == ".") {
      min = min.substring(0, 1);
    }
    return min + " :" + secs;
  }

  double percentagecompleted() {
    return timespent / (timegoal * 60);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[200], borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: ontap,
                  child: SizedBox(
                    height: 60,
                    width: 60,
                    child: Stack(
                      children: [
                        //progress circle
                        Padding(
                          padding: const EdgeInsets.only(left: 3),
                          child: CircularPercentIndicator(
                            radius: 30,
                            percent: percentagecompleted() < 1
                                ? percentagecompleted()
                                : 1,
                            progressColor: percentagecompleted() > 0.5
                                ? (percentagecompleted() > 0.75
                                    ? Colors.green
                                    : Colors.orange)
                                : Colors.red,
                          ),
                        ),
                        //play pause button
                        Center(
                          child: Icon(
                              habitstareeted ? Icons.pause : Icons.play_arrow),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //habitname
                    Text(
                      habitname,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    //time
                    Text(
                      formataminsec(timespent) +
                          ' / ' +
                          timegoal.toString() +
                          "  = " +
                          (percentagecompleted() * 100).toStringAsFixed(0) +
                          "%",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            GestureDetector(
              child: Icon(Icons.settings),
              onTap: settingtapped,
            )
          ],
        ),
      ),
    );
  }
}
