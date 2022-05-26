import 'package:alu_express_student/services/Models/firebase_services.dart';
import 'package:alu_express_student/services/Models/user_model.dart';
import 'package:alu_express_student/ui_screens/cart_pages/card_item.dart';
import 'package:alu_express_student/ui_screens/homepage_ui/home_page.dart';
import 'package:alu_express_student/ui_screens/login_ui_screens/landing_page.dart';
import 'package:alu_express_student/ui_screens/profile_pages/change_profile_popup.dart';
import 'package:alu_express_student/ui_screens/shared_widgets/size_helpers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class StudentProfile extends StatefulWidget {
  final userid;
  StudentProfile({Key key, this.userid}) : super(key: key);

  @override
  _StudentProfileState createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
  final FirebaseServices firebaseServices = FirebaseServices();
  @override
  Widget build(BuildContext context) {
    print("userid");
    print(widget.userid);
    print((firebaseServices.getuser(widget.userid)));
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left_rounded,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HomePage(userid: widget.userid)));
          },
        ),
        title: Padding(
          padding: const EdgeInsets.fromLTRB(100.0, 0, 0, 0),
          child: Text(
            "Profile",
            style: GoogleFonts.ptSans(
                color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamProvider(
          create: (BuildContext context) =>
              firebaseServices.getuser(widget.userid),
          child: UserProfile(),
        ),
      ),
    );
  }
}

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final FirebaseServices firebaseServices = FirebaseServices();

  Position _currentPosition;
  String _currentAddress;

  _getCurrentLocation() {
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        _getAddressFromLatLng();
      });
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = placemarks[0];

      setState(() {
        _currentAddress =
            "${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    List userList = Provider.of<List<UserModel>>(context);

    print("userlist");
    print(userList);
    return userList == null
        ? SpinKitSquareCircle(
            color: Colors.amberAccent,
          )
        : Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: displayHeight(context) * 0.25,
                    width: displayWidth(context) * 0.3,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        CachedNetworkImage(
                          imageUrl: userList[0].profileUrl,
                          imageBuilder: (context, imageProvider) => Container(
                            width: 80.0,
                            height: 80.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover),
                            ),
                          ),
                          placeholder: (context, url) => SpinKitPulse(
                            color: Colors.amberAccent,
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 20,
                          child: SizedBox(
                            height: displayHeight(context) * 0.1,
                            width: displayWidth(context) * 0.1,
                            child: CircleAvatar(
                              backgroundColor: Colors.white54,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50))),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          ProfilePicEdit(
                                            docId: userList[0].documentId,
                                          ));
                                },
                                child: Icon(Icons.camera_alt_rounded,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: displayHeight(context) * .03,
                    child: (Text(
                      'Hello, ' + userList[0].fname,
                      style: GoogleFonts.ptSans(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          letterSpacing: .5,
                          color: Colors.red[900]),
                    )),
                  ),
                  SizedBox(
                    height: displayHeight(context) * .015,
                  ),
                  SizedBox(
                    width: displayWidth(context) * 0.3,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          primary: Colors.red[900]),
                      onPressed: () {
                        _getCurrentLocation();
                      },
                      child: Text(
                        "Get Location",
                        style: GoogleFonts.ptSans(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: displayHeight(context) * .03,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.0),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 21.0,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.location_pin,
                              size: 30,
                              color: Colors.red[900],
                            ),
                            SizedBox(width: displayWidth(context) * 0.06),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  "Location",
                                  style: GoogleFonts.ptSans(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: .3),
                                ),
                                SizedBox(height: 4.0),
                                if (_currentPosition != null)
                                  Text(
                                    _currentAddress,
                                    style: GoogleFonts.ptSans(
                                        fontSize: 14, letterSpacing: .3),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: displayHeight(context) * .03,
                  ),
                  CardItem(
                    iconData: Icon(
                      LineIcons.user,
                      color: Colors.red[900],
                      size: 30.0,
                    ),
                    textItem: 'FullName',
                    userData: userList[0].fname,
                  ),
                  SizedBox(
                    height: displayHeight(context) * .03,
                  ),
                  CardItem(
                    iconData: Icon(
                      Icons.email_outlined,
                      color: Colors.red[900],
                      size: 30.0,
                    ),
                    textItem: 'Email Address',
                    userData: userList[0].email,
                  ),
                  SizedBox(
                    height: displayHeight(context) * .03,
                  ),
                  CardItem(
                    iconData: Icon(
                      Icons.phone_android_rounded,
                      color: Colors.red[900],
                      size: 30.0,
                    ),
                    textItem: 'Phone Number',
                    userData: userList[0].phoneNumber,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 21.0,
                    ),
                    child: ListTile(
                      onTap: () {
                        firebaseServices.signOut();
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => LandingPage()),
                            (Route<dynamic> route) => false);
                      },
                      leading: Icon(
                        Icons.logout,
                        color: Colors.red[900],
                      ),
                      title: Text("Log Out",
                          style: GoogleFonts.ptSans(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
