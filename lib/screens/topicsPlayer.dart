import 'package:a_level_pro/components/video%20player%20elements/videoPlayer.dart';
import 'package:a_level_pro/models/app_state_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:preload_page_view/preload_page_view.dart';
import '../data/constants.dart';
import '../models/cloud_firestore.dart';
import '../models/videoController.dart';

class TopicsPlayer extends StatefulWidget {
  final int index;

  const TopicsPlayer({Key? key, required this.index}) : super(key: key);

  @override
  State<TopicsPlayer> createState() => _TopicsPlayerState();
}

class _TopicsPlayerState extends State<TopicsPlayer> {
  final c = Get.put(PCC());
  bool processing = false;
  int lastSeen = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        c.disposeAll();
        Constants.urls = [];
        Constants.units = [];
        Constants.titles = [];
        Constants.notes = [];
        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
        body: SizedBox(
          child: processing
              ? Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: Constants.dark,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 4,
                    ),
                  ),
                )
              : PreloadPageView.builder(
                  itemBuilder: (ctx, i) {
                    return Player(i: i);
                  },
                  onPageChanged: (i) async {
                    c.updateAPI(i);
                    AppStateManager().updateLastSeen(i.toString());
                  },
                  //If you are increasing or decreasing preload page count change accordingly in the player widget
                  preloadPagesCount: 1,
                  controller: Constants.controller,
                  itemCount: Constants.urls.length,
                  scrollDirection: Axis.vertical,
                  physics: const AlwaysScrollableScrollPhysics(),
                ),
        ),
      ),
    );
  }
}
