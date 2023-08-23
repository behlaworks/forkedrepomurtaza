import 'package:aire/components/common%20ui%20elements/blackButton.dart';
import 'package:aire/components/common%20ui%20elements/textField.dart';
import 'package:aire/screens/home.dart';
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
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _processing
                  ? Expanded(
                child: Center(
                  child: CircularProgressIndicator(
                    color: Constants.dark,
                    strokeWidth: 4,
                  ),
                ),
              )
                  : Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Welcome Back!',
                            style: TextStyle(
                              color: Constants.dark,
                              fontSize: 30,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(
                            height: 60,
                          ),
                          CustomTextField(
                            hint: 'Email',
                            controller: _emailController,
                            inputAction: TextInputAction.next,
                            inputType: TextInputType.emailAddress,
                            obscure: false,
                            validator: (value) =>
                                Validator.validateEmail(email: value),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                            hint: 'Password',
                            controller: _passwordController,
                            inputAction: TextInputAction.done,
                            inputType: TextInputType.visiblePassword,
                            obscure: true,
                            validator: (value) =>
                                Validator.validatePassword(password: value),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () => {},
                                child: const Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Column(
                        children: [
                          BlackButton(
                            text: 'Login',
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  _processing = true;
                                });
                                var user =
                                await FireAuth.signInUsingEmailPassword(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                );
                                if (user == 'success') {
                                  myProvider.login();
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) => const Home()),
                                  );
                                } else {
                                  setState(() {
                                    _processing = false;
                                  });
                                  var snackBar = SnackBar(
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(12),
                                      ),
                                    ),
                                    backgroundColor: const Color(0xffB4E33D),
                                    content: Text(
                                      user,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              }
                            },
                          ),
                          const SizedBox(height: 25),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
