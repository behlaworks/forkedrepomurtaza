import 'package:a_level_pro/components/video%20player%20elements/unitDetailModalCard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../data/constants.dart';
import '../../models/videoController.dart';
import 'contents.dart';

class UnitBox extends StatelessWidget {
  final String value;
  final int index;

  UnitBox({Key? key, required this.value, required this.index}) : super(key: key);
  final PCC c = Get.find();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        c.videoPlayerControllers[c.api]!.pause();
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) => Container(
            height: MediaQuery.of(context).size.height * 0.8,
            decoration: BoxDecoration(
              color: Constants.dark,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0),
              ),
            ),
            child: Contents(index: index,)
          ),
        );
      },
      child: Container(
        height: 42,
        width: 42,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.black.withOpacity(0.5),
            border: Border.all(color: Colors.green, width: 2)),
        child: Center(
          child: Text(
            value,
            style: const TextStyle(
                color: Colors.green, fontSize: 20, fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }
}
