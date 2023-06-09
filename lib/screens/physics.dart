import 'package:a_level_pro/components/common%20ui%20elements/backButton.dart';
import 'package:a_level_pro/models/cloud_firestore.dart';
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
    DatabaseService().unitCompletionCalculator(1.toString()).then((value) {
      for (var i = 0; i < Constants.physicsChapters.length; i++) {
        if (i < value.length) {
          ratios.add(value[i]);
        } else {
          ratios.add(0);
        }
      }
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
                children: [
                  Flexible(
                    flex: 3,
                    child: Container(
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
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: ListView(
                      children: [
                        for (var i = 0;
                            i < Constants.physicsChapters.length;
                            i++)
                          Padding(
                              padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                              child: ChapterBox(
                                name: Constants.physicsChapters[i],
                                ratio: ratios[i],
                              )),
                      ],
                    ),
                  )
                ],
              ));
  }
}
