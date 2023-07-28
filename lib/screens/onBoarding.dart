import 'package:aire/screens/loginPage.dart';
import 'package:aire/screens/registrationPage.dart';
import 'package:flutter/material.dart';

import '../data/constants.dart';
import '../models/pages.dart';

class OnboardingScreen extends StatefulWidget {
  static MaterialPage page() {
    return MaterialPage(
        name: Pages.onboarding,
        key: ValueKey(Pages.onboarding),
        child: const OnboardingScreen());
  }

  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.3,
              ),
              const Image(image: AssetImage('assets/onboardingLady.png')),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Let's revolutionize education together!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Constants.dark,
                      fontSize: 30,
                      fontWeight: FontWeight.w900),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                      );
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    minWidth: MediaQuery.of(context).size.width*0.45,
                    height: 56,
                    color: Constants.dark,
                    child: const Center(
                        child: Text(
                      'Login',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w700),
                    )),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width*0.03,),
                  MaterialButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegistrationPage()),
                      );
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    minWidth: MediaQuery.of(context).size.width*0.45,
                    height: 56,
                    color: Constants.dark,
                    child: const Center(
                        child: Text(
                          'Register',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w700),
                        )),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
