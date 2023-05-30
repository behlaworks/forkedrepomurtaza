import 'package:cloud_firestore/cloud_firestore.dart';

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

  Future<String?> getUser(String email) async {
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      final snapshot = await users.doc(email).get();
      final data = snapshot.data() as Map<String, dynamic>;
      return data['full_name'];
    } catch (e) {
      return 'Error fetching user';
    }
  }

  Future listOfTopics(String chapter) async {
    final List topics = [];
    try {
      CollectionReference subjects =
          FirebaseFirestore.instance.collection('Subjects');
      final snapshot = await subjects.doc('Physics').collection(chapter).get();
      final data = snapshot.docs;
      for (final value in data) {
        topics.add(value.data());
      }
      return topics;
    } catch (e) {
      print(e.toString());
    }
  }
}
