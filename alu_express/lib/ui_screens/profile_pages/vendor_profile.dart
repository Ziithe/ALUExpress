import 'package:alu_express/services/Models/services.dart';
import 'package:alu_express/services/Models/user_model.dart';
import 'package:alu_express/ui_screens/extras/size_helpers.dart';
import 'package:alu_express/ui_screens/homepage_ui/home_page.dart';
import 'package:alu_express/ui_screens/login_ui_screens/landing_page.dart';
import 'package:alu_express/ui_screens/profile_pages/change_profile_pic.dart';
import 'package:alu_express/ui_screens/profile_pages/vendor_card.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class VendorPr extends StatefulWidget {
  final userID;
  VendorPr({Key key, @required this.userID}) : super(key: key);

  @override
  _VendorPrState createState() => _VendorPrState();
}

class _VendorPrState extends State<VendorPr> {
  final FirebaseServices firebaseServices = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    print(widget.userID);
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
                    builder: (context) => HomePage(userid: widget.userID)));
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
              firebaseServices.getuser(widget.userID),
          child: VendorProfile(),
        ),
      ),
    );
  }
}

class VendorProfile extends StatefulWidget {
  @override
  _VendorProfileState createState() => _VendorProfileState();
}

class _VendorProfileState extends State<VendorProfile> {
  final FirebaseServices firebaseServices = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    final vendordata = Provider.of<List<UserModel>>(context);
    print(vendordata);
    return vendordata == null
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
                        imageUrl: vendordata[0].profileURL,
                        imageBuilder: (context, imageProvider) => Container(
                          width: 100.0,
                          height: 100.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.cover),
                          ),
                        ),
                        placeholder: (context, url) => SpinKitPulse(
                          color: Colors.amberAccent,
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),

                      // CircleAvatar(
                      //   backgroundColor: Colors.amber,
                      //   backgroundImage: NetworkImage(vendordata[0].profileURL),
                      // ),
                      Positioned(
                        right: 0,
                        bottom: 25,
                        child: SizedBox(
                          height: displayHeight(context) * 0.1,
                          width: displayWidth(context) * 0.1,
                          child: CircleAvatar(
                            backgroundColor: Colors.white54,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50))),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        ProfilePicEdit(
                                          docId: vendordata[0].documentId,
                                        ));
                              },
                              child: Icon(
                                Icons.camera_alt_rounded,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: displayHeight(context) * .03,
                ),
                CardItem(
                  iconData: Icon(
                    LineIcons.user,
                    color: Colors.amber[600],
                    size: 30.0,
                  ),
                  textItem: 'Vendor Name',
                  // userData: "",
                  userData: vendordata[0].name,
                ),
                SizedBox(
                  height: displayHeight(context) * .03,
                ),
                CardItem(
                  iconData: Icon(
                    Icons.email_outlined,
                    color: Colors.amber[600],
                    size: 30.0,
                  ),
                  textItem: 'Vendor ID',
                  // userData: "",
                  userData: vendordata[0].iD,
                ),
                SizedBox(
                  height: displayHeight(context) * .03,
                ),
                CardItem(
                  iconData: Icon(
                    Icons.phone_android_rounded,
                    color: Colors.amber[600],
                    size: 30.0,
                  ),
                  textItem: 'Open Hours',
                  userData: "8 AM - 4 PM",
                ),
                CardItem(
                  iconData: Icon(
                    Icons.phone_android_rounded,
                    color: Colors.amber[600],
                    size: 30.0,
                  ),
                  textItem: 'Open?',
                  userData: vendordata[0].isOpen.toString(),
                ),
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        primary: Colors.amber),
                    onPressed: () {
                      firebaseServices.signOut();
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => LandingPage()),
                          (Route<dynamic> route) => false);
                    },
                    child: Text("Log Out",
                        style: GoogleFonts.ptSans(
                          fontSize: 18,
                          letterSpacing: .3,
                        )))
              ],
            )));
  }
}
