import 'package:a_level_pro/components/common%20ui%20elements/blackButton.dart';
import 'package:a_level_pro/components/common%20ui%20elements/textField.dart';
import 'package:a_level_pro/screens/home.dart';
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
                ? SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                        child: CircularProgressIndicator(
                      color: Constants.dark,
                      strokeWidth: 3,
                    )))
                : SizedBox(
              height: MediaQuery.of(context).size.height,
                  child: Stack(
                      children: [
                         Padding(
                          padding: const EdgeInsets.fromLTRB(25, 50, 0, 0),
                          child: GestureDetector(
                            onTap: () => {Navigator.pop(context)},
                            child: Container(
                              height: 42,
                              width: 42,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8), color: Constants.grey),
                              child: const Center(
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.black,
                                  size: 15,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Welcome Back!',
                                style: TextStyle(
                                    color: Constants.dark,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w900),
                              ),
                              const SizedBox(
                                height: 60,
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                                child: CustomTextField(
                                    hint: 'Email',
                                    controller: _emailController,
                                    inputAction: TextInputAction.next,
                                    inputType: TextInputType.emailAddress,
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
                            ],
                          ),
                        ),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(25, 0, 25, 25),
                              child: BlackButton(
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
                                    }else{
                                      setState(() {
                                        _processing = false;
                                      });
                                      var snackBar =SnackBar(
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.vertical(top: Radius.circular(12))),
                                        backgroundColor: const Color(0xffB4E33D),
                                        content: Text(
                                          user,
                                          style: const TextStyle(
                                              color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600),
                                        ),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    }
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                ),
          ],
        ),
      ),
    ));
  }
}
