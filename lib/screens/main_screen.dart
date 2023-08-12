import 'package:flutter/material.dart';
import 'package:plant_app/components/bottom_nav_bar.dart';
import 'package:plant_app/constants.dart';
import 'package:plant_app/screens/cart_screen.dart';
import 'package:plant_app/screens/home_screen.dart';
import 'package:plant_app/screens/signup_screen.dart';

class MainScreen extends StatefulWidget {
  final String uid;
  const MainScreen({
    required this.uid,
    Key? key}) : super(key: key);

  static const String id = 'MainScreen';


  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int selectedIndex;

  late List<Widget> screens;
  @override
  void initState(){
    super.initState();
    selectedIndex = 0;
    screens = [
      HomeScreen(uid: widget.uid),
      HomeScreen(uid: widget.uid),
      CartScreen(),
      SignupScreen(),
    ];
  }

  @override
  Widget build(BuildContext context, ) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leadingWidth: 0,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              child: CircleAvatar(
                backgroundColor: kDarkGreenColor,
                radius: 22.0,
                backgroundImage: const AssetImage('images/Dhairye.jpg'),
              ),
              onTap: () {},
            ),
            CircleAvatar(
              backgroundColor: kDarkGreenColor,
              radius: 22.0,
              child: IconButton(
                color: Colors.white,
                splashRadius: 28.0,
                icon: const Icon(
                  Icons.shopping_cart_outlined,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, CartScreen.id);
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: selectedIndex,
        selectedColor: kDarkGreenColor,
        unselectedColor: kSpiritedGreen,
        onTapped: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: const [
          Icon(Icons.home),
          Icon(Icons.image_search_outlined),
          Icon(Icons.shopping_cart_outlined),
          Icon(Icons.person),
        ],
      ),
      body: screens[selectedIndex],
    );
  }
}
