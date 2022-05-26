class UserModel {
  String documentId;
  String email;
  String firebaseId;
  String fname;
  String gender;
  String phoneNumber;
  String profileUrl;
  String studentID;
  String dateRegistered;
  String yearJoined;

  UserModel(
      {this.documentId,
      this.email,
      this.firebaseId,
      this.fname,
      this.gender,
      this.phoneNumber,
      this.profileUrl,
      this.studentID,
      this.dateRegistered,
      this.yearJoined});

  UserModel.fromJson(Map<String, dynamic> parsedJSON)
      : fname = parsedJSON['Fname'],
        email = parsedJSON['Email'],
        phoneNumber = parsedJSON['PhoneNumber'],
        gender = parsedJSON['Gender'],
        documentId = parsedJSON['DocumentId'],
        firebaseId = parsedJSON['FirebaseID'],
        profileUrl = parsedJSON['ProfilePicture'],
        dateRegistered = parsedJSON['TimedateRegistered'],
        studentID = parsedJSON['StudentID'],
        yearJoined = parsedJSON['YearJoinedALU'];
}
