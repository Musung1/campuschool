import 'package:campuschool/constants/firebaseConstants.dart';
import 'package:campuschool/model/user_model.dart';
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
          kUser newUser = kUser(
            name : user.displayName!,
            uid : user.uid,
            email : user.email!,
            takedClass: [],
            myClass: [],
            status_massage: "I promise to take the test honestly before GOD.",
          );
          addUserToFirebase(newUser);
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
            kUser newUser = kUser(
              name : user.displayName!,
              uid : user.uid,
              email : user.email!,
              takedClass: [],
              myClass: [],
              status_massage: "I promise to take the test honestly before GOD.",
            );
            addUserToFirebase(newUser);
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

  addUserToFirebase(kUser user) {
    userCollection.doc().set({
      "uid": user.uid,
      "name": user.name,
      "email": user.email,
      "status_massage": user.status_massage,
      "takedClass" : user.takedClass,
      "myClass" : user.myClass,
    });
  }

  Future<void> logoutGoogle() async {
    await googleSignIn.signOut();
    Get.back(); // navigate to your wanted page after logout.
  }
}