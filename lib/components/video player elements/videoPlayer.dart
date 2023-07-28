import 'package:aire/components/video%20player%20elements/unit_box.dart';
import 'package:aire/components/video%20player%20elements/unit_detail_modal_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import '../../data/constants.dart';
import '../../models/videoController.dart';
import '../common ui elements/blackButton.dart';

class Player extends StatefulWidget {
  final int i;

  const Player({Key? key, required this.i}) : super(key: key);

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  @override
  Widget build(BuildContext context) {
    final c = Get.put(PCC());
    return GetBuilder<PCC>(
      initState: (x) async {
        if (!c.initializedIndexes.contains(widget.i)) {
          await c.initializePlayer(widget.i);
        }
        int preloadPageIndex = c.api;
        if (preloadPageIndex > 0 && preloadPageIndex < Constants.urls.length) {
          await c.initializeIndexedController(preloadPageIndex - 1);
        }
        if (preloadPageIndex < c.videoPlayerControllers.length - 1 && preloadPageIndex + 1 < Constants.urls.length) {
          await c.initializeIndexedController(preloadPageIndex + 1);
        }

        for (int i = 0; i < c.videoPlayerControllers.length; i++) {
          if (i != preloadPageIndex - 1 && i != preloadPageIndex && i != preloadPageIndex + 1 && i < Constants.urls.length) {
            await c.disposeController(i);
          }
        }
      },
      builder: (_) {
        if (c.videoPlayerControllers.length < widget.i || Constants.urls.length < widget.i) {
          return Center(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Constants.dark,
              child: Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 50, 15, 0),
                        child: GestureDetector(
                          onTap: () async {
                            c.disposeAll();
                            Constants.urls = [];
                            Constants.units = [];
                            Constants.titles = [];
                            Constants.notes = [];
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 42,
                            width: 42,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Constants.grey,
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.black,
                                size: 15,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 4,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        if (c.videoPlayerControllers.isEmpty ||
            c.videoPlayerControllers[c.api] == null ||
            !c.videoPlayerControllers[c.api]!.value.isInitialized) {
          return Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Constants.dark,
            child: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 50, 15, 0),
                      child: GestureDetector(
                        onTap: () async {
                          c.disposeAll();
                          Constants.urls = [];
                          Constants.units = [];
                          Constants.titles = [];
                          Constants.notes = [];
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 42,
                          width: 42,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Constants.grey,
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.black,
                              size: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 4,
                  ),
                ),
              ],
            ),
          );
        }

        if (widget.i == c.api) {
          if (widget.i < c.videoPlayerControllers.length) {
            if (c.videoPlayerControllers[c.api]!.value.isInitialized) {
              c.videoPlayerControllers[c.api]!.play();
            }
          }
          if (kDebugMode) {
            print('AutoPlaying ${c.api}');
          }
        }
        return Stack(
          children: [
            c.videoPlayerControllers.isNotEmpty &&
                c.videoPlayerControllers[c.api]!.value.isInitialized
                ? Stack(
              children: [
                Center(
                  child: SizedBox(
                    height: (MediaQuery.of(context).size.width * 16) / 9,
                    child: GestureDetector(
                      onTap: () {
                        if (c.videoPlayerControllers[c.api]!.value.isPlaying) {
                          if (kDebugMode) {
                            print("paused");
                          }
                          c.videoPlayerControllers[c.api]!.pause();
                        } else {
                          c.videoPlayerControllers[c.api]!.play();
                          if (kDebugMode) {
                            print("playing");
                          }
                        }
                      },
                      child: VideoPlayer(c.videoPlayerControllers[c.api]!),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 50, 15, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                c.disposeAll();
                                Constants.urls = [];
                                Constants.units = [];
                                Constants.titles = [];
                                Constants.notes = [];
                                Navigator.pop(context);
                              },
                              child: Container(
                                height: 42,
                                width: 42,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Constants.grey,
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.black,
                                    size: 15,
                                  ),
                                ),
                              ),
                            ),
                            UnitBox(
                              value: Constants.units[widget.i],
                              index: widget.i,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
                        child: BlackButton(
                          text: 'Unit details',
                          onPressed: () {
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
                                child: UnitDetailModalCard(
                                  unit: Constants.units[widget.i],
                                  title: Constants.titles[widget.i],
                                  notes: Constants.notes[widget.i],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
                : const Center(child: CircularProgressIndicator()),
          ],
        );
      },
    );
  }
}
