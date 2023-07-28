import 'package:aire/data/constants.dart';
import 'package:flutter/material.dart';

class WeekDisplay extends StatefulWidget {
  const WeekDisplay({Key? key}) : super(key: key);

  @override
  State<WeekDisplay> createState() => _WeekDisplayState();
}

class _WeekDisplayState extends State<WeekDisplay> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          for (var i = 1; i < 8; i++)
            DateTime.now().weekday != i
                ? Column(
                    children: [
                      Text(
                        Constants.weekdays[i - 1],
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        '${Constants.dayCalculator(DateTime.now(), i)}',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  )
                : Container(
                    decoration: BoxDecoration(
                        color: const Color(0xff3A49F9).withOpacity(0.3),
                        borderRadius: const BorderRadius.all(Radius.elliptical(250, 360))
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Column(
                        children: [
                          Text(
                            Constants.weekdays[i - 1],
                            style: const TextStyle(
                                color: Color(0xff9C2CF3),
                                fontSize: 15,
                                fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            '${Constants.dayCalculator(DateTime.now(), i)}',
                            style: const TextStyle(
                                color: Color(0xff9C2CF3),
                                fontSize: 15,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ),
        ],
      ),
    );
  }
}
