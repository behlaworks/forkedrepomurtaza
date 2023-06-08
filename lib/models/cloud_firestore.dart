import 'package:a_level_pro/data/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  Future<String?> addUser({
    required String fullName,
    required String age,
    required String email,
  }) async {
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      await users.doc(email).set({
        'full_name': fullName,
        'age': age,
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
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }
}
