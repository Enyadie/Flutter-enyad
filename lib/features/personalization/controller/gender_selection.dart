import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GenderSelectionController extends GetxController {
  static GenderSelectionController get instance => Get.find();
  var selectedGender = ''.obs;

  void showGenderSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Gender'),
          content: GenderDropdown(),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Handle the gender selection logic here
                print('Selected Gender: ${selectedGender.value}');
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

class GenderDropdown extends StatelessWidget {
  final GenderSelectionController genderController =
      Get.put(GenderSelectionController());

  GenderDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return DropdownButton<String>(
        value: genderController.selectedGender.value.isEmpty
            ? null
            : genderController.selectedGender.value,
        hint: const Text('Select Gender'),
        items: <String>['Male', 'Female'].map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? newValue) {
          if (newValue != null) {
            genderController.selectedGender.value = newValue;
          }
        },
      );
    });
  }
}
