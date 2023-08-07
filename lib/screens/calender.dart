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
                              child: Image.asset('assets/nextrev.png', height: 30,)
                            ),
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
                                  fontWeight: FontWeight.w900
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40,),
                      const WeekDisplay()
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.5,
                child: const Center(
                  child:Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Subscribe to create a personalized schedule!',textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700),),
                  ),
                ),
              )

            ],
          )),
    );
  }
}
