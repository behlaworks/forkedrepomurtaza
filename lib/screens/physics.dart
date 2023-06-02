import 'package:a_level_pro/components/common%20ui%20elements/backButton.dart';
import 'package:flutter/material.dart';
import '../components/chapterBox.dart';
import '../data/constants.dart';

class PhysicsContentPage extends StatefulWidget {
  const PhysicsContentPage({Key? key}) : super(key: key);

  @override
  State<PhysicsContentPage> createState() => _PhysicsContentPageState();
}

class _PhysicsContentPageState extends State<PhysicsContentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          child: Column(
            children: [
              Flexible(
                flex: 3,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * .29,
                  decoration: const BoxDecoration(borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)), color: Color(0xff0b2667)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10,),
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
              const SizedBox(
                height: 10,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.7,
                child: ListView(
                  children: [
                    for (var item in Constants.physicsChapters)
                      Padding(
                          padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                          child: ChapterBox(name: item)),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
