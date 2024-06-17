import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enyad_store_3/utils/formatter/formatter.dart';

class UserModel {
  String phoneNumber;
  String profilePicture;
  String firstName;
  String lastName;
  final String username;
  final String email;
  final String id;

  UserModel({
    required this.phoneNumber,
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.profilePicture,
  });

  String get fullName => '$firstName $lastName';

  String get formattedPhoneNo => SFormatter.formatPhoneNumber(phoneNumber);

  static List<String> nameParts(fullName) => fullName.split("");

  static String generateUserName(fullName) {
    List<String> nameParts = fullName.split(" ");
    String firstName = nameParts[0].toUpperCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toUpperCase() : "";

    String camelCaseUsername = "$firstName$lastName";
    String usernameWithPrefix = "Enyad_$camelCaseUsername";
    return usernameWithPrefix;
  }

  static UserModel empty() => UserModel(
      phoneNumber: "",
      id: "",
      firstName: "",
      lastName: "",
      username: "",
      email: "",
      profilePicture: "");

  ///convert to json to store on firebase
  Map<String, dynamic> toJson() {
    return {
      'FirstName': firstName,
      'LastName': lastName,
      'Username': username,
      'Email': email,
      'PhoneNumber': phoneNumber,
      'ProfilePicture': profilePicture,
    };
  }

  ///method to create a userModel from a firebase document snapshot.
  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
          phoneNumber: data['PhoneNumber'] ?? '',
          id: document.id,
          firstName: data['FirstName'] ?? '',
          lastName: data['LastName'] ?? '',
          username: data['Username'] ?? '',
          email: data['Email'] ?? '',
          profilePicture: data['ProfilePicture'] ?? '');
    } else {
      return UserModel.empty();
    }
  }
}
