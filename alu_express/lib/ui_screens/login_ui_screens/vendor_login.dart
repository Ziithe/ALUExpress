import 'package:alu_express/services/auth/bussiness_logic.dart';
import 'package:alu_express/ui_screens/extras/size_helpers.dart';
import 'package:alu_express/ui_screens/homepage_ui/home_page.dart';
import 'package:alu_express/ui_screens/login_ui_screens/vendor_signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class VendorLogIn extends StatefulWidget {
  @override
  _VendorLogInState createState() => _VendorLogInState();
}

class _VendorLogInState extends State<VendorLogIn> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final authclass = Authentificate();
  final getinstance = Get();

  bool isLoading = false;
  bool _isHidden = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Align(
        alignment: Alignment.center,
        child: Column(children: <Widget>[
          Padding(padding: EdgeInsets.only(top: 100)),
          SvgPicture.asset('assets/5.svg',
              height: displayHeight(context) * 0.2,
              width: displayWidth(context) * 0.6),
          Padding(padding: EdgeInsets.only(top: 30)),
          Text(
            "Welcome Back to ALU-Express",
            style: GoogleFonts.ptSans(
                fontSize: 25,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                letterSpacing: .3),
          ),
          Padding(padding: EdgeInsets.only(top: 10)),
          Text(
            "Log In to your Account",
            style: GoogleFonts.roboto(
              fontSize: 18,
              color: Colors.black54,
              letterSpacing: .3,
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 20)),
          SizedBox(
             width: displayWidth(context) * 0.80,
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        style: GoogleFonts.ptSans(
                          color: Colors.black,
                          fontSize: 18,
                          letterSpacing: .3,
                        ),
                        decoration: InputDecoration(
                            hintText: "Email Address",
                            hintStyle: GoogleFonts.roboto(
                              color: Colors.black54,
                              fontSize: 12,
                            )),
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Mandatory Field, Please enter Your Email Address';
                          } else if (!value.contains('@')) {
                            return 'Please enter a valid email address!';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: TextFormField(
                        obscureText: true,
                        controller: passwordController,
                        style: GoogleFonts.ptSans(
                          color: Colors.black,
                          fontSize: 18,
                          letterSpacing: .3,
                        ),
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
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Mandatory Field, Enter Your Password';
                          } else if (value.length < 8) {
                            return 'Password must be atleast 8 characters!';
                          }
                          return null;
                        },
                      ),
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
                                    _loginandsave();
                                  }
                                },
                                child: Text(
                                  "Log In",
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
                                      builder: (context) => VendorSignUp()),
                                );
                              },
                              child: Row(
                                children: [
                                  Text("Don't have an account?",
                                      style: GoogleFonts.ptSans(
                                        fontSize: 15,
                                        letterSpacing: .3,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text("Sign Up",
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
          )
        ]),
      )),
    );
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  Future<void> setUserID(id) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('userID', id);
  }

  void _loginandsave() async {
    print("Home");
    dynamic result = await authclass.loginwithEmailandpass(
        emailController.text, passwordController.text);
    var user =  FirebaseAuth.instance.currentUser;
    print(user.uid);

    print(result);
    if (result == true) {
      print("Logged in successfully!");
      setUserID(user.uid);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HomePage(
                    userid: user.uid,
                  )));
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
  }
}
