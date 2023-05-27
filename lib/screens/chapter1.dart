import 'package:a_level_pro/components/videoPlayer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:preload_page_view/preload_page_view.dart';

import '../models/videoController.dart';

class Chapter1 extends StatefulWidget {
  const Chapter1({Key? key}) : super(key: key);

  @override
  State<Chapter1> createState() => _Chapter1State();
}

class _Chapter1State extends State<Chapter1> {
  final c = Get.put(PCC());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: PreloadPageView.builder(
          itemBuilder: (ctx, i) {
            return Player(i: i);
          },
          onPageChanged: (i) async {
            c.updateAPI(i);
          },
          //If you are increasing or descrising preaload page count change accordingly in the player widget
          preloadPagesCount: 1,
          controller: PreloadPageController(initialPage: 0),
          itemCount: c.videoURLs.length,
          scrollDirection: Axis.vertical,
          physics: const AlwaysScrollableScrollPhysics(),
        ),
      ),
    );
  }
}
