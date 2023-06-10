import 'package:flutter/material.dart';
import '../../data/constants.dart';

class BackButtonCustom extends StatelessWidget {
  const BackButtonCustom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {Navigator.pop(context)},
      child: Container(
        height: 42,
        width: 42,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: Colors.grey),
        child: const Center(
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 15,
          ),
        ),
      ),
    );
  }
}
