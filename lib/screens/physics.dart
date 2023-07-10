import 'package:a_level_pro/components/common%20ui%20elements/backButton.dart';
import 'package:a_level_pro/models/cloud_firestore.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import '../components/chapterBox.dart';
import '../data/constants.dart';

class PhysicsContentPage extends StatefulWidget {
  const PhysicsContentPage({Key? key}) : super(key: key);

  @override
  State<PhysicsContentPage> createState() => _PhysicsContentPageState();
}

class _PhysicsContentPageState extends State<PhysicsContentPage> {
  List ratios = [];

  @override
  void initState() {
    super.initState();
    DatabaseService().unitCompletionCalculator().then((value) {
      ratios = value;
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
                        const Padding(
                          padding: EdgeInsets.fromLTRB(20, 0, 0, 20),
                          child: Text(
                            "Physics",
                            style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.6975,
                    child: ContainedTabBarView(
                      tabBarProperties:
                          TabBarProperties(indicatorColor: Constants.dark),
                      tabs: const [
                        Text('Units',
                            style: TextStyle(
                              color: Colors.black,
                            )),
                        Text('Past Papers',
                            style: TextStyle(color: Colors.black))
                      ],
                      views: [
                        Content(ratios: ratios),
                        const Center(
                          child: Text(
                            'Past Papers coming soon',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                      onChange: (index) => print(index),
                    ),
                  ),
                ],
              ));
  }
}

class Content extends StatelessWidget {
  final List ratios;

  const Content({Key? key, required this.ratios}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
      child: ListView(
        children: [
          for (var i = 0; i < Constants.physicsChapters.length; i++)
            Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                child: ChapterBox(
                  name: Constants.physicsChapters[i],
                  ratio: ratios[i],
                  unit: i+1,
                )),
        ],
      ),
    );
  }
}
