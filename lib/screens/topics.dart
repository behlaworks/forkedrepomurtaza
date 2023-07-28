import 'package:aire/screens/topicsPlayer.dart';
import 'package:aire/screens/unit.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import '../components/common ui elements/backButton.dart';
import '../data/constants.dart';
import '../models/cloud_firestore.dart';

class Topics extends StatefulWidget {
  final int unit;

  const Topics({Key? key, required this.unit}) : super(key: key);

  @override
  State<Topics> createState() => _TopicsState();
}

class _TopicsState extends State<Topics> {
  bool processing = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadData();
    });
  }

  Future<void> loadData() async {
    await DatabaseService()
        .listOfTopics(Constants.physicsChapters[widget.unit - 1]);
    setState(() {
      processing = false;
    });
  }

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
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                          const Text(
                            "Physics",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18),
                          ),
                          const SizedBox(height: 5,),
                          Text(
                              "Unit ${widget.unit} : ${Constants.physicsChapters[widget.unit - 1]}")
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.95,
                        height: MediaQuery.of(context).size.height * 0.63,
                        child: const SubTopicList()),
                  ],
                ),
              ));
  }
}

class SubTopicList extends StatelessWidget {
  const SubTopicList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: MediaQuery.of(context).size.height * 0.7,
      width: MediaQuery.of(context).size.width * 0.7,
      child: ListView(
        children: [
          for (var i = 0; i < Constants.titles.length; i++)
            Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: Container(
                      clipBehavior: Clip.hardEdge,
                      height: 75,
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: const Color(0xffECCFC3)),
                      child: InkWell(
                        onTap: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UnitPage(unit: i,)));
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => TopicsPlayer(
                          //               index: i,
                          //             )));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  (i + 1).toString(),
                                  style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  Constants.titles[i],
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )),
                )),
        ],
      ),
    );
  }
}
