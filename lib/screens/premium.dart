import 'package:flutter/material.dart';

class PremiumSubscriptions extends StatelessWidget {
  const PremiumSubscriptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2f3f7),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 14, 0, 0),
                child: Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Image.asset(
                          'assets/nextrev.png',
                          height: 30,
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      "Subscription",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(14, 0, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Choose your plan",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                height: 500,
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    border:
                        Border.all(color: const Color(0xffcde0f7), width: 5)),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 30,
                        ),
                        Image.asset(
                          'assets/crown.png',
                          height: 40,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          "Basic",
                          style: TextStyle(
                              fontSize: 23, fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(14, 0, 0, 0),
                      child: Row(
                        children: [
                          Text(
                            "Rs.1000",
                            style: TextStyle(
                                fontSize: 45, fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            "/Monthly",
                            style: TextStyle(fontSize: 17),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Material(
                        borderRadius: BorderRadius.circular(15),
                        elevation: 5,
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.65,
                          decoration: BoxDecoration(
                              color: const Color(0xffcde0f7),
                              borderRadius: BorderRadius.circular(15)),
                          child: const Center(
                              child: Text(
                            "Upgrade to Basic",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          )),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Feature(data: 'limited access to Pro-chatbot'),
                    const Feature(data: 'Complete access to 1 subject'),
                    const Feature(data: "Monthly tests"),
                    const Feature(data: "2 sessions with counselor"),
                    const Feature(data: "Access to 5 year topical papers"),
                    const Feature(data: "Access to personalized timetable"),
                    const Feature(data: "24/7 assistance")
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                height: 500,
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    border:
                        Border.all(color: const Color(0xfff6dbc4), width: 5)),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 30,
                        ),
                        Image.asset(
                          'assets/crownPre.png',
                          height: 40,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          "Premium",
                          style: TextStyle(
                              fontSize: 23, fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(14, 0, 0, 0),
                      child: Row(
                        children: [
                          Text(
                            "Rs.2000",
                            style: TextStyle(
                                fontSize: 45, fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            "/Monthly",
                            style: TextStyle(fontSize: 17),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Material(
                        borderRadius: BorderRadius.circular(15),
                        elevation: 5,
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.65,
                          decoration: BoxDecoration(
                              color: const Color(0xfff6dbc4),
                              borderRadius: BorderRadius.circular(15)),
                          child: const Center(
                              child: Text(
                            "Upgrade to Premium",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          )),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Feature(data: 'Unlimited access to Pro-chatbot'),
                    const Feature(data: 'Complete access to 5 subject'),
                    const Feature(data: "Monthly and end of unit tests"),
                    const Feature(
                        data: "Assistance from market expert teachers"),
                    const Feature(
                        data: "4 sessions with career counselors"),
                    const Feature(data: "Access to 10 year topical papers"),
                    const Feature(data: "Access to personalized timetable"),
                    const Feature(data: "24/7 assistance")
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Feature extends StatelessWidget {
  final String data;

  const Feature({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 8, 0, 0),
      child: Row(
        children: [
          Image.asset(
            'assets/arrow.png',
            height: 12,
          ),
          const SizedBox(
            width: 3,
          ),
          Flexible(
              child: Text(
            data,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ))
        ],
      ),
    );
  }
}
