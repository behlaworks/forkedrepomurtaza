import 'package:a_level_pro/screens/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/common ui elements/blackButton.dart';
import '../components/common ui elements/textField.dart';
import '../data/constants.dart';
import '../models/app_state_manager.dart';
import '../models/cloud_firestore.dart';
import '../models/fire_auth.dart';
import '../models/validator.dart';
import 'home.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final _ageController = TextEditingController();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    final AppStateManager myProvider = Provider.of<AppStateManager>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _isProcessing
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
                                        'Register',
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
                              hint: 'Full name',
                              controller: _nameController,
                              inputAction: TextInputAction.next,
                              inputType: TextInputType.name,
                              icon: Icons.person_off,
                              obscure: false,
                              validator: (value) =>
                                  Validator.validateName(name: value)),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                          child: CustomTextField(
                            hint: 'Your age',
                            controller: _ageController,
                            inputAction: TextInputAction.next,
                            inputType: TextInputType.number,
                            icon: Icons.numbers,
                            obscure: false,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                          child: CustomTextField(
                              hint: "Email",
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
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.09,
                        ),
                        Column(children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                            child: BlackButton(
                                text: 'Register',
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      _isProcessing = true;
                                    });
                                    final message = await FireAuth
                                        .registerUsingEmailPassword(
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                    );
                                    if (message!.contains('Success')) {
                                      final result =
                                          await DatabaseService().addUser(
                                        fullName: _nameController.text,
                                        age: _ageController.text,
                                        email: _emailController.text,
                                      );
                                      if (result!.contains('success')) {
                                        myProvider.login();
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) => const Home()));
                                      }
                                    }
                                  }
                                }),
                          ),
                        ]),
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
                            text: 'Login',
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()),
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
        ),
      ),
    );
  }
}
