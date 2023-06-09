import 'package:a_level_pro/screens/chapter1.dart';
import 'package:flutter/material.dart';
import '../data/constants.dart';

class ChapterBox extends StatefulWidget {
  final String name;
  final num ratio;

  const ChapterBox({Key? key, required this.name, required this.ratio})
      : super(key: key);

  @override
  State<ChapterBox> createState() => _ChapterBoxState();
}

class _ChapterBoxState extends State<ChapterBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
        clipBehavior: Clip.hardEdge,
        height: 76,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: const Color(0xffF2F5FF)),
        child: InkWell(
          onTap: () async {
            widget.name == 'Physical quantities and units'
                ? Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Topics(
                              name: widget.name,
                            )))
                : showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: Constants.dark,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        title: const Center(
                            child: Text(
                          "Content locked",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                        )),
                        content: const SizedBox(
                            height: 50,
                            child: Center(
                                child: Text("refer to 5 friends to unlock!",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500)))),
                        actions: [
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: ButtonStyle(
                                  fixedSize: MaterialStateProperty.all(
                                      const Size.fromWidth(200)),
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.white)),
                              child: const Text(
                                "Back",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ],
                      );
                    });
          },
          child: Stack(children: [
            widget.name == 'Physical quantities and units'
                ? Container(
                    width: MediaQuery.of(context).size.width * widget.ratio,
                    height: 76,
                    color: const Color(0xffB4E33D),
                  )
                : const SizedBox(),
            Row(
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
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w700),
                      ),
                    )
                  ],
                ),
                widget.name != 'Physical quantities and units'
                    ? const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.lock),
                      )
                    : const SizedBox()
              ],
            ),
          ]),
        ));
  }
}
