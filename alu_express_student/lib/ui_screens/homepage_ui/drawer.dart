import 'package:alu_express_student/services/Models/firebase_services.dart';
import 'package:alu_express_student/services/Models/user_model.dart';
import 'package:alu_express_student/ui_screens/cart_pages/cart.dart';
import 'package:alu_express_student/ui_screens/homepage_ui/home_page.dart';
import 'package:alu_express_student/ui_screens/login_ui_screens/landing_page.dart';
import 'package:alu_express_student/ui_screens/notifications/notifications.dart';
import 'package:alu_express_student/ui_screens/profile_pages/student_profile.dart';
import 'package:alu_express_student/ui_screens/shared_widgets/size_helpers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class DrawerProvider extends StatefulWidget {
  final userid;

  const DrawerProvider({Key key, this.userid}) : super(key: key);
  @override
  _DrawerProviderState createState() => _DrawerProviderState();
}

class _DrawerProviderState extends State<DrawerProvider> {
  final FirebaseServices firebaseServices = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: StreamProvider(
        create: (BuildContext context) =>
            firebaseServices.getuser(widget.userid),
        child: MyDrawer(
          userid: widget.userid,
        ),
      ),
    );
  }
}

class MyDrawer extends StatefulWidget {
  final userid;

  const MyDrawer({Key key, this.userid}) : super(key: key);
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  final FirebaseServices firebaseServices = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    List userList = Provider.of<List<UserModel>>(context);
    print(userList);
    print(widget.userid);
    return userList == null
        ? SpinKitSquareCircle(color: Colors.amberAccent)
        : Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: displayHeight(context) * 0.1),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CachedNetworkImage(
                      imageUrl: userList[0].profileUrl,
                      imageBuilder: (context, imageProvider) => Container(
                        width: 100.0,
                        height: 100.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover),
                        ),
                      ),
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                              SpinKitRotatingCircle(
                        color: Colors.white,
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      userList[0].fname,
                      style: GoogleFonts.ptSans(
                          fontSize: 22.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(userList[0].email,
                        style: GoogleFonts.ptSans(fontSize: 18)),
                    SizedBox(height: 10.0),

                    // Place Divider Here
                    Divider(
                      height: 20.0,
                      color: Colors.red[900],
                      thickness: 1,
                    ),

                    //Menu
                    ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => StudentProfile(
                                      userid: widget.userid,
                                    )));
                      },
                      leading: Icon(
                        LineIcons.userEdit,
                        color: Colors.red[900],
                      ),
                      title: Text("Profile",
                          style: GoogleFonts.ptSans(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(
                      height: displayHeight(context) * 0.03,
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => HomePage(
                                      userid: widget.userid,
                                    )));
                      },
                      leading: Icon(
                        Icons.food_bank_outlined,
                        color: Colors.red[900],
                      ),
                      title: Text("Food List",
                          style: GoogleFonts.ptSans(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(
                      height: displayHeight(context) * 0.03,
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => new Notifications()));
                      },
                      leading: Icon(
                        Icons.notifications_outlined,
                        color: Colors.red[900],
                      ),
                      title: Text("Notifications",
                          style: GoogleFonts.ptSans(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(
                      height: displayHeight(context) * 0.2,
                    ),
                    ListTile(
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
                    )
                  ],
                ),
              )
            ],
          );
  }
}
