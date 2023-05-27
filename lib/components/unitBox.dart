import 'package:flutter/material.dart';

class UnitBox extends StatelessWidget {
  final int value;

  const UnitBox({Key? key, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      width: 42,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.green, width: 2)),
      child: Center(
        child: Text(
          value.toString(),
          style: const TextStyle(
              color: Colors.green, fontSize: 20, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
