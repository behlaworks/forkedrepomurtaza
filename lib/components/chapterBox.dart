import 'package:flutter/material.dart';
import '../data/constants.dart';
import '../screens/topics.dart';
import 'common ui elements/dialog.dart';

class ChapterBox extends StatefulWidget {
  final String name;
  final int unit;

  const ChapterBox(
      {Key? key, required this.name, required this.unit})
      : super(key: key);

  @override
  State<ChapterBox> createState() => _ChapterBoxState();
}

class _ChapterBoxState extends State<ChapterBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: Container(
          clipBehavior: Clip.hardEdge,
          height: 75,
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color(0xffECCFC3)),
          child: InkWell(
            onTap: () async {
              widget.name == 'Physical quantities and units' ||
                      Constants.numberOfReferrals > 4
                  ? Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Topics(
                                unit: widget.unit,
                              )))
              : showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CustomAlertDialog(
                          title: "Content locked",
                          text: "Refer to 5 friends to unlock. \n Current referrals: ${Constants.numberOfReferrals}",
                        );

                      });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      widget.name,
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                widget.name == "Physical quantities and units" || Constants.numberOfReferrals > 4?
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                  child: Image.asset(
                    'assets/next.png',
                    height: 20,
                  ),
                ):
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                  child: Image.asset(
                    'assets/padlock.png',
                    height: 15,
                  ),
                )
              ],
            ),
          )),
    );
  }
}
