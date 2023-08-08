import 'dart:async';

import 'package:flutter/material.dart';

class MCQTest extends StatefulWidget {
  const MCQTest({Key? key}) : super(key: key);

  @override
  State<MCQTest> createState() => _MCQTestState();
}

class _MCQTestState extends State<MCQTest> {
  int remainingTime = 15 * 60; // 30 minutes in seconds
  late Timer timer;
  bool isTimerRunning = false;

  @override
  void initState() {
    super.initState();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (remainingTime > 0) {
          remainingTime--;
        } else {
          stopTimer();
        }
      });
    });
    setState(() {
      isTimerRunning = true;
    });

  }

  void stopTimer() {
    timer.cancel();
    isTimerRunning = false;
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  String formatTime(int timeInSeconds) {
    int minutes = timeInSeconds ~/ 60;
    int seconds = timeInSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2f3f7),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 14, 0, 0),
              child: Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Image.asset(
                        'assets/nextrev.png',
                        height: 30,
                      )),
                  const SizedBox(
                    width: 15,
                  ),
                  const Text(
                    "MCQs Test",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              height: 55,
              width: MediaQuery.of(context).size.width * 0.76,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.red, width: 2)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/timer.png',
                          height: 25,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        const Text(
                          'Timer',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 22),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                    child: Text(
                      formatTime(remainingTime),
                      style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                          fontSize: 22),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            !isTimerRunning?
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.red, width: 2),
                  borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Image.asset(
                    "assets/exam.png",
                    height: 160,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Grab a pen and a paper!",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                        "You have 15 minutes to solve all these questions to pass this unit. Good Luck!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 17)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: (){
                      startTimer();
                    },
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.6,
                      decoration: BoxDecoration(
                          color: const Color(0xffECCFC3),
                          border: Border.all(width: 2, color: Colors.black),
                          borderRadius: BorderRadius.circular(8)),
                      child: const Center(
                        child: Text(
                          "Start",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ): const SizedBox()
          ],
        ),
      ),
    );
  }
}
