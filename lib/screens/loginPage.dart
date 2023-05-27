import 'package:a_level_pro/components/blackButton.dart';
import 'package:a_level_pro/components/textField.dart';
import 'package:flutter/material.dart';

import '../data/constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 275,
                width: 275,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/black.jpg'),
                        fit: BoxFit.fill)),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 120,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        SizedBox(
                          width: 70,
                        ),
                        Text(
                          'Login',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
            child: CustomTextField(
              controller: TextEditingController(),
              inputAction: TextInputAction.next,
              inputType: TextInputType.emailAddress,
              icon: Icons.email,
              obscure: false,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
            child: CustomTextField(
              controller: TextEditingController(),
              inputAction: TextInputAction.done,
              inputType: TextInputType.visiblePassword,
              icon: Icons.password,
              obscure: true,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 25, 0),
                child: TextButton(
                    onPressed: () => {},
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    )),
              )
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
            child: BlackButton(
              text: 'Login',
              onPressed: (){},
            ),
          ),
          Container(
            height: 50,
            child: Center(
              child: Text(
                'OR',
                style: TextStyle(
                    color: Constants.dark,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
            child: BlackButton(
              text: 'Register',
              onPressed: (){},
            ),
          ),
          const SizedBox(height: 30,)
        ],
      ),
    );
  }
}
