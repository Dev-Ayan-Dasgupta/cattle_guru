import 'package:cattle_guru/utils/helper_functions/show_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignOut{
  static Future<void> signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      ShowSnackbar.showSnackBar(context, e.message!);
    }
  }

}