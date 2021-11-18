import 'package:campuschool/constants/firebaseConstants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController{
  static AuthController instance = Get.find();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final CollectionReference userCollection = firebaseFirestore.collection("user") ;

  Future<User?> loginWithGoogle() async {
    User? user;

    if (kIsWeb) {
      GoogleAuthProvider authProvider = GoogleAuthProvider();

      try {
        final UserCredential userCredential =
        await auth.signInWithPopup(authProvider);

        user = userCredential.user;

        if (user != null && userCredential.additionalUserInfo!.isNewUser) {
          addUserToFirebase(
              user.uid,
              user.displayName.toString(),
              user.email.toString(),
              "I promise to take the test honestly before GOD.");
        }
      } catch (e) {
        print(e);
      }
    } else {
      final GoogleSignIn googleSignIn = GoogleSignIn();

      final GoogleSignInAccount? googleSignInAccount =
      await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        try {
          final UserCredential userCredential =
          await auth.signInWithCredential(credential);

          user = userCredential.user;

          if (user != null && userCredential.additionalUserInfo!.isNewUser) {
            addUserToFirebase(
              user.uid,
              user.displayName.toString(),
              user.email.toString(),
              "I promise to take the test honestly before GOD.",
            );
          }
        } on FirebaseAuthException catch (e) {
          print(e);
        } catch (e) {
          print(e);
        }
      }
      Get.offAllNamed('/landing');
      return user;
    }
  }

  addUserToFirebase(String uid, String displayName,
      String email, String status_massage) {
    userCollection.doc(uid).set({
      "uid": uid,
      "name": displayName,
      "email": email,
      "status_massage": status_massage,
    });
  }

  Future<void> logoutGoogle() async {
    await googleSignIn.signOut();
    Get.back(); // navigate to your wanted page after logout.
  }
}