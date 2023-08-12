import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:plant_app/screens/home_screen.dart';
import 'package:plant_app/screens/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
Future<void> login(BuildContext context, String email, String password) async {
  try {
    final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    String? authToken = await userCredential.user!.getIdToken();
    await storeToken(authToken!);
    String userData = userCredential.user!.uid;
    print('Login successful: ${userCredential.user!.uid}');
    Navigator.push(context, MaterialPageRoute(builder: (context)=>MainScreen(uid: userData)));
  } catch (e) {
    print('Login failed: $e');
  }
}
Future<void> storeToken(String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('token', token);
}
