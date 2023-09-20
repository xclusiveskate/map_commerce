// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:map_commerce/controllers/database.dart';
import 'package:map_commerce/models/seller_model.dart';
import 'package:map_commerce/utils/snackbar.dart';

class Authentication {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static signUserUpWithGoogle(BuildContext context) async {
    try {
      if (kIsWeb) {
        final GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();
        googleAuthProvider
            .addScope("https://www.googleapis.com/auth/contacts.readonly");
        UserCredential res = await _auth.signInWithPopup(googleAuthProvider);
        Database.saveUserData(res);
      } else {
        GoogleSignInAccount? gSignIn = await GoogleSignIn(
                // scopes: [
                //   'https://www.googleapis.com/auth/drive',
                // ],
                )
            .signIn();

        GoogleSignInAuthentication? gAuth = await gSignIn!.authentication;

        OAuthCredential cred = GoogleAuthProvider.credential(
            idToken: gAuth.idToken, accessToken: gAuth.accessToken);
        print(cred);

        UserCredential res = await _auth.signInWithCredential(cred);
        Database.saveUserData(res);
      }
    } on PlatformException catch (e) {
      if (e.code == GoogleSignIn.kNetworkError) {
        String errorMessage =
            "A network error (such as timeout, interrupted connection or unreachable host) has occurred.";
        // errorCallback(errorMessage);
        showSnackBar(context: context, message: errorMessage);
      } else {
        String errorMessage = "Something went wrong.";
        // errorCallback(errorMessage);
        showSnackBar(context: context, message: errorMessage);
        print(e.message);
      }
    }
  }

  static signOut() {
    _auth.signOut();
  }

  static signAdminUpWithEmailAndPassword(
      {required BuildContext context,
      required String displayName,
      required String storeName,
      required String email,
      required String password,
      required String storeDescription,
      required String photoUrl}) async {
    try {
      UserCredential res = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final uid = res.user!.uid;
      Seller seller = Seller(
          userId: uid,
          displayName: displayName,
          photoUrl: photoUrl,
          storeName: storeName,
          storeDescription: storeDescription,
          email: email,
          password: password);

      _db.collection('seller').doc(uid).set(seller.toJson());
      showSnackBar(
          context: context,
          message: 'You have successfully signed up, log in to continue');
    } on FirebaseAuthException catch (e) {
      String message = e.message!;
      switch (e.code) {
        case 'email-already-in-use':
          message = "Email already in use,  use another email";
          break;
        case 'invalid-email':
          message = "Enter a valid e-mail";
          break;
        case 'weak-password':
          message = "password must be more than 6 characters";
          break;
        case 'operation-not-allowed':
          message = "operation not allowed";
          break;
        default:
      }
      showSnackBar(context: context, message: message);
    } catch (e) {
      print(e.toString());
    }
  }

  static signInAdminWithEmail(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      showSnackBar(context: context, message: "You successfully logged in");
    } on FirebaseAuthException catch (e) {
      String message = e.message!;
      switch (e.code) {
        case 'invalid-email':
          message = "invalid email";
          break;
        case 'user-disabled':
          message = "Your account has been disabled, contact customer service";
          break;

        case 'user-not-found':
          message = "user does not exist";
          break;
        case 'wrong-password':
          message = "incorrect password";
          break;
        default:
      }
      showSnackBar(context: context, message: message);
    } catch (e) {
      showSnackBar(context: context, message: " Couldn't sign in");
    }
  }
}
