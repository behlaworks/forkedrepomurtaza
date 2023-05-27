import 'package:flutter/material.dart';
import 'package:a_level_pro/data/constants.dart';

import '../components/subjectBox.dart';

class AddSubjectPage extends StatefulWidget {
  const AddSubjectPage({Key? key}) : super(key: key);

  @override
  State<AddSubjectPage> createState() => _AddSubjectPageState();
}

class _AddSubjectPageState extends State<AddSubjectPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Column(
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * .25,
                color: Constants.dark,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.15,
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: Text(
                          "A-Levels",
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ])),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.59,
              child: ListView(
                children: [
                  for (var item in Constants.subjects)
                    Padding(
                        padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                        child: SubjectBox(name: item)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
