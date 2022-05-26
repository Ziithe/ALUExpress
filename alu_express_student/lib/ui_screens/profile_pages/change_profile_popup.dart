import 'dart:io';
import 'package:alu_express_student/services/Models/firebase_services.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePicEdit extends StatefulWidget {
  final docId;

  ProfilePicEdit({
    @required this.docId,
    Key key,
  }) : super(key: key);
  @override
  _ProfilePicEditState createState() => _ProfilePicEditState();
}

class _ProfilePicEditState extends State<ProfilePicEdit> {
  TextEditingController toUpdate = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final servicesinstance = FirebaseServices();
  String title = '';
  String imageUrl;
  File image;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('$title'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Update Profile Picture '),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "Upload Profile",
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
              child: (image != null) ? Image.file(image) : Text("")),
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            uploadPic(image).then((value) => {
                  setState(() {
                    imageUrl = value;
                  }),
            servicesinstance
                .updateField(widget.docId, imageUrl, "ProfilePicture")
                .then((value) => {
                      if (value == 'true')
                        {Navigator.of(context).pop()}
                      else
                        {
                          print(value),
                          setState(() {
                            title = value;
                          })
                        }
                    })
                });

          
          },
          child: Center(child: Text('Update')),
        ),
      ],
    );
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
    Reference ref = storage
        .ref()
        .child("Profilepics/" + DateTime.now().toString() + '.jpg');

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


// DocumentReference(products/25Nf9TPtbQMEgoy6CvE2)