import 'package:firebase_auth/firebase_auth.dart';

class FireAuth {
  static Future<String> registerUsingEmailPassword({
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
      user = auth.currentUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        return 'Weak Password';
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        return 'Email already in use';
      }
    } catch (e) {
      print(e);
    }
    return 'Success';
  }

  static Future signInUsingEmailPassword({
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        return 'user not found';
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided.');
        return 'incorrect password';
      }
    }

    return 'success';
  }
// static Future<User?> signInWithGoogle({required BuildContext context}) async {
//   FirebaseAuth auth = FirebaseAuth.instance;
//   User? user;
//
//   if (kIsWeb) {
//     GoogleAuthProvider authProvider = GoogleAuthProvider();
//
//     try {
//       final UserCredential userCredential =
//       await auth.signInWithPopup(authProvider);
//
//       user = userCredential.user;
//     } catch (e) {
//       print(e);
//     }
//   } else {
//     final GoogleSignIn googleSignIn = auth.GoogleSignIn();
//
//     final GoogleSignInAccount? googleSignInAccount =
//     await googleSignIn.signIn();
//
//     if (googleSignInAccount != null) {
//       final GoogleSignInAuthentication googleSignInAuthentication =
//       await googleSignInAccount.authentication;
//
//       final AuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleSignInAuthentication.accessToken,
//         idToken: googleSignInAuthentication.idToken,
//       );
//
//       try {
//         final UserCredential userCredential =
//         await auth.signInWithCredential(credential);
//
//         user = userCredential.user;
//       } on FirebaseAuthException catch (e) {
//         if (e.code == 'account-exists-with-different-credential') {
//           // ...
//         } else if (e.code == 'invalid-credential') {
//           // ...
//         }
//       } catch (e) {
//         // ...
//       }
//     }
//   }
//
//   return user;
// }
}
