import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../data/constants.dart';

class Contents extends StatefulWidget {
  final int index;

  const Contents({Key? key, required this.index}) : super(key: key);

  @override
  State<Contents> createState() => _ContentsState();
}

class _ContentsState extends State<Contents> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(0.0),
            child: Icon(
              Icons.minimize,
              size: 40,
              color: Colors.white,
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 25, 0, 0),
            child: Text(
              "Contents",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
            ),
          ),
          Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              for (var i = 0; i < Constants.titles.length; i++)
                widget.index != i
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            // PCC().updateAPI(i);
                            // Constants.controller.jumpToPage(i);
                            // Constants.controller.animateToPage(i,
                            //     duration: const Duration(seconds: 5),
                            //     curve: Curves.decelerate);
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.95,
                            height: 60,
                            decoration: BoxDecoration(
                                color: Constants.completedUnits
                                        .contains(Constants.units[i])
                                    ? const Color(0xffB4E33D)
                                    : const Color(0xffF2F5FF),
                                // color: const Color(0xffF2F5FF),
                                borderRadius: BorderRadius.circular(12),
                                border:
                                    Border.all(color: Colors.transparent, width: 3)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    child: Center(
                                      child: Text(
                                        "${Constants.titles[i]}",
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.1,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.95,
                          height: 60,
                          decoration: BoxDecoration(
                              color: Constants.completedUnits
                                  .contains(Constants.units[i])
                                  ? const Color(0xffB4E33D)
                                  : const Color(0xffF2F5FF),
                              borderRadius: BorderRadius.circular(12),
                              border:
                                  Border.all(color: Colors.transparent, width: 3)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  child: Center(
                                    child: Text(
                                      "${Constants.titles[i]}",
                                      style: const TextStyle(
                                          color: Colors.black),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.1,
                                  child: Center(
                                    child: Lottie.asset(
                                      'assets/play.json',
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
            ],
          ),
          const SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}
