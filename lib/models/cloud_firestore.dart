import 'package:a_level_pro/data/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class DatabaseService {
  // This function runs simultaneously with the registration function in order to create a document of the user
  //The doc id is the email address of the user. It also generates referral code using generateRandomString()
  //function.
  Future addUser({
    required String fullName,
    required String age,
    required String email,
  }) async {
    List referrals = [];
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      users.get().then((value) => {
            for (final docs in value.docs) {referrals.add(docs['referralID'])}
          });
      String referralId = Constants.generateRandomString();
      while (referrals.contains(referralId)) {
        referralId = Constants.generateRandomString();
      }
      await users.doc(email).set({
        'full_name': fullName,
        'age': age,
        'referralID': referralId,
        'referrals': 0
      });
      if(Constants.referrerEmail != ''){
          final user = FirebaseFirestore.instance.collection('users').doc(Constants.referrerEmail);
          user.update({'referrals': FieldValue.increment(1)});
      }

      return 'success';
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return e.toString();
    }
  }

  // this function runs when home page opens and fetches the user data to show on the screen.
  Future<String?> getUser() async {
    try {
      var email = FirebaseAuth.instance.currentUser?.email.toString();
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      final snapshot = await users.doc(email).get();
      final data = snapshot.data() as Map<String, dynamic>;
      Constants.referralId = data['referralID'];
      Constants.numberOfReferrals = data['referrals'];
      return 'Success';
    } catch (e) {
      return 'Error fetching user';
    }
  }

  // function used while registering for referring others.
  Future addReferral(String code) async {
    try {
      var found = false;
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      final snapshot = await users.get();
      final data = snapshot.docs;
      for (final user in data) {
        var info = user.data() as Map<String, dynamic>;
        if (info['referralID'].toString() == code) {
          Constants.referrerEmail = user.id;
          return true;
        }
      }
      return found;

      // if (found) {

      //   return true;
      // } else {
      //   return false;
      // }
    } catch (e) {
      return 'Error fetching user';
    }
  }
  Future emailExists(String email) async {
    try {
      CollectionReference users =
      FirebaseFirestore.instance.collection('users');
      final snapshot = await users.get();
      final data = snapshot.docs;
      for (final user in data) {
        if(user.id == email){
          return false;
        }
      }
      return true;
    } catch (e) {
      return 'Error fetching user';
    }
  }
// This function runs when the video player is opened. It takes the name of the chapter, and fetches all the
  // topics titles, urls and notes links. Saves them in Constants file for quick access.
  Future listOfTopics(String chapter) async {
    final List topics = [];
    final List<String> urls = [];
    final List<String> units = [];
    final List<String> titles = [];
    final List notes = [];
    try {
      CollectionReference subjects =
          FirebaseFirestore.instance.collection('Subjects');
      final snapshot = await subjects.doc('Physics').collection(chapter).get();
      final data = snapshot.docs;
      for (final value in data) {
        topics.add(value.data());
      }
      for (final a in topics) {
        urls.add(a['url'].toString());
        units.add(a['unit'].toString());
        titles.add(a['title'].toString());
        notes.add(a['notes']);
      }
      Constants.urls = urls;
      Constants.units = units;
      Constants.titles = titles;
      Constants.notes = notes;
      return 'Success';
      // print(PCC.videoURLs.toString());
      // print(PCC.videoURLs.length);
      // return topics;
    } catch (e) {
      return 'Fail';
    }
  }

  //this function is a topic specific function as it just marks a topic complete. It also updates the constants
  // list to update the contents page instantly without another database call.
  Future updateUnitComplete(String unit) async {
    try {
      var name = (double.parse(unit)).toInt();
      var email = FirebaseAuth.instance.currentUser?.email.toString();
      final reference = FirebaseFirestore.instance
          .collection('users')
          .doc(email)
          .collection('Completed')
          .doc('Physics');
      reference.update({
        name.toString(): FieldValue.arrayUnion([unit])
      });
      Constants.completedUnits.add(unit);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return e.toString();
    }
  }

  // This function runs when a subject is selected and all its chapter names are loaded as well as how much
  //progress has been made on each chapter. Its fetches totals and units completed and calculates the ratios
  //and saves that ratio in the constants for quick access.
  Future unitCompletionCalculator() async {
    try {
      List ratios = [];
      List completed = [];
      List total = [];
      var email = FirebaseAuth.instance.currentUser?.email.toString();
      final reference2 =
          FirebaseFirestore.instance.collection('Subjects').doc('Physics');
      final snapshot2 = await reference2.get();
      final data2 = snapshot2.data() as Map<String, dynamic>;
      data2.forEach((key, value) {
        total.add(value.toString());
      });
      final reference = FirebaseFirestore.instance
          .collection('users')
          .doc(email)
          .collection('Completed')
          .doc('Physics');
      final snapshot = await reference.get();
      final data = snapshot.data() as Map<String, dynamic>;
      data.forEach((key, value) {
        var count = 0;
        for (var v in value) {
          completed.add(v.toString());
          count++;
        }
        ratios.add(count / (int.parse(data2[key])));
      });
      Constants.completedUnits = completed;
      total = [];
      return ratios;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return e.toString();
    }
  }
}
