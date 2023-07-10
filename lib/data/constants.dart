import 'dart:math';
import 'dart:ui';

import 'package:preload_page_view/preload_page_view.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class Constants{
  static Color dark = const Color(0xff07122a);
  static Color grey = const Color(0xffefefef);
  static List<String> subjects = ['Mathematics', 'Computer', 'Chemistry', 'Biology', 'English', 'Business', 'Accounts', 'Economics'];
  static List<String> physicsChapters = ['Physical quantities and units', 'Kinematics', 'Dynamics', 'Forces, density and pressure', 'Work, energy and power', 'Deformation of solids', 'Waves', 'Superposition', 'Electricity', 'D.C circuits', 'Particle Physics'];
  static List urls = [];
  static String referralId = '';
  static List units = [];
  static List titles = [];
  static List notes = [];
  static List months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'June', 'Jul', 'Aug', 'Sept', 'Oct', 'Nov', 'Dec'];
  static List weekdays = ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'];
  static List completedUnits = [];
  static int numberOfReferrals = 0;
  static PreloadPageController controller = PreloadPageController();
  static String name = '';
  static String age = '';
  static String email = '';
  static String referrerEmail = '';
  static String examDate = '';

  static int dayCalculator(DateTime date, int weekday) {
    if(date.weekday > weekday){
      return (date.subtract(Duration(days: date.weekday - weekday))).day;
    }else if (date.weekday < weekday){
      return (date.add(Duration(days: weekday - date.weekday))).day;
    } else{
      return date.day;
    }
  }

  // this function is used to generate referral code. this should be
  static String generateRandomString(){
    final random = Random();
    const allChars='AaBbCcDdlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1EeFfGgHhIiJjKkL234567890';
    // below statement will generate a random string of length using the characters
    // and length provided to it
    final randomString = List.generate(15,
            (index) => allChars[random.nextInt(allChars.length)]).join();
    return randomString;    // return the generated string
  }
  static Future<String> _extractVideoUrl() async {
    final extractor = YoutubeExplode();
    const videoId = 'EysVhq62624';
    final streamManifest =
    await extractor.videos.streamsClient.getManifest(videoId);
    final streamInfo = streamManifest.muxed.withHighestBitrate();
    extractor.close();
    print("url: ${streamInfo.url.toString()}");
    return streamInfo.url.toString();
  }

}