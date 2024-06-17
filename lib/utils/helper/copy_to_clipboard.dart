import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CopyToClipboardController extends GetxController {
  final TextEditingController controller = TextEditingController();

  void copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
  }
}
