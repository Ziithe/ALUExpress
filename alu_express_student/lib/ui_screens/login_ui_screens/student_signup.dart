import 'package:alu_express_student/services/Models/firebase_services.dart';
import 'package:alu_express_student/services/auth/bussiness_logic.dart';
import 'package:alu_express_student/ui_screens/homepage_ui/home_page.dart';
import 'package:alu_express_student/ui_screens/login_ui_screens/student_login.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:alu_express_student/ui_screens/shared_widgets/size_helpers.dart';
import 'package:flutter_svg/flutter_svg.dart';

const lanSvg = 'assets/svg3';

class StudentSignUp extends StatefulWidget {
  @override
  _StudentSignUpState createState() => _StudentSignUpState();
}

class _StudentSignUpState extends State<StudentSignUp> {
  bool _checked = false;
  bool _isHidden2 = true;
  bool _isHidden = true;
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final authinstance = Authentificate();
  final getinstance = Get();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordMatch = TextEditingController();
  final FirebaseServices firebaseServices = FirebaseServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Align(
        child: Column(children: <Widget>[
          Padding(padding: EdgeInsets.only(top: 100)),
          SvgPicture.asset('assets/1.svg',
              height: displayHeight(context) * 0.2,
              width: displayWidth(context) * 0.6),
          Padding(padding: EdgeInsets.only(top: 30)),
          Text(
            "Welcome to ALU-Express",
            style: GoogleFonts.ptSans(
                fontSize: 25,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                letterSpacing: .3),
          ),
          Padding(padding: EdgeInsets.only(top: 10)),
          Text(
            "Create an account with us",
            style: GoogleFonts.roboto(
              fontSize: 18,
              color: Colors.black54,
              letterSpacing: .3,
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 20)),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width * 0.75,
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: TextFormField(
                        controller: nameController,
                        style: GoogleFonts.ptSans(
                          color: Colors.black,
                          fontSize: 18,
                          letterSpacing: .3,
                        ),
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                          hintText: "Student Name",
                          hintStyle: GoogleFonts.roboto(
                            color: Colors.black54,
                            fontSize: 12,
                          ),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Please enter your Business Name here";
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: TextFormField(
                        style: GoogleFonts.ptSans(
                          color: Colors.black,
                          fontSize: 18,
                          letterSpacing: .3,
                        ),
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: "Email Address",
                          hintStyle: GoogleFonts.roboto(
                            color: Colors.black54,
                            fontSize: 12,
                          ),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Mandatory Field!, Enter an Email Address';
                          } else if (!value.contains('@')) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: TextFormField(
                        style: GoogleFonts.ptSans(
                          color: Colors.black,
                          fontSize: 18,
                          letterSpacing: .3,
                        ),
                        controller: passwordController,
                        obscureText: _isHidden,
                        decoration: InputDecoration(
                          suffix: InkWell(
                            onTap: _togglePasswordView,
                            child: Icon(Icons.visibility),
                          ),
                          hintText: "Password",
                          hintStyle: GoogleFonts.roboto(
                            color: Colors.black54,
                            fontSize: 12,
                          ),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Mandatory Field, Enter Password';
                          } else if (value.length < 8) {
                            return 'Password must be at least 8 characters!';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: TextFormField(
                        style: GoogleFonts.ptSans(
                          color: Colors.black,
                          fontSize: 18,
                          letterSpacing: .3,
                        ),
                        controller: passwordMatch,
                        obscureText: _isHidden2,
                        decoration: InputDecoration(
                          suffix: InkWell(
                            onTap: _togglePasswordView2,
                            child: Icon(Icons.visibility),
                          ),
                          hintText: "Confirm Password",
                          hintStyle: GoogleFonts.ptSans(
                            color: Colors.black54,
                            fontSize: 12,
                          ),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please confirm your password';
                          } else if (value != passwordController.text) {
                            return 'Passwords do not match, try again';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 30)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Checkbox(
                          activeColor: Colors.red[900],
                          value: _checked,
                          onChanged: (value) {
                            setState(() {
                              _checked = !_checked;
                            });
                          },
                        ),
                        Text(
                          'I agree to all the terms and conditions.',
                          style: GoogleFonts.ptSans(
                              color: Colors.black, fontSize: 15),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: isLoading
                          ? CircularProgressIndicator()
                          : SizedBox(
                              width: displayWidth(context) * 0.5,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    primary: Colors.red[900]),
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    _signupandsave();
                                  }
                                },
                                child: Text(
                                  "Sign Up",
                                  style: GoogleFonts.ptSans(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 20),
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => StudentLogIn()),
                                );
                              },
                              child: Row(
                                children: [
                                  Text("Already have an account?",
                                      style: GoogleFonts.ptSans(
                                        fontSize: 15,
                                        letterSpacing: .3,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text("Log In",
                                      style: GoogleFonts.ptSans(
                                        fontSize: 15,
                                        letterSpacing: .3,
                                        color: Colors.red[900],
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic,
                                      )),
                                ],
                              ))),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    ));
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  void _togglePasswordView2() {
    setState(() {
      _isHidden2 = !_isHidden2;
    });
  }

  void _signupandsave() async {
    dynamic result = await authinstance.registerToFb(
        emailController.text, nameController.text, passwordController.text);
    var user = FirebaseAuth.instance.currentUser;

    if (result == true) {
      print("Successfully Signed Up");
      final dateTime = DateTime.now();

      Map<String, dynamic> foodData = {
        'Fname': nameController.text,
        'FirebaseID': user.uid,
        'PhoneNumber': 'Not Set',
        'StudentID': "Not Set",
        'ProfilePicture':
            'https://www.dovercourt.org/wp-content/uploads/2019/11/610-6104451_image-placeholder-png-user-profile-placeholder-image-png.jpg',
        'Email': emailController.text,
        'Gender': "Not Set",
        'YearJoinedALU': "Not Set",
        'DocumentId':
            '.', // the DocumentId will be updated after creation of the document id.
        'TimedateRegistered': DateTimeFormat.format(dateTime),
      };

      await firebaseServices.addStudent(foodData);

      Navigator.push(context,
          MaterialPageRoute(builder: (context) => HomePage(userid: user.uid)));
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text(result.toString()),
              actions: [
                ElevatedButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
      setState(() => isLoading = false);
    }
    @override
    void dispose() {
      super.dispose();
      nameController.dispose();
      emailController.dispose();
      passwordController.dispose();
    }
  }
}
