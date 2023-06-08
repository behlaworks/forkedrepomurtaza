import 'package:a_level_pro/components/video%20player%20elements/unit_box.dart';
import 'package:a_level_pro/components/video%20player%20elements/unit_detail_modal_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import '../../data/constants.dart';
import '../../models/videoController.dart';
import '../common ui elements/blackButton.dart';

class Player extends StatelessWidget {
  final int i;

  const Player({Key? key, required this.i}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.put(PCC());
    return GetBuilder<PCC>(
      initState: (x) async {
        //Need to change conditions according preload page count
        //Don't load too many pages it will cause performance issue.
        // Below is for 1 page preload.
        if (c.api > 1) {
          await c.disposeController(c.api - 2);
        }
        if (c.api < c.videoPlayerControllers.length - 2) {
          await c.disposeController(c.api + 2);
        }
        if (!c.initilizedIndexes.contains(i)) {
          await c.initializePlayer(i);
        }
        if (c.api > 0) {
          if (c.videoPlayerControllers[c.api - 1] == null) {
            await c.initializeIndexedController(c.api - 1);
          }
        }
        if (c.api < c.videoPlayerControllers.length - 1) {
          if (c.videoPlayerControllers[c.api + 1] == null) {
            await c.initializeIndexedController(c.api + 1);
          }
        }
      },
      builder: (_) {
        if (i >= c.videoPlayerControllers.length) {
          // Handle the case where the index is out of range
          // You can show an empty container or an error message
          // based on your application's requirements
          return const Center(
            child: Text('Yo whatup', style: TextStyle(color: Colors.black),),
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
                          onTap: ()async{
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
                                color: Constants.grey),
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
                  )),
                ],
              ));
        }

        if (i == c.api) {
          //If Index equals Auto Play Index
          //Set AutoPlay True Here
          if (i < c.videoPlayerControllers.length) {
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
                ? Stack(children: [
                    Center(
                      child: Container(
                        height: (MediaQuery.of(context).size.width * 16) / 9,
                        child: GestureDetector(
                          onTap: () {
                            if (c.videoPlayerControllers[c.api]!.value
                                .isPlaying) {
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
                                        color: Constants.grey),
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
                                  value: Constants.units[i],
                                  index: i,
                                )
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
                                    height: MediaQuery.of(context).size.height *
                                        0.8,
                                    decoration: BoxDecoration(
                                      color: Constants.dark,
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(25.0),
                                        topRight: Radius.circular(25.0),
                                      ),
                                    ),
                                    child: UnitDetailModalCard(
                                      unit: Constants.units[i],
                                      title: Constants.titles[i],
                                      notes: Constants.notes[i],
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ])
                : const Center(child: CircularProgressIndicator()),
          ],
        );
      },
    );
  }
}
