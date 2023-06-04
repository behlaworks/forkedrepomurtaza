import 'dart:ui';

class Constants{
  static Color dark = const Color(0xff07122a);
  static Color grey = const Color(0xffefefef);
  static List<String> subjects = ['Mathematics', 'Computer', 'Chemistry', 'Biology', 'English', 'Business', 'Accounts', 'Economics'];
  static List<String> physicsChapters = ['Physical quantities and units', 'Kinematics', 'Dynamics', 'Forces, density and pressure', 'Work, energy and power', 'Deformation of solids', 'Waves', 'Superposition', 'Electricity', 'D.C circuits', 'Particle Physics'];
  static List urls = [];
  static List units = [];
  static List titles = [];
  static List notes = [];
  static List months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'June', 'Jul', 'Aug', 'Sept', 'Oct', 'Nov', 'Dec'];
  static List weekdays = ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'];

  static int dayCalculator(DateTime date, int weekday) {
    if(date.weekday > weekday){
      return (date.subtract(Duration(days: date.weekday - weekday))).day;
    }else if (date.weekday < weekday){
      return (date.add(Duration(days: weekday - date.weekday))).day;
    } else{
      return date.day;
    }
  }

}