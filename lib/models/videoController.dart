import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import '../data/constants.dart';

class PCC extends GetxController {
  bool paused = false;
  int _api = 0;
  List<VideoPlayerController?> videoPlayerControllers = [];
  List<int> _initializedIndexes = [];
  bool autoplay = true;
  int get api => _api;
  List<int> get initializedIndexes => _initializedIndexes;

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
    singleVideoController = VideoPlayerController.networkUrl(Uri.parse(Constants.urls[i]));

    if (videoPlayerControllers.length <= i) {
      // Expand the list to accommodate the new index
      videoPlayerControllers.addAll(List<VideoPlayerController?>.filled(i + 1, null));
    }

    if (videoPlayerControllers[i] != null) {
      // Dispose the existing controller before reinitializing
      await videoPlayerControllers[i]!.dispose();
    }

    videoPlayerControllers[i] = singleVideoController;
    initializedIndexes.add(i);

    for (var e in videoPlayerControllers) {
      if (e != null) {
        hello.add('Not null');
      } else {
        hello.add('null');
      }
    }

    print("videoPlayerControllers: ${hello.toString()}");
    print("initialized Indexes: ${initializedIndexes.toString()}");

    await videoPlayerControllers[i]!.initialize();
    update();

    // Preload adjacent videos
    await preloadAdjacentVideos(i);
  }

  Future preloadAdjacentVideos(int currentIndex) async {
    // Preload video one before the current video
    if (currentIndex > 0) {
      await initializeIndexedController(currentIndex - 1);
    }

    // Preload video one after the current video
    if (currentIndex < Constants.urls.length - 1) {
      await initializeIndexedController(currentIndex + 1);
    }
  }

  Future initializeIndexedController(int index) async {
    if (index >= 0 && index < videoPlayerControllers.length) {
      if (videoPlayerControllers[index] == null) {
        late VideoPlayerController singleVideoController;
        print('$index : ${videoPlayerControllers.length}');
        singleVideoController = VideoPlayerController.networkUrl(Uri.parse(Constants.urls[index]));
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
  void togglePaused() {
    if (videoPlayerControllers.isNotEmpty &&
        api >= 0 &&
        api < videoPlayerControllers.length &&
        videoPlayerControllers[api]!.value.isInitialized) {
      if (videoPlayerControllers[api]!.value.isPlaying) {
        videoPlayerControllers[api]!.pause();
      } else {
        videoPlayerControllers[api]!.play();
      }
    }
    update(); // Notify listeners that the state has changed
  }
  Future<void> disposeAllExceptTarget(int targetIndex) async {
    // Dispose all video controllers except the target video
    for (int i = 0; i < videoPlayerControllers.length; i++) {
      if (i != targetIndex) {
        await disposeController(i);
      }
    }
  }

  Future disposeAll() async {
    // Create a copy of the list to avoid modifying it while iterating
    final List<VideoPlayerController?> controllersCopy = List.from(videoPlayerControllers);

    for (final controller in controllersCopy) {
      controller?.pause();
      controller?.dispose();
    }

    // Clear the original list
    videoPlayerControllers.clear();
    initializedIndexes.clear();
    _api = 0;
    update();
    print(" _api : ${_api.toString()}");
    print("initialized indexes: ${initializedIndexes.toString()}");
    print("videoPlayerController: ${videoPlayerControllers.toString()}");
  }
}