import 'package:chatsy/routes/route_names.dart';
import 'package:chatsy/services/firebase_auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider extends ChangeNotifier {
  bool isLoading = false;

  var _auth = FirebaseAuthServices();
  Future<void> phnoLogin(String phno, BuildContext context) async {
    isLoading = true;
    notifyListeners();
    try {
      await _auth.phNoAuth(phno);
      Navigator.pushNamed(context, RouteName.otpRoute);
      isLoading = false;
    } on FirebaseAuthException catch (e) {
      isLoading = false;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message.toString())));
    }
  }

  Future<void> signIn(String otp, BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();
      await _auth.signIn(otp);
      Navigator.pushNamed(context, RouteName.registerRoute);
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  Future<void> setBool(bool choice) async {
    final SharedPreferences sPref = await SharedPreferences.getInstance();
    sPref.setBool("IsLoggedIn", choice);
  }

  Future<void> signOut(BuildContext context) async {
    isLoading = true;
    try {
      await FirebaseAuth.instance.signOut();
      await setBool(false);
      Navigator.pushNamed(context, RouteName.loginRoute);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
    isLoading = false;
    notifyListeners();
  }
}
