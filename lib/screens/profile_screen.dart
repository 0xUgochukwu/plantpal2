import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


import 'package:plant_app/components/profile_menu.dart';
import 'package:plant_app/components/profile_pic.dart';
import 'package:plant_app/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_screen.dart';


class ProfileScreen extends StatelessWidget {
  final String uid;
  ProfileScreen({
    required this.uid,
    super.key});
  String? fullName;
  String? email;
  String? userName;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> fetchUserDetails(String uid) async {
    try {
      DocumentSnapshot snapshot = await _firestore.collection('users').doc(uid).get();
      if (snapshot.exists) {
        // User details retrieved successfully
        Map<String, dynamic> userData = snapshot.data() as Map<String, dynamic>;
        fullName = userData['full_Name'];
        email = userData['email'];
        userName = userData['username'];

      } else {
        print('User not found');
      }
    } catch (e) {
      print('Error fetching user details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {

    void logout() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear(); // Remove the stored token
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
    return FutureBuilder<void>(
      future: fetchUserDetails(uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        } else {
          final userData = snapshot.data;
          print('User Details: $fullName');
          return Scaffold(
            // align the appbar title to center
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              leadingWidth: 0.0,

              title: Center(
                child: Text(
                  "My Profile",
                  style: GoogleFonts.poppins(
                    color: kDarkGreenColor,
                    fontSize: 22.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  ProfilePic(),
                  SizedBox(height: 10),
                  Center(
                    child: Text(
                      "$fullName",
                      style: TextStyle(
                        color: kDarkGreenColor,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                   Center(
                    child: Text(
                      "${email}",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ProfileMenu(
                    text: "Edit Profile",
                    icon: "images/icons/edit-profile.svg",
                    press: () => {
                      showModalBottomSheet(context: context,isScrollControlled: true, builder: (__)=> const Form())
                    },
                  ),
                  ProfileMenu(
                    text: "Help Center",
                    icon: "images/icons/Question mark.svg",
                    press: () {},
                  ),
                  ProfileMenu(
                    text: "Log Out",
                    icon: "images/icons/Log out.svg",
                    press: logout,
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}


class Form extends StatefulWidget {
  const Form({Key? key}) : super(key: key);

  @override
  State<Form> createState() => _FormState();
}

class _FormState extends State<Form> {
  final _title = TextEditingController();
  final _amount = TextEditingController();
  String _initialValue = 'Other';

  //
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      padding: EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          "Username",
                        ),
                      )
                    ],
                  ),
                ),
                TextField(
                  cursorColor:Colors.green,
                  controller: _title,
                  style: const TextStyle(
                      color: Colors.white, fontFamily: 'SFUIDisplay'),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                        vertical: height * 0.023, horizontal: width * 0.03),
                    filled: true,
                    fillColor: kSpiritedGreen.withOpacity(0.1),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(
                        color: Colors.green,
                      ),
                    ),
                    labelText: 'Enter New Username',
                    labelStyle: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        color: Color(0xFF1E1E1E),
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 20.0,
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          "Email",
                        ),
                      )
                    ],
                  ),
                ),
                TextField(
                  cursorColor:Colors.green,
                  controller: _title,
                  style: const TextStyle(
                      color: Colors.white, fontFamily: 'SFUIDisplay'),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                        vertical: height * 0.023, horizontal: width * 0.03),
                    filled: true,
                    fillColor: kSpiritedGreen.withOpacity(0.1),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(
                        color: Colors.green,
                      ),
                    ),
                    labelText: 'Enter New Email',
                    labelStyle: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        color: Color(0xFF1E1E1E),
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 20.0,
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          "Address",
                        ),
                      )
                    ],
                  ),
                ),
                TextField(
                  cursorColor:Colors.green,
                  controller: _title,
                  style: const TextStyle(
                      color: Colors.white, fontFamily: 'SFUIDisplay'),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                        vertical: height * 0.023, horizontal: width * 0.03),
                    filled: true,
                    fillColor: kSpiritedGreen.withOpacity(0.1),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(
                        color: Colors.green,
                      ),
                    ),
                    labelText: 'Enter New Address',
                    labelStyle: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        color: Color(0xFF1E1E1E),
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 50.0,
            ),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                      ),
                      child: Text(
                        'Update Profile',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Color(0xFF184A2C)),
                    ),
                    onPressed: () {
                      if(_title.text != '' && _amount.text != ''){
                        //add it to database
                        //close the bottomsheet
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}