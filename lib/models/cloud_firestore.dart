import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

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

  Future<List<Map<String, dynamic>>> _loadVideos() async {
    List<Map<String, dynamic>> files = [];
    FirebaseStorage storage = FirebaseStorage.instance;
    final ListResult result = await storage.ref().list();
    final List<Reference> allFiles = result.items;

    await Future.forEach<Reference>(allFiles, (file) async {
      final String fileUrl = await file.getDownloadURL();
      final FullMetadata fileMeta = await file.getMetadata();
      files.add({
        "url": fileUrl,
        "path": file.fullPath,
        // "uploaded_by": fileMeta.customMetadata?['uploaded_by'] ?? 'Nobody',
        // "description":
        // fileMeta.customMetadata?['description'] ?? 'No description'
      });
    });

    return files;
  }
}