import 'package:fan_verse/features/screens/home/home_screen.dart';
import 'package:fan_verse/service/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServiceMethods {
  final FirebaseAuth auth = FirebaseAuth.instance;

  User? getCurrentUser() {
    return auth.currentUser;
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn.instance;
      await googleSignIn.initialize();

      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.authenticate();
      
      if (googleSignInAccount == null) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Google sign-in was cancelled')),
          );
        }
        return;
      }

      final GoogleSignInAuthentication googleAuth = googleSignInAccount.authentication;

      if (googleAuth.idToken == null) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to get authentication token. Please try again.')),
          );
        }
        return;
      }

      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken!,
      );

      final UserCredential result = await auth.signInWithCredential(credential);
      final User? userDetails = result.user;

      if (userDetails == null) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Google sign-in failed. Please try again.')),
          );
        }
        return;
      }

      final Map<String, dynamic> userInfoMap = {
        'email': userDetails.email,
        'name': userDetails.displayName,
        'imgUrl': userDetails.photoURL,
        'id': userDetails.uid,
      };

      await DatabaseMethods().addUser(userDetails.uid, userInfoMap);

      if (!context.mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message ?? 'Firebase authentication failed')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Google sign-in failed: $e')),
        );
      }
    }
  }
}
