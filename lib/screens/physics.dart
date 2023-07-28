import 'package:flutter/material.dart';
import 'package:aire/models/cloud_firestore.dart';
import '../components/chapterBox.dart';
import '../data/constants.dart';

class PhysicsContentPage extends StatefulWidget {
  const PhysicsContentPage({Key? key}) : super(key: key);

  @override
  State<PhysicsContentPage> createState() => _PhysicsContentPageState();
}

class _PhysicsContentPageState extends State<PhysicsContentPage> {
  int completedPercent = 0;

  @override
  void initState() {
    super.initState();
    DatabaseService().unitCompletionCalculator().then((value) {
      completedPercent = value.toInt();
      setState(() {
        processing = false;
      });
    });
  }

  bool processing = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: processing
            ? Center(
                child: CircularProgressIndicator(
                  color: Constants.dark,
                  strokeWidth: 4,
                ),
              )
            : SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Image.asset(
                              'assets/nextrev.png',
                              height: 30,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 180,
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(25)),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Container(
                                      height: 70,
                                      width: 70,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8),
                                          color: Colors.white),
                                      child: Center(
                                          child: Image.asset(
                                        'assets/atom.png',
                                        height: 50,
                                      )),
                                    ),
                                  ),
                                  const Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Physics",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700, fontSize: 18),
                                      ),
                                      Text(
                                        "5 videos",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500, fontSize: 13),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: const Color(0xfff2f3f7),
                                        borderRadius: BorderRadius.circular(30)
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Text("$completedPercent% Completed", style: const TextStyle(fontSize: 12),),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height: 40,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "Units",
                                      style: TextStyle(
                                        fontSize: 12
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 40,
                                  width: 70,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white
                                  ),
                                  child: const Center(
                                    child: Text(
                                        "Practice",
                                        style: TextStyle(
                                        fontSize: 12
                                    ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 40,
                                  width: 70,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white
                                  ),
                                  child: const Center(
                                    child: Text(
                                        "Past Papers",
                                      style: TextStyle(
                                          fontSize: 10
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20,),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.95,
                      height: MediaQuery.of(context).size.height * 0.63,
                      child: const Content()
                    ),
                  ],
                ),
              ));
  }
}

class Content extends StatelessWidget {

  const Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: MediaQuery.of(context).size.height * 0.7,
      width: MediaQuery.of(context).size.width * 0.7,
      child: ListView(
        children: [
          for (var i = 0; i < Constants.physicsChapters.length; i++)
            Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                child: ChapterBox(
                  name: Constants.physicsChapters[i],
                  unit: i + 1,
                )),

        ],
      ),
    );
  }
}
