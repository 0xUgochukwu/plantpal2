import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


import 'package:plant_app/components/profile_menu.dart';
import 'package:plant_app/components/profile_pic.dart';
import 'package:plant_app/constants.dart';
import 'package:plant_app/models/update_profile.dart';


class ProfileScreen extends StatelessWidget {
  final String uid;

  ProfileScreen({required this.uid});
  @override
  Widget build(BuildContext context) {
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
                "John Doe",
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
                "@" + "johndoe",
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),

            SizedBox(height: 20),
            ProfileMenu(
              text: "Edit Profile",
              icon: "images/icons/edit-profile.svg",
              press: () => {
              showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) => Form(uid: uid),
              )
              },
            ),
            ProfileMenu(
              text: "Payment Information",
              icon: "images/icons/payment.svg",
              press: () {},
            ),
            ProfileMenu(
              text: "Help Center",
              icon: "images/icons/Question mark.svg",
              press: () {},
            ),
            ProfileMenu(
              text: "Log Out",
              icon: "images/icons/Log out.svg",
              press: () {},
            ),
          ],
        ),
      ),
    );
  }
}


class Form extends StatefulWidget {
  final String uid;
  const Form({Key? key, required this.uid}) : super(key: key);

  @override
  State<Form> createState() => _FormState(uid);
}

class _FormState extends State<Form> {

  final String uid;
  _FormState(this.uid);


  final _username = TextEditingController();
  final _fullname = TextEditingController();
  final _address = TextEditingController();

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
                  controller: _username,
                  style: const TextStyle(
                      color: Colors.black, fontFamily: 'SFUIDisplay'),
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
                          "Full Name",
                        ),
                      )
                    ],
                  ),
                ),
                TextField(
                  cursorColor:Colors.green,
                  controller: _fullname,
                  style: const TextStyle(
                      color: Colors.black, fontFamily: 'SFUIDisplay'),
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
                    labelText: 'Enter Full Name',
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
                  controller: _address,
                  style: const TextStyle(
                      color: Colors.black, fontFamily: 'SFUIDisplay'),
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
                      if(_username.text.isNotEmpty && _fullname.text.isNotEmpty && _address.text.isNotEmpty){
                        //add it to database
                        updateUserData(uid, _username.text, _fullname.text, _address.text);
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