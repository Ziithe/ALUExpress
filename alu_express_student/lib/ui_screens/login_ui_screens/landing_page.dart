import 'package:alu_express_student/ui_screens/login_ui_screens/student_login.dart';
import 'package:alu_express_student/ui_screens/login_ui_screens/student_signup.dart';
import 'package:alu_express_student/ui_screens/shared_widgets/size_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

// We can check if the user is logged in  or not and redirect to  the approp page.
class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return (Scaffold(
        body: SingleChildScrollView(
            child: Align(
                alignment: Alignment.center,
                child: Column(children: <Widget>[
                  Padding(padding: EdgeInsets.only(top: 170)),
                  SvgPicture.asset('assets/4.svg',
                      height: displayHeight(context) * 0.3,
                      width: displayWidth(context) * 0.3),
                  SizedBox(height: displayHeight(context) * 0.05),
                  Text(
                    "Welcome to ALU-Express, ",
                    style: GoogleFonts.ptSans(
                      color: Colors.red[900],
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      letterSpacing: .5,
                    ),
                  ),
                  SizedBox(height: displayHeight(context) * 0.02),
                  Text(
                    "Your Number one Campus Delivery!",
                    style: GoogleFonts.ptSans(
                      color: Colors.black87,
                      fontSize: 17,
                      letterSpacing: .3,
                    ),
                  ),
                  Text(
                    "Get your meals and snacks,",
                    style: GoogleFonts.ptSans(
                      color: Colors.black87,
                      fontSize: 17,
                      letterSpacing: .3,
                    ),
                  ),
                  Text(
                    "while social distancing!",
                    style: GoogleFonts.ptSans(
                      color: Colors.black87,
                      fontSize: 17,
                      letterSpacing: .3,
                    ),
                  ),
                  SizedBox(height: displayHeight(context) * 0.08),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedBox(
                          width: displayWidth(context) * 0.7,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0)),
                                primary: Colors.red[900]),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => StudentSignUp()),
                              );
                            },
                            child: Text(
                              'Create an Account',
                              style: GoogleFonts.ptSans(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: displayHeight(context) * 0.02,
                        ),
                        SizedBox(
                            width: displayWidth(context) * 0.7,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(50.0)),
                                  primary: Colors.amber,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => StudentLogIn()),
                                  );
                                },
                                child: Text(
                                  'Log In',
                                  style: GoogleFonts.ptSans(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                )))
                      ])
                ])))));
  }
}
