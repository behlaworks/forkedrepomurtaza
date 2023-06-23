import 'package:flutter/material.dart';

import '../data/constants.dart';

class StartTracking extends StatefulWidget {
  const StartTracking({Key? key}) : super(key: key);

  @override
  State<StartTracking> createState() => _StartTrackingState();
}

class _StartTrackingState extends State<StartTracking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 50, 0, 0),
              child: GestureDetector(
                onTap: () => {Navigator.pop(context)},
                child: Container(
                  height: 42,
                  width: 42,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Constants.grey),
                  child: const Center(
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                      size: 15,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height*0.15,
            ),
            const Text(
              "Let's schedule you academic year!",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.w900),
            )
          ],
        ),
      ]),
    );
  }
}
