import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enyad_store_3/utils/formatter/formatter.dart';

class AddressModel {
  String id, name, phoneNumber, street, city, state, country;
  String postalCode;
  DateTime? dateTime;
  bool selectedAddress;

  AddressModel({
    required this.name,
    required this.id,
    this.dateTime,
    required this.phoneNumber,
    required this.state,
    required this.city,
    required this.country,
    required this.postalCode,
    this.selectedAddress = false,
    required this.street,
  });

  String get formattedPhoneNum => SFormatter.formatPhoneNumber(phoneNumber);

  static AddressModel empty() => AddressModel(
        name: '',
        id: '',
        phoneNumber: '',
        state: '',
        city: '',
        country: '',
        street: '',
        postalCode: '',
      );

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Name': name,
      'PhoneNumber': phoneNumber,
      'State': state,
      'City': city,
      'Country': country,
      'SelectedAddress': selectedAddress,
      'Street': street,
      'PostalCode': postalCode,
      'DateTime': dateTime != null ? Timestamp.fromDate(dateTime!) : null,
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> data) {
    return AddressModel(
      id: data['Id'] as String,
      name: data['Name'] as String,
      phoneNumber: data['PhoneNumber'] as String,
      state: data['State'] as String,
      city: data['City'] as String,
      country: data['Country'] as String,
      selectedAddress: data['SelectedAddress'] as bool,
      street: data['Street'] as String,
      postalCode: data['PostalCode'] as String,
      dateTime: (data['DateTime'] as Timestamp).toDate(),
    );
  }

  factory AddressModel.fromDocumentSnapshot(DocumentSnapshot document) {
    final data = document.data() as Map<String, dynamic>;

    return AddressModel(
      id: document.id,
      name: data['Name'] ?? '',
      phoneNumber: data['PhoneNumber'] ?? '',
      state: data['State'] ?? '',
      city: data['City'] ?? '',
      country: data['Country'] ?? '',
      postalCode: data['PostalCode'] ?? '',
      selectedAddress: data['SelectedAddress'] as bool,
      street: data['Street'] ?? '',
      dateTime: (data['DateTime'] as Timestamp).toDate(),
    );
  }

  @override
  String toString() {
    return '$street,$city,$state $postalCode,$country';
  }
}
