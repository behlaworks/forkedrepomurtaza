import 'package:aire/screens/premium.dart';
import 'package:aire/screens/profilePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../components/common ui elements/dialog.dart';
import '../components/subjectBox.dart';
import '../data/constants.dart';
import '../models/app_state_manager.dart';
import 'calender.dart';

class Dashboard extends StatefulWidget {
  final String name;
  final String age;
  final String refID;
  final String intake;

  const Dashboard({Key? key,
    required this.name,
    required this.age,
    required this.refID,
    required this.intake})
      : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    final AppStateManager myProvider = Provider.of<AppStateManager>(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        drawerScrimColor: Constants.dark,
        backgroundColor: const Color(0xfff2f3f7),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ProfilePage(name: widget.name,
                                                age: widget.age,
                                                refID: widget.refID,
                                                intake: widget.intake)),);
                                },
                                child: Image.asset(
                                  'assets/profile.png',
                                  height: 40,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Hi! ${widget.name}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 17),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Image.asset(
                                'assets/bell.png',
                                height: 35,
                              ),
                              const SizedBox(width: 10,),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const PremiumSubscriptions()),
                                  );
                                },
                                child: Image.asset(
                                  'assets/diamond.png',
                                  height: 30,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.05,
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                              child: Text(
                                "Your courses",
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: SizedBox(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            height: MediaQuery.of(context).size.height* 0.33,
                            child: ListView(
                              scrollDirection: Axis.vertical,
                              children: [
                                for (var item in myProvider.enrolledSubs)
                                  Padding(
                                    padding:
                                    const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                    child: SubjectBoxDash(name: item),
                                  ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return const CustomAlertDialog(
                                    title: "Hold your horses!",
                                    text: "We are actively working on adding more subjects."
                                  );
                                });
                          },
                          child: Material(
                            borderRadius: BorderRadius.circular(12),
                            elevation: 6,
                            child: Container(
                              height: 60,
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.8,
                              decoration: BoxDecoration(
                                  color: const Color(0xffd2beda),
                                  borderRadius: BorderRadius.circular(12)),
                              child: const Center(
                                child: Text(
                                  "Add new",
                                  style: TextStyle(
                                      fontSize: 17, fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.04,),
                        Container(
                          height: 2,
                          width: MediaQuery.of(context).size.width * 0.85,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.04,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Column(
                            children: [
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "This weeks schedule.",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 19,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              GestureDetector(
                                onTap: () =>
                                {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Calender()),
                                  )
                                },
                                child: Material(
                                  borderRadius: BorderRadius.circular(15),
                                  elevation: 5,
                                  child: Container(
                                    height: 70,
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width,
                                    decoration: BoxDecoration(
                                        color: const Color(0xff9bc1b3),
                                        borderRadius: BorderRadius.circular(15)),
                                    child: const Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding:
                                          EdgeInsets.fromLTRB(20, 0, 0, 0),
                                          child: Text(
                                            "Calendar",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                          EdgeInsets.fromLTRB(0, 0, 20, 0),
                                          child: Icon(
                                            Icons.chevron_right,
                                            size: 30,
                                            color: Colors.black,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
