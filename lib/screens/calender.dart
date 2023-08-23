import 'package:aire/components/weekDisplay.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../data/constants.dart';

class Calender extends StatefulWidget {
  const Calender({Key? key}) : super(key: key);

  @override
  State<Calender> createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  bool _isChecked1 = false;
  bool _isChecked2 = false;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
          drawerScrimColor: Constants.dark,
          backgroundColor: Colors.white,
          body: Column(
            children: [
              Material(
                elevation: 10,
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                child: Container(
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      color: Color(0xffF3D34A),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20))),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15, 50, 15, 0),
                            child: GestureDetector(
                                onTap: () => {Navigator.pop(context)},
                                child: Image.asset(
                                  'assets/nextrev.png',
                                  height: 30,
                                )),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                            child: Text(
                              '${Constants.months[DateTime.now().month - 1]}, ${DateTime.now().year}',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 35,
                                  fontWeight: FontWeight.w900),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      const WeekDisplay()
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              const Flexible(
                  child: Text(
                "Tasks for today(Still in development)",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              )),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.red, width: 3)),
                child: Row(
                  children: [
                    Checkbox(
                      value: _isChecked1,
                      activeColor: Colors.red,
                      onChanged: (bool? value) {
                        setState(() {
                          _isChecked1 = value!;
                        });
                      },
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      'Unit 1.1 video',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.red),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.red, width: 3)),
                child: Row(
                  children: [
                    Checkbox(
                      value: _isChecked2,
                      activeColor: Colors.red,
                      onChanged: (bool? value) {
                        setState(() {
                          _isChecked2 = value!;
                        });
                      },
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      'Revise notes',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.red),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
