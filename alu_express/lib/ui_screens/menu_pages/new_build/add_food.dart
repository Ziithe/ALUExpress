import 'dart:io';
import 'package:alu_express/services/Models/services.dart';
import 'package:alu_express/ui_screens/extras/size_helpers.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:alu_express/services/auth/bussiness_logic.dart';
import 'package:alu_express/ui_screens/shared_widgets/pop_up_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:date_time_format/date_time_format.dart';

class AddFood extends StatefulWidget {
  final userid;
  AddFood({Key key, @required this.userid}) : super(key: key);

  @override
  _AddFoodState createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
  final servicesinstance = FirebaseServices();
  bool _checked = false;
  bool isLoading = false;
  String imageUrl;
  File image;
  String button = 'Save Food';
  final _formKey = GlobalKey<FormState>();
  final authinstance = Authentificate();
  final getinstance = Get();
  final dateTime = DateTime.now();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  Map<String, dynamic> foodData;
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  TextEditingController sizeController = TextEditingController();
  TextEditingController ingredientsController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Align(
            child: Column(children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 100)),
              SvgPicture.asset('assets/1.svg',
                  height: displayHeight(context) * 0.05,
                  width: displayWidth(context) * 0.6),
              Padding(padding: EdgeInsets.only(top: 30)),
              Padding(padding: EdgeInsets.only(top: 10)),
              Text(
                "Create Food",
                style: GoogleFonts.roboto(
                  fontSize: 18,
                  color: Colors.black54,
                  letterSpacing: .3,
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 20)),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.9,
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
                              hintText: "Food Name",
                              hintStyle: GoogleFonts.roboto(
                                color: Colors.black54,
                                fontSize: 12,
                              ),
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Please enter Food Name here";
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
                            controller: priceController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: "Price",
                              hintStyle: GoogleFonts.roboto(
                                color: Colors.black54,
                                fontSize: 12,
                              ),
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Mandatory Field!, Food Price';
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
                            controller: discountController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: "Discount",
                              hintStyle: GoogleFonts.roboto(
                                color: Colors.black54,
                                fontSize: 12,
                              ),
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Mandatory Field!, Food Discount';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child: TextFormField(
                            controller: sizeController,
                            keyboardType: TextInputType.text,
                            style: GoogleFonts.ptSans(
                              color: Colors.black,
                              fontSize: 18,
                              letterSpacing: .3,
                            ),
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                              hintText: "Size",
                              hintStyle: GoogleFonts.roboto(
                                color: Colors.black54,
                                fontSize: 12,
                              ),
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Please enter size ( Small, Large )";
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child: TextFormField(
                            controller: quantityController,
                            keyboardType: TextInputType.text,
                            style: GoogleFonts.ptSans(
                              color: Colors.black,
                              fontSize: 18,
                              letterSpacing: .3,
                            ),
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                              hintText: "Quantity",
                              hintStyle: GoogleFonts.roboto(
                                color: Colors.black54,
                                fontSize: 12,
                              ),
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Please enter how many of this products there is";
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child: TextFormField(
                            controller: ingredientsController,
                            keyboardType: TextInputType.multiline,
                            style: GoogleFonts.ptSans(
                              color: Colors.black,
                              fontSize: 18,
                              letterSpacing: .3,
                            ),
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                              hintText: "Ingredients",
                              hintStyle: GoogleFonts.roboto(
                                color: Colors.black54,
                                fontSize: 12,
                              ),
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Please enter the Ingredients";
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child: TextFormField(
                            controller: descriptionController,
                            keyboardType: TextInputType.multiline,
                            style: GoogleFonts.ptSans(
                              color: Colors.black,
                              fontSize: 18,
                              letterSpacing: .3,
                            ),
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                              hintText: "Description",
                              hintStyle: GoogleFonts.roboto(
                                color: Colors.black54,
                                fontSize: 12,
                              ),
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Please enter the Ingredients";
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
                            Expanded(
                              child: Text(
                                'Please Enter if food is Featured',
                                style: GoogleFonts.ptSans(
                                    color: Colors.black, fontSize: 15),
                              ),
                            )
                          ],
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Food Image",
                                    style: kFont,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: IconButton(
                                    icon: Icon(Feather.upload),
                                    onPressed: () {
                                      getImage();
                                    },
                                  ),
                                ),
                              ],
                            )),
                        Container(
                            height: 150,
                            width: 150,
                            child:
                                (image != null) ? Image.file(image) : Text("")),
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
                                        print("Image URL");
                                        print(imageUrl);
                                        uploadPic(image).then((value) => {
                                              print("INside then"),
                                              print(value),
                                              imageUrl = value,
                                              setState(() {
                                                isLoading = true;

                                                Map<String, dynamic> foodData =
                                                    {
                                                  'FoodName':
                                                      nameController.text,
                                                  'ImageURL': imageUrl,
                                                  'Price': priceController.text,
                                                  'Discount':
                                                      discountController.text,
                                                  'Size': sizeController.text,
                                                  'Ingredients':
                                                      ingredientsController
                                                          .text,
                                                  'Description':
                                                      descriptionController
                                                          .text,
                                                  'IsFeatured':
                                                      _checked.toString(),
                                                  'Category': "Breakfast",
                                                  'Vendor': widget.userid,
                                                  'Quantity':
                                                      quantityController.text,
                                                  'DocumentId':
                                                      '.', // the DocumentId will be updated after creation of the document id.
                                                  'Timedate':
                                                      DateTimeFormat.format(
                                                          dateTime),
                                                };
                                                print(foodData);

                                                servicesinstance
                                                    .addFood(foodData)
                                                    .then((value) => {
                                                          if (value == "true")
                                                            {
                                                              showDialog(
                                                                  context:
                                                                      context,
                                                                  builder: (BuildContext context) => PopUp(
                                                                      uid: widget
                                                                          .userid,
                                                                      text:
                                                                          "Successfully added Food",
                                                                      successful:
                                                                          true))
                                                            }
                                                          else
                                                            {
                                                              showDialog(
                                                                  context:
                                                                      context,
                                                                  builder: (BuildContext context) => PopUp(
                                                                      uid: widget
                                                                          .userid,
                                                                      text:
                                                                          value,
                                                                      successful:
                                                                          false))
                                                            }
                                                        });
                                              })
                                            });
                                      }
                                    },
                                   child: Text(
                                      button,
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
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Cancel",
                                      style: GoogleFonts.ptSans(
                                        fontSize: 15,
                                        letterSpacing: .3,
                                        color: Colors.red[900],
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic,
                                      )))),
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

  Future getImage() async {
    final ImagePicker imagePicker = ImagePicker();
    PickedFile img = await imagePicker.getImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      image = File(img.path);
    });
  }

  uploadPic(File _image1) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child("Foods/" +
        nameController.text +
        " " +
        DateTime.now().toString() +
        '.jpg');

    UploadTask uploadTask = ref.putFile(_image1);
    var imageUrls = await (await uploadTask).ref.getDownloadURL();
    print(imageUrls);
    setState(() {
      imageUrl = imageUrls;
    });

    return imageUrls;
  }

  TextStyle kFont = TextStyle(
      fontFamily: "PTSans", color: Colors.black, fontWeight: FontWeight.w500);
}
