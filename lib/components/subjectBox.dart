import 'package:a_level_pro/screens/physics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/constants.dart';
import '../models/app_state_manager.dart';

//these boxes are used for the addSubject page also known as explore page

class SubjectBox extends StatefulWidget {
  final String name;

  const SubjectBox({Key? key, required this.name}) : super(key: key);

  @override
  State<SubjectBox> createState() => _SubjectBoxState();
}

class _SubjectBoxState extends State<SubjectBox> {
  @override
  Widget build(BuildContext context) {
    final AppStateManager myProvider = Provider.of<AppStateManager>(context);
    Future<void> _showAlertDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Constants.dark,
            title: const Text(
              'Enroll?',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text(
                    'Enroll and start learning!',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  'No',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text(
                  'Yes',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  !myProvider.enrolledSubs.contains(widget.name)
                      ? myProvider.addEnrolledSub(widget.name)
                      : Null;
                  Constants.subjects.remove(widget.name);
                  setState(() {});
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PhysicsContentPage()),
                  );
                },
              ),
            ],
          );
        },
      );
    }

// --- Button Widget --- //
    ElevatedButton(
      onPressed: _showAlertDialog,
      child: const Text(
        'Show Alert Dialog',
        style: TextStyle(fontSize: 24),
      ),
    );
    return Ink(
        height: 76,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14), color: Constants.grey),
        child: InkWell(
          onTap: () => {widget.name == 'Physics' ? _showAlertDialog() : {}},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      widget.name,
                      style: const TextStyle(
                          fontSize: 24,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  myProvider.enrolledSubs.contains(widget.name)
                      ? const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Enrolled',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w100,
                            ),
                          ),
                        )
                      : widget.name == 'Physics'
                          ? const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Free',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w100,
                                ),
                              ),
                            )
                          : const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Coming soon.',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w100,
                                ),
                              ),
                            )
                ],
              )
            ],
          ),
        ));
  }
}

// these boxes are used in the dashboard to maintain state of current subjects
class SubjectBoxDash extends StatefulWidget {
  final String name;

  const SubjectBoxDash({Key? key, required this.name}) : super(key: key);

  @override
  State<SubjectBoxDash> createState() => _SubjectBoxDashState();
}

class _SubjectBoxDashState extends State<SubjectBoxDash> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () => {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const PhysicsContentPage()),
            )
          },
          child: Container(
            height: 120,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Constants.dark,
            ),
            child: Center(
              child: Text(
                widget.name.substring(0, 3),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(5, 5, 0, 0),
          child: Text(
            widget.name,
            style: const TextStyle(
                fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
