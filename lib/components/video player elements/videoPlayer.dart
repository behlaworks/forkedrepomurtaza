import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import '../../data/constants.dart';
import '../../models/cloud_firestore.dart';
import '../../models/videoController.dart';

class Player extends StatefulWidget {
  final int i;

  const Player({Key? key, required this.i}) : super(key: key);

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  late String title;

  @override
  void initState() {
    super.initState();
    title = "${Constants.units[widget.i]}: ${Constants.titles[widget.i]}";
    if (title.length > 20) {
      title = "${title.substring(0, 19)}....";
    }
  }

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
        if (preloadPageIndex < c.videoPlayerControllers.length - 1 &&
            preloadPageIndex + 1 < Constants.urls.length) {
          await c.initializeIndexedController(preloadPageIndex + 1);
        }

        for (int i = 0; i < c.videoPlayerControllers.length; i++) {
          if (i != preloadPageIndex - 1 &&
              i != preloadPageIndex &&
              i != preloadPageIndex + 1 &&
              i < Constants.urls.length) {
            await c.disposeController(i);
          }
        }
      },
      builder: (_) {
        if (c.videoPlayerControllers.length < widget.i ||
            Constants.urls.length < widget.i) {
          return Center(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
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
                      color: Colors.black,
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
          return SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              body: Stack(
                children: [
                  Stack(
                    children: [
                      const Center(
                          child: CircularProgressIndicator(
                        color: Colors.black,
                        strokeWidth: 4,
                      )),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Stack(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(20, 20, 0, 0),
                                    child: GestureDetector(
                                        onTap: () {
                                          c.disposeAll();
                                          Navigator.pop(context);
                                        },
                                        child: const Icon(
                                          Icons.arrow_back_ios,
                                          size: 20,
                                        )),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 20, 0, 0),
                                    child: Text(
                                      title,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(25.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Column(
                                      children: [
                                        Image.asset(
                                          'assets/bookmark.png',
                                          height: 30,
                                        ),
                                        const SizedBox(
                                          height: 35,
                                        ),
                                        Image.asset(
                                          'assets/writing.png',
                                          height: 30,
                                        ),
                                        const SizedBox(
                                          height: 35,
                                        ),
                                        Constants.completedUnits.contains(
                                                Constants.units[widget.i])
                                            ? Image.asset(
                                                'assets/check-mark-green.png',
                                                height: 30,
                                              )
                                            : Image.asset(
                                                'assets/check-mark.png',
                                                height: 30,
                                              )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  children: [
                                    const Center(
                                      child: Icon(
                                        Icons.pause,
                                        color: Colors.black,
                                        size: 30,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Container(
                                      height: 1,
                                      width: MediaQuery.of(context).size.width *
                                          0.68,
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black)),
                                    ),
                                    // Center(
                                    //   child: GestureDetector(
                                    //     onTap: () {
                                    //       c.disposeAll();
                                    //       Navigator.pop(context);
                                    //     },
                                    //     child: const Icon(
                                    //       Icons.fullscreen,
                                    //       size: 30,
                                    //       color: Colors.black,
                                    //     ),
                                    //   ),
                                    // )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
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

        return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Stack(
              children: [
                c.videoPlayerControllers.isNotEmpty &&
                        c.videoPlayerControllers[c.api]!.value.isInitialized
                    ? Stack(
                        children: [
                          Center(
                            child: SizedBox(
                              height:
                                  (MediaQuery.of(context).size.width * 16) / 9,
                              child:
                                  VideoPlayer(c.videoPlayerControllers[c.api]!),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Stack(
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.fromLTRB(20, 20, 0, 0),
                                        child: GestureDetector(
                                          onTap: () {
                                            c.disposeAll();
                                            Navigator.pop(context);
                                          },
                                          child: const Icon(
                                            Icons.arrow_back_ios,
                                            size: 20,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 20, 0, 0),
                                        child: Text(
                                          title,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(25.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Column(
                                          children: [
                                            Image.asset(
                                              'assets/bookmark.png',
                                              height: 30,
                                            ),
                                            const SizedBox(
                                              height: 35,
                                            ),
                                            Image.asset(
                                              'assets/writing.png',
                                              height: 30,
                                            ),
                                            const SizedBox(
                                              height: 35,
                                            ),
                                            Constants.completedUnits.contains(
                                                    Constants.units[widget.i])
                                                ? Image.asset(
                                                    'assets/check-mark-green.png',
                                                    height: 30,
                                                  )
                                                : GestureDetector(
                                                    onTap: () {
                                                      DatabaseService()
                                                          .updateUnitComplete(
                                                              (Constants.units[
                                                                  widget.i]))
                                                          .then((value) =>
                                                              setState(() {}));
                                                    },
                                                    child: Image.asset(
                                                      'assets/check-mark.png',
                                                      height: 30,
                                                    ),
                                                  )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Row(
                                      children: [
                                        Center(
                                          child: GestureDetector(
                                            onTap: () {
                                              c.togglePaused();
                                              // if (c.videoPlayerControllers[c.api]!.value
                                              //     .isPlaying) {
                                              //   c.togglePaused();
                                              //   c.videoPlayerControllers[c.api]!.pause();
                                              // } else {
                                              //
                                              //   c.videoPlayerControllers[c.api]!.play();
                                              // }
                                            },
                                            child: !c.paused
                                                ? const Icon(
                                                    Icons.pause,
                                                    color: Colors.black,
                                                    size: 30,
                                                  )
                                                : const Icon(
                                                    Icons.play_arrow,
                                                    color: Colors.black,
                                                    size: 30,
                                                  ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.68,
                                          child: VideoProgressIndicator(
                                            c.videoPlayerControllers[c.api]!,
                                            allowScrubbing: true,
                                            colors: const VideoProgressColors(
                                                backgroundColor: Colors.black,
                                                bufferedColor: Colors.black,
                                                playedColor: Colors.purple),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      )
                    : const Center(child: CircularProgressIndicator()),
              ],
            ),
          ),
        );
      },
    );
  }
}
