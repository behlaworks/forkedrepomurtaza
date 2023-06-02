import 'package:a_level_pro/components/common%20ui%20elements/blackButton.dart';
import 'package:a_level_pro/components/common%20ui%20elements/textField.dart';
import 'package:a_level_pro/screens/home.dart';
import 'package:a_level_pro/screens/registrationPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/constants.dart';
import '../models/app_state_manager.dart';
import '../models/fire_auth.dart';
import '../models/validator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _processing = false;

  @override
  Widget build(BuildContext context) {
    final AppStateManager myProvider = Provider.of<AppStateManager>(context);
    return Scaffold(
        body: SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            _processing
                ? Container(
              height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                        child: CircularProgressIndicator(
                    color: Constants.dark,
                    strokeWidth: 3,
                  )))
                : Column(
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
                          hint: 'Email',
                            controller: _emailController,
                            inputAction: TextInputAction.next,
                            inputType: TextInputType.emailAddress,
                            icon: Icons.email,
                            obscure: false,
                            validator: (value) =>
                                Validator.validateEmail(email: value)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                        child: CustomTextField(
                          hint: 'Password',
                          controller: _passwordController,
                          inputAction: TextInputAction.done,
                          inputType: TextInputType.visiblePassword,
                          icon: Icons.password,
                          obscure: true,
                          validator: (value) =>
                              Validator.validatePassword(password: value),
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
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.18,
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                            child: BlackButton(
                              text: 'Login',
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    _processing = true;
                                  });
                                  User? user =
                                      await FireAuth.signInUsingEmailPassword(
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                  );
                                  if (user != null) {
                                    myProvider.login();
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) => const Home()),
                                    );
                                  }
                                }
                              },
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
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => const RegistrationPage()),
                                );
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          )
                        ],
                      ),
                    ],
                  ),
          ],
        ),
      ),
    ));
  }
}
