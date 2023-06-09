import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import '../data/constants.dart';

class PCC extends GetxController {
  int _api = 0;
  List<VideoPlayerController?> videoPlayerControllers = [];
  List<int> initilizedIndexes = [];
  bool autoplay = true;
  int get api => _api;

  void updateAPI(int i) {
    if (videoPlayerControllers[_api] != null) {
      videoPlayerControllers[_api]!.pause();
    }
    _api = i;
    print("_api : ${_api.toString()}");
    update();
  }

  Future initializePlayer(int i) async {
    var hello = [];
    print('initializing $i');

    if (i < 0 || i >= Constants.urls.length) {
      // Invalid index, handle accordingly
      return;
    }

    late VideoPlayerController singleVideoController;
    singleVideoController = VideoPlayerController.network(Constants.urls[i]);

    if (videoPlayerControllers.length <= i) {
      // Expand the list to accommodate the new index
      videoPlayerControllers.addAll(List<VideoPlayerController?>.filled(i + 1, null));
    }

    if (videoPlayerControllers[i] != null) {
      // Dispose the existing controller before reinitializing
      await videoPlayerControllers[i]!.dispose();
    }

    videoPlayerControllers[i] = singleVideoController;
    initilizedIndexes.add(i);

    for (var e in videoPlayerControllers) {
      if (e != null) {
        hello.add('Not null');
      } else {
        hello.add('null');
      }
    }

    print("videoPlayerControllers: ${hello.toString()}");
    print("initialized Indexes: ${initilizedIndexes.toString()}");

    await videoPlayerControllers[i]!.initialize();
    update();
  }

  Future initializeIndexedController(int index) async {
    if (index >= 0 && index < videoPlayerControllers.length) {
      if (videoPlayerControllers[index] == null) {
        late VideoPlayerController singleVideoController;
        print('$index : ${videoPlayerControllers.length}');
        singleVideoController = VideoPlayerController.network(Constants.urls[index]);
        videoPlayerControllers[index] = singleVideoController;
        await videoPlayerControllers[index]!.initialize();
        update();
      }
    }
  }

  Future<void> disposeController(int i) async {
    if (i >= 0 && i < videoPlayerControllers.length && videoPlayerControllers[i] != null) {
      await videoPlayerControllers[i]!.dispose();
      videoPlayerControllers[i] = null;
    }
  }
  Future disposeAll() async{
    // Create a copy of the list to avoid modifying it while iterating
    final List<VideoPlayerController?> controllersCopy = List.from(videoPlayerControllers);

    for (final controller in controllersCopy) {
      controller?.pause();
      controller?.dispose();
    }

    // Clear the original list
    videoPlayerControllers.clear();
    initilizedIndexes.clear();
    _api = 0;
    update();
    print(" _api : ${_api.toString()}");
    print("initialized indexes: ${initilizedIndexes.toString()}");
    print("videoPlayerController: ${videoPlayerControllers.toString()}");
  }

  final List<String> videoURLs = [
    'https://assets.mixkit.co/videos/preview/mixkit-young-mother-with-her-little-daughter-decorating-a-christmas-tree-39745-large.mp4',
    'https://assets.mixkit.co/videos/preview/mixkit-mother-with-her-little-daughter-eating-a-marshmallow-in-nature-39764-large.mp4',
    'https://assets.mixkit.co/videos/preview/mixkit-taking-photos-from-different-angles-of-a-model-34421-large.mp4',
    'https://assets.mixkit.co/videos/preview/mixkit-girl-in-neon-sign-1232-large.mp4',
    'https://assets.mixkit.co/videos/preview/mixkit-winter-fashion-cold-looking-woman-concept-video-39874-large.mp4',
    'https://assets.mixkit.co/videos/preview/mixkit-womans-feet-splashing-in-the-pool-1261-large.mp4',
    'https://assets.mixkit.co/videos/preview/mixkit-a-girl-blowing-a-bubble-gum-at-an-amusement-park-1226-large.mp4'
  ];
}