class UserModel {
  String name;
  String profileURL;
  String iD;
  String isOpen;
  String documentId;
  UserModel(
      {this.name, this.isOpen, this.profileURL, this.iD, this.documentId});

  UserModel.fromJson(Map<String, dynamic> parsedJSON)
      : name = parsedJSON['vendorName'],
        profileURL = parsedJSON['profilePhotoUrl'],
        documentId = parsedJSON['documentId'],
        isOpen = parsedJSON['open'].toString(),
        iD = parsedJSON['vendorID'];
}
