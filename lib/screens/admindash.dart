import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plant_app/screens/plant_details_screen.dart';
import '../components/curve.dart';
import '../constants.dart';
import '../data.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  static const String id = 'admin';

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Flexible(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Text(
                          'Admin DashBoard',
                          textAlign: TextAlign.start,
                          style: GoogleFonts.poppins(
                            color: kDarkGreenColor,
                            fontSize: 25.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    TextField(
                      style: TextStyle(color: kDarkGreenColor),
                      cursorColor: kDarkGreenColor,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: kGinColor,
                        hintText: 'Search Plant',
                        hintStyle: TextStyle(color: kGreyColor),
                        prefixIcon: Icon(
                          Icons.search,
                          color: kDarkGreenColor,
                          size: 26.0,
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.mic),
                          color: kDarkGreenColor,
                          iconSize: 26.0,
                          splashRadius: 20.0,
                          onPressed: () {},
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: kGinColor),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: kGinColor),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: kGinColor),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4.0),
                  ],
                ),
              ),
              Expanded(
                flex: 9,
                child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GridView.builder(
                            clipBehavior: Clip.none,
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: recommended.length,
                            itemBuilder: (context, index) {
                              return PlantCarded(
                                plantType: recommended[index].plantType,
                                plantName: recommended[index].plantName,
                                plantPrice: recommended[index].plantPrice,
                                image: Image.asset(
                                  recommended[index].image,
                                  alignment: Alignment.topLeft,
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return PlantDetails(
                                          plant: recommended[index],
                                        );
                                      },
                                    ),
                                  );
                                },
                              );
                            }, gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200,
                              // childAspectRatio: 3 / 2,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20
                          ),
                          ),                        ],
                      ),
                    ),

              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: kDarkGreenColor,
          child: Icon(Icons.add), //child widget inside this button
          onPressed: (){
            //task to execute when this button is pressed
            showModalBottomSheet(context: context,isScrollControlled: true, builder: (__)=> const Form());
          },
        ),
      ),
    );
  }
}

class RecentlyViewedCard extends StatelessWidget {
  const RecentlyViewedCard({
    required this.plantName,
    required this.plantInfo,
    required this.image,
    Key? key,
  }) : super(key: key);

  final String plantName;
  final String plantInfo;
  final ImageProvider<Object> image;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 60.0,
          height: 60.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: image,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        const SizedBox(width: 24.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              plantName,
              style: GoogleFonts.poppins(
                color: kDarkGreenColor,
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              plantInfo,
              style: GoogleFonts.poppins(
                color: kGreyColor,
              ),
            )
          ],
        ),
      ],
    );
  }
}

class PlantCarded extends StatelessWidget {
  const PlantCarded({
    required this.plantType,
    required this.plantName,
    required this.plantPrice,
    required this.image,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  final String plantType;
  final String plantName;
  final double plantPrice;
  final Image image;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 220.0,
            width: 185.0,
            decoration: BoxDecoration(
              color: kGinColor,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: CustomPaint(
              painter: CurvePainter(),
            ),
          ),
          Positioned(
            // height: 240.0,
            // width: 124.0,
            left: 8.0,
            bottom: 70.0,
            child: Container(
              constraints:
              const BoxConstraints(maxWidth: 70.0, maxHeight:70.0),
              child: Hero(tag: plantName, child: image),
            ),
          ),
          Positioned(
            left: 55.0,
            bottom: 50.0,
            child: Container(
              width: 90,
              height: 95.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            plantType,
                            style: TextStyle(
                              color: kDarkGreenColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 2.0),
                          Expanded(
                            child: Text(
                              plantName,
                              overflow: TextOverflow.fade,
                              maxLines: 1,
                              softWrap: false,
                              style: TextStyle(
                                color: kDarkGreenColor,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 6.0,
                        horizontal: 10.0,
                      ),
                      decoration: BoxDecoration(
                        color: kFoamColor,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      constraints: const BoxConstraints(maxWidth: 90.0),
                      child: Text(
                        '₹${plantPrice}0',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        softWrap: false,
                        style: TextStyle(
                          color: kDarkGreenColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 12.8,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            child: Container(
              width: 145,
              height: 60.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Flexible(
                      child: ClipOval(
                        child: Material(
                          color: kDarkGreenColor,// Button color
                          child: InkWell(
                            splashColor: kGinColor, // Splash color
                            onTap: () {},
                            child: SizedBox(width: 30, height: 30, child: Icon(Icons.edit, size:18, color: kGinColor,)),
                          ),
                        ),
                      )
                    ),
                    Flexible(
                        child: ClipOval(
                          child: Material(
                            color: kDarkGreenColor, // Button color
                            child: InkWell(
                              splashColor:kGinColor, // Splash color
                              onTap: () {

                              },
                              child: SizedBox(width: 30, height: 30, child: Icon(Icons.remove, size:18, color: kGinColor,)),
                            ),
                          ),
                        )
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
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
  DateTime? _date;
  String _initialValue = 'Other';

  //
  _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2022),
        lastDate: DateTime.now());
    if (pickedDate != null) {
      setState(() {
        _date = pickedDate;
      });
    }
  }

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
                          "Plant Name",
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
                    labelText: 'Enter Plant Name',
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
                          "Amount",
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
                    labelText: 'Enter Plant Amount',
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
                          "Description",
                        ),
                      )
                    ],
                  ),
                ),
                TextField(
                  controller: _amount,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(
                      color: Colors.white, fontFamily: 'SFUIDisplay'),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                        vertical: height * 0.023, horizontal: width * 0.03),
                    filled: true,
                    fillColor:kSpiritedGreen.withOpacity(0.1),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(
                        color: Color(0xFF184A2C),
                      ),
                    ),
                    labelText: 'Enter Plant Description',
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
                          "Plant Height",
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
                    labelText: 'Enter Plant Height',
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
                          "Plant Humidity",
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
                    labelText: 'Enter Plant Humidity',
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
                          "Plant Width",
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
                    labelText: 'Enter Plant Width',
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
                        'Add Plant',
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