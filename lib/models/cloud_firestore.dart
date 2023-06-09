import 'package:a_level_pro/data/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  //TODO: create a loop which generated the random string again and again until it is unique from the database.
  Future<String?> addUser({
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
        'completed': []
      });

      return 'success';
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  Future<String?> getUser() async {
    try {
      var email = FirebaseAuth.instance.currentUser?.email.toString();
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      final snapshot = await users.doc(email).get();
      final data = snapshot.data() as Map<String, dynamic>;
      Constants.completedUnits = data['completed'];
      Constants.referralId = data['referralID'];
      return 'Success';
    } catch (e) {
      return 'Error fetching user';
    }
  }

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

  Future<String?> updateUnitComplete(String unit) async {
    try {
      var email = FirebaseAuth.instance.currentUser?.email.toString();
      final reference =
          FirebaseFirestore.instance.collection('users').doc(email);
      reference.update({
        "completed": FieldValue.arrayUnion([unit])
      });
      Constants.completedUnits.add(unit);
      return 'hello';
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  Future unitCompletionCalculator(String unit) async {
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
      final reference =
      FirebaseFirestore.instance.collection('users').doc(email).collection('Completed').doc('Physics');
      final snapshot = await reference.get();
      final data = snapshot.data() as Map<String, dynamic>;
      data.forEach((key, value) {
        var count = 0;
        for(var v in value){
         completed.add(v.toString());
         count ++;
        }
        ratios.add(count/(int.parse(data2[key])));
      });
      Constants.completedUnits = completed;
      total = [];
      return ratios;

    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }
}
