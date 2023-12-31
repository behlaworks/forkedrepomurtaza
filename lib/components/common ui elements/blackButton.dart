import 'package:flutter/material.dart';

import '../../data/constants.dart';

class BlackButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;

  const BlackButton({Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      elevation: 4,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: Colors.black, width: 2)),
      minWidth: 100,
      height: 56,
      color: Constants.brown,
      child: Center(
          child: Text(
        text,
        style: const TextStyle(
            color: Colors.black, fontSize: 15, fontWeight: FontWeight.w700),
      )),
    );
  }
}
