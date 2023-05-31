import 'package:a_level_pro/components/videoPlayer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:preload_page_view/preload_page_view.dart';
import '../data/constants.dart';
import '../models/cloud_firestore.dart';
import '../models/videoController.dart';

class Topics extends StatefulWidget {
  final String name;

  const Topics({Key? key, required this.name}) : super(key: key);

  @override
  State<Topics> createState() => _TopicsState();
}

class _TopicsState extends State<Topics> {
  final c = Get.put(PCC());
  bool processing = true;

  @override
  void initState() {
    super.initState();
    DatabaseService().listOfTopics(widget.name).then((value) => setState(() {
          processing = false;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: processing
            ? const Center(
                child: Text(
                'Fetching complete chapter from backend',
                style: TextStyle(color: Colors.black),
              ))
            : PreloadPageView.builder(
                itemBuilder: (ctx, i) {
                  return Player(i: i);
                },
                onPageChanged: (i) async {
                  c.updateAPI(i);
                  print("length: ${c.videoURLs.length}");
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
