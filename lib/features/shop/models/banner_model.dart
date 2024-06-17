import 'package:cloud_firestore/cloud_firestore.dart';

class BannerModel {
  String targetScreen;
  String imageUrl;
  bool active;

  BannerModel({
    required this.targetScreen,
    required this.imageUrl,
    required this.active,
  });

  ///convert model to json to update to firebase
  Map<String, dynamic> toJson() {
    return {
      'TargetScreen': targetScreen,
      'ImageUrl': imageUrl,
      'Active': active,
    };
  }

  factory BannerModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    ///map json record to model
    return BannerModel(
        imageUrl: data['ImageUrl'] ?? '',
        targetScreen: data['TargetScreen'] ?? '',
        active: data['Active'] ?? false);
  }
}
