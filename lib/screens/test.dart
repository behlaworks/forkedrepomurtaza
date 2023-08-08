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
        child: SingleChildScrollView(
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
              Column(
                children: [
                  !isTimerRunning
                      ? Container(
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
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 17),
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
                                onTap: () {
                                  startTimer();
                                },
                                child: Container(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      color: const Color(0xffECCFC3),
                                      border:
                                          Border.all(width: 2, color: Colors.black),
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
                        )
                      : const Column(
                        children: [
                          McqBox(
                              question:
                                  "Which of the following is a vector quantity?",
                              options: ["Force", 'Pressure', 'Energy', 'None'],
                              num: 1),
                          McqBox(
                              question:
                              "Which of the following is correct?",
                              options: ["Wrong", 'What?', 'Correct', 'Right'],
                              num: 2),
                          McqBox(
                              question:
                              "Which of the following is correct?",
                              options: ["Wrong", 'What?', 'Correct', 'Right'],
                              num: 3),
                          McqBox(
                              question:
                              "Which of the following is correct?",
                              options: ["Wrong", 'What?', 'Correct', 'Right'],
                              num: 4),
                        ],
                      ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class McqBox extends StatefulWidget {
  final int num;
  final String question;
  final List<String> options;

  const McqBox(
      {Key? key,
      required this.question,
      required this.options,
      required this.num})
      : super(key: key);

  @override
  State<McqBox> createState() => _McqBoxState();
}

class _McqBoxState extends State<McqBox> {
  int selected = 4;
  @override
  Widget build(BuildContext context) {
    List<Color> colors = [const Color(0xffcce0f6), const Color(0xfff7dbc5)];
    List<String> letters = ['A', 'B', 'C', 'D'];
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
            color: widget.num.isEven ? colors[1] : colors[0],
            borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 15, 8, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Q${widget.num})",
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  Flexible(
                    child: Text(
                      widget.question,
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                  const Icon(
                    Icons.bookmark,
                    size: 25,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            for (var i = 0; i < 4; i++)
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: GestureDetector(
                  onTap: (){
                    print(selected.toString());
                    setState(() {
                      selected = i;
                    });
                  },
                  child: Container(
                    constraints: const BoxConstraints(
                      minHeight: 45, // Set your desired minimum height here
                    ),
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: Row(
                      children: [
                        Stack(
                          children: [
                            Row(
                              children: [
                                const SizedBox(
                                  width: 15,
                                ),
                                Material(
                                  borderRadius:
                                  BorderRadius.circular(8),
                                  elevation: 4,
                                  child: Container(
                                    constraints: const BoxConstraints(
                                      minHeight: 45, // Set your desired minimum height here
                                    ),
                                    width: MediaQuery.of(context).size.width *
                                        0.8,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(8),
                                        border: Border.all(
                                            color: selected == i? Colors.black: Colors.transparent,
                                            width: 2)),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          25, 8, 8, 8),
                                      child: Text(
                                        widget.options[i],
                                        maxLines: null,
                                        // Allow the text to span multiple lines
                                        overflow: TextOverflow.clip,
                                        // Clip overflowing text
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xfff2f3f7)),
                                  child: Center(
                                    child: Text(
                                      letters[i],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
