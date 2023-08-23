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
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Form(
                key: _formKey,
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
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Let's start with the basics!",
                          style: TextStyle(
                            color: Constants.dark,
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                          child: CustomTextField(
                            hint: 'Full name',
                            controller: _nameController,
                            inputAction: TextInputAction.next,
                            inputType: TextInputType.name,
                            obscure: false,
                            validator: (value) =>
                                Validator.validateName(name: value),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                          child: CustomTextField(
                            hint: 'Your age',
                            controller: _ageController,
                            inputAction: TextInputAction.done,
                            inputType: TextInputType.number,
                            obscure: false,
                            validator: (value) =>
                                Validator.validateAge(age: value),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(25, 0, 25, 25),
                          child: BlackButton(
                            text: 'Continue',
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                Constants.name = _nameController.text;
                                Constants.age = _ageController.text;
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const EmailPage(),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EmailPage extends StatefulWidget {
  const EmailPage({Key? key}) : super(key: key);

  @override
  State<EmailPage> createState() => _EmailPageState();
}

class _EmailPageState extends State<EmailPage> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var snackBar = const SnackBar(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12))),
    backgroundColor: Color(0xffB4E33D),
    content: Text(
      'Email already exists!',
      style: TextStyle(
          color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600),
    ),
  );
  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Form(
                key: _formKey,
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
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "What is your email address?",
                          style: TextStyle(
                              color: Constants.dark,
                              fontSize: 30,
                              fontWeight: FontWeight.w900),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                          child: CustomTextField(
                              hint: 'Email address',
                              controller: _emailController,
                              inputAction: TextInputAction.done,
                              inputType: TextInputType.emailAddress,
                              obscure: false,
                              validator: (value) =>
                                  Validator.validateEmail(email: value)),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(25, 0, 25, 25),
                          child: BlackButton(
                              text: _isProcessing? "verifying..." : "Continue",
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    _isProcessing = true;
                                  });
                                  DatabaseService()
                                      .emailExists(_emailController.text)
                                      .then((value) {
                                    if (!value) {
                                      setState(() {
                                        _isProcessing = false;
                                      });
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    } else {
                                      Constants.email = _emailController.text;
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => const ReferralPage(),
                                        ),
                                      );
                                      setState(() {
                                        _isProcessing = false;
                                      });
                                    }
                                  });
                                }
                              }),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class ReferralPage extends StatefulWidget {
  const ReferralPage({Key? key}) : super(key: key);

  @override
  State<ReferralPage> createState() => _ReferralPageState();
}

class _ReferralPageState extends State<ReferralPage> {
  final _referralController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  var snackBar = const SnackBar(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12))),
    backgroundColor: Color(0xffB4E33D),
    content: Text(
      'Invalid referral code!',
      style: TextStyle(
          color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600),
    ),
  );
  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Form(
                key: _formKey,
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
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Help your friends out using referrals!",
                          style: TextStyle(
                              color: Constants.dark,
                              fontSize: 30,
                              fontWeight: FontWeight.w900),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                          child: CustomTextField(
                              hint: 'leave it empty to skip',
                              controller: _referralController,
                              inputAction: TextInputAction.done,
                              inputType: TextInputType.text,
                              obscure: false,
                              validator: (value) =>
                                  Validator.validateReferral(code: value)),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(25, 0, 25, 25),
                          child: BlackButton(
                              text: _isProcessing? "verifying...":'Continue',
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  if (_referralController.text.isNotEmpty) {
                                    setState(() {
                                      _isProcessing = true;
                                    });
                                    DatabaseService()
                                        .addReferral(_referralController.text)
                                        .then((value) {
                                      if (!value) {
                                        setState(() {
                                          _isProcessing = false;
                                        });
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      } else {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => const CieDatePage(),
                                          ),
                                        );
                                        setState(() {
                                          _isProcessing = false;
                                        });
                                      }
                                    });
                                  } else {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => const CieDatePage(),
                                      ),
                                    );
                                  }
                                }
                              }),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class PasswordPage extends StatefulWidget {
  const PasswordPage({Key? key}) : super(key: key);

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  final _passwordController = TextEditingController();
  final _passwordAgainController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  var snackBar = const SnackBar(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12))),
    backgroundColor: Color(0xffB4E33D),
    content: Text(
      'Some error occurred',
      style: TextStyle(
          color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600),
    ),
  );
  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    final AppStateManager myProvider = Provider.of<AppStateManager>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Form(
                key: _formKey,
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
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Set a password to your account!",
                            style: TextStyle(
                                color: Constants.dark,
                                fontSize: 30,
                                fontWeight: FontWeight.w900),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                          child: CustomTextField(
                              hint: 'password',
                              controller: _passwordController,
                              inputAction: TextInputAction.next,
                              inputType: TextInputType.visiblePassword,
                              obscure: true,
                              validator: (value) =>
                                  Validator.validatePassword(password: value)),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                          child: CustomTextField(
                              hint: 're-enter password',
                              controller: _passwordAgainController,
                              inputAction: TextInputAction.done,
                              inputType: TextInputType.visiblePassword,
                              obscure: true,
                              validator: (value) =>
                                  Validator.validatePasswordAgain(
                                      current: value,
                                      previous: _passwordController.text)),
                        ),
                      ],
                    ),
                    Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(25, 0, 25, 25),
                        child: BlackButton(
                            text: _isProcessing? "verifying...":'Register',
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  _isProcessing = true;
                                });
                                final message = await FireAuth
                                    .registerUsingEmailPassword(
                                  email: Constants.email,
                                  password: _passwordAgainController.text,
                                );
                                if (message.contains('Success')) {
                                  final result =
                                  await DatabaseService().addUser();
                                  if (result!.contains('success')) {
                                    Constants.name = '';
                                    Constants.age = '';
                                    Constants.email = '';
                                    myProvider.login();
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) => const Home()));
                                  } else {
                                    setState(() {
                                      _isProcessing = false;
                                    });
                                    var snackBar = SnackBar(
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(12))),
                                      backgroundColor: const Color(0xffB4E33D),
                                      content: Text(
                                        result,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  }
                                } else {
                                  setState(() {
                                    _isProcessing = false;
                                  });
                                  var snackBar = SnackBar(
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(12))),
                                    backgroundColor: const Color(0xffB4E33D),
                                    content: Text(
                                      message,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              }
                            }),
                      ),
                    ]),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class CieDatePage extends StatefulWidget {
  const CieDatePage({Key? key}) : super(key: key);

  @override
  State<CieDatePage> createState() => _CieDatePageState();
}

class _CieDatePageState extends State<CieDatePage> {
  var placeholder = 'Winter 23';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "When are you appearing for your examinations?",
                        style: TextStyle(
                            color: Constants.dark,
                            fontSize: 30,
                            fontWeight: FontWeight.w900),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.2,
                              ),
                              Radio(
                                activeColor: Colors.red,
                                value: 'Winter 23',
                                groupValue: placeholder,
                                onChanged: (value) {
                                  setState(() {
                                    placeholder = value!;
                                  });
                                },
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                'Winter \'23',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.2,
                              ),
                              Radio(
                                activeColor: Colors.red,
                                value: 'Summer 23',
                                groupValue: placeholder,
                                onChanged: (value) {
                                  setState(() {
                                    placeholder = value!;
                                  });
                                },
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                'Summer \'24',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.2,
                              ),
                              Radio(
                                activeColor: Colors.red,
                                value: 'Not confirmed',
                                groupValue: placeholder,
                                onChanged: (value) {
                                  setState(() {
                                    placeholder = value!;
                                  });
                                },
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                'Not confirmed',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                  Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(25, 0, 25, 25),
                      child: BlackButton(
                          text: 'Continue',
                          onPressed: () {
                            Constants.examDate = placeholder;
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const PasswordPage()));
                          }),
                    ),
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

