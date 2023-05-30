import 'package:a_level_pro/components/videoPlayer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:preload_page_view/preload_page_view.dart';
import '../models/videoController.dart';

class Chapters extends StatefulWidget {
  final List urls;
  final List units;
  const Chapters({Key? key, required this.urls, required this.units}) : super(key: key);

  @override
  State<Chapters> createState() => _ChaptersState();
}

class _ChaptersState extends State<Chapters> {
  final c = Get.put(PCC());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: PreloadPageView.builder(
          itemBuilder: (ctx, i) {
            return Player(i: i, urls: widget.urls,units: widget.units,);
          },
          onPageChanged: (i) async {
            c.updateAPI(i);
          },
          //If you are increasing or decreasing preload page count change accordingly in the player widget
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
