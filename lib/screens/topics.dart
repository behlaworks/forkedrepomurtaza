import 'package:a_level_pro/screens/topicsPlayer.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import '../components/common ui elements/backButton.dart';
import '../data/constants.dart';
import '../models/cloud_firestore.dart';
import '../models/videoController.dart';

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
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * .29,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      color: Color(0xff0b2667)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(20, 30, 0, 0),
                        child: BackButtonCustom(),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 20),
                        child: Text(
                          "Unit ${widget.unit.toString()}",
                          style: const TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.6975,
                  child: ContainedTabBarView(
                    tabBarProperties:
                        TabBarProperties(indicatorColor: Constants.dark),
                    tabs: const [
                      Text('Sub topics',
                          style: TextStyle(
                            color: Colors.black,
                          )),
                      Text('Practice', style: TextStyle(color: Colors.black))
                    ],
                    views: const [
                      SubTopicList(),
                      Center(
                        child: Text(
                          'Practice unit 1.',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                    onChange: (index) => print(index),
                  ),
                ),
              ],
            ),
    );
  }
}

class SubTopicList extends StatelessWidget {
  const SubTopicList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        for (var i = 0; i < Constants.titles.length; i++)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TopicsPlayer(index: i,)));
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.95,
                height: 64,
                decoration: BoxDecoration(
                    color: Colors.black,
                    // color: const Color(0xffF2F5FF),
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Colors.transparent, width: 3)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            (i + 1).toString(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            height: 40,
                            decoration: BoxDecoration(
                                color: Constants.completedUnits
                                    .contains(Constants.units[i])
                                    ? const Color(0xffB4E33D)
                                    : Colors.white, shape: BoxShape.circle),
                            child: const Icon(
                              Icons.play_arrow,
                              size: 30,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(width: 10,),
                          Text(
                            "${Constants.titles[i]}",
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
      ],
    );
  }
}
