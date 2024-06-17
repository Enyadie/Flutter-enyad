import 'package:enyad_store_3/utils/constants/colors.dart';
import 'package:enyad_store_3/utils/constants/sizes.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../common/shimmers/vertical_shimmer.dart';

class SCloudHelperFunction {
  static Widget? checkSingleRecordState<T>(AsyncSnapshot<T> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    }
    if (snapshot.hasError) {
      return const Center(child: Text('Something went wrong!'));
    }
    if (!snapshot.hasData || snapshot.data == null) {
      return const Center(child: Text('No data found!'));
    }
    return null;
  }

  static Widget? checkMultipleRecordState<T>({
    required AsyncSnapshot<List<T>> snapshot,
    Widget? loader,
    Widget? error,
    bool? showShimmer = true,
    Widget? nothingFound,
  }) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return loader ??
          const Center(
            child: CircularProgressIndicator(
              color: SColors.secondary,
            ),
          );
    }
    if (snapshot.hasError) {
      return error ?? const Center(child: Text('Something went wrong!'));
    }
    if (!snapshot.hasData || snapshot.data == null || snapshot.data!.isEmpty) {
      if (nothingFound != null) return nothingFound;
      if (showShimmer == false) {
        return const Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text('No data found!')],
            ),
          ],
        );
      } else {
        return const Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text('No data found!')],
            ),
            SizedBox(height: SSize.spaceBtwItems),
            SVerticalShimmer(),
          ],
        );
      }
    }
    return null;
  }

  static Future<String> getUrlFromFilePath(String path) async {
    try {
      if (path.isEmpty) return '';
      final ref = FirebaseStorage.instance.ref().child(path);
      final url = await ref.getDownloadURL();
      return url;
    } on FirebaseException catch (e) {
      throw e.message!;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw 'Something went wrong.';
    }
  }
}
