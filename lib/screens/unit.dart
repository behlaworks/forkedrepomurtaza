import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../data/constants.dart';
import '../models/cloud_firestore.dart';

class UnitPage extends StatefulWidget {
  final int unit;

  const UnitPage({Key? key, required this.unit}) : super(key: key);

  @override
  State<UnitPage> createState() => _UnitPageState();
}

class _UnitPageState extends State<UnitPage> {
  late VideoPlayerController singleVideoController;

  @override
  void initState() {
    super.initState();
    // Initialize the VideoPlayerController with the video URL
    final Uri videoUri = Uri.parse(Constants.urls[widget.unit]);
    singleVideoController = VideoPlayerController.network(videoUri.toString())
      ..initialize().then((_) {
        // Ensure the video is looped when it ends
        singleVideoController.setLooping(true);
        // Start playing the video
        singleVideoController.play();
        setState(() {}); // Trigger a rebuild to show the video
      });
  }

  @override
  void dispose() {
    // Dispose of the VideoPlayerController to free up resources
    singleVideoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool completed =
        Constants.completedUnits.contains(Constants.units[widget.unit]);
    return Scaffold(
      backgroundColor: const Color(0xfff2f3f7),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                      'assets/nextrev.png',
                      height: 30,
                    ),
                  )
                ],
              ),
            ),
            Text(
              "${Constants.units[widget.unit]} : ${Constants.titles[widget.unit]}",
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            const SizedBox(
              height: 20,
            ),
            Material(
              elevation: 4, // Set the elevation value here (change as needed)
              borderRadius: BorderRadius.circular(20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Container(
                  height: ((MediaQuery.of(context).size.width * 0.86) * 16) / 9,
                  width: MediaQuery.of(context).size.width * 0.86,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: VideoPlayer(singleVideoController),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(23.0),
              child: GestureDetector(
                onTap: () {
                  print("💖💖💖💖💖💖💖💖💖💖");
                  if (!completed) {
                    DatabaseService()
                        .updateUnitComplete((Constants.units[widget.unit]))
                        .then((value) => setState(() {
                              completed = true;
                            }));
                  }
                },
                child: Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                      color: !completed
                          ? const Color(0xffEFD28D)
                          : const Color(0xff55D6BE),
                      borderRadius: BorderRadius.circular(12)),
                  child: Center(
                    child: Text(
                      !completed ? "Mark Complete?" : "Completed 👍",
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
