import 'dart:convert';

import 'package:enyad_store_3/data/repositories/products/product_repository.dart';
import 'package:enyad_store_3/utils/local_storage/local_storage.dart';
import 'package:enyad_store_3/utils/popups/loaders.dart';
import 'package:get/get.dart';

import '../../models/product_model.dart';

class FavouritesController extends GetxController {
  static FavouritesController get instance => Get.find();

  final favourites = <String, bool>{}.obs;

  @override
  void onInit() {
    super.onInit();
    initFavourites();
  }

  void initFavourites() {
    final json = SLocalStorage.instance().readData('favourites');

    if (json != null) {
      final storedFavourites = jsonDecode(json) as Map<String, dynamic>;
      favourites.assignAll(
          storedFavourites.map((key, value) => MapEntry(key, value as bool)));
    }
  }

  bool isFavourite(String productId) {
    return favourites[productId] ?? false;
  }

  void toggleFavouriteProduct(String productId) {
    if (!favourites.containsKey(productId)) {
      favourites[productId] = true;
      saveFavouriteToStorage();
      SLoaders.customToast(message: 'Product has been added to the Wishlist.');
    } else {
      SLocalStorage.instance().removeData(productId);
      favourites.remove(productId);
      saveFavouriteToStorage();
      favourites.refresh();
      SLoaders.customToast(
          message: 'Product has been removed to the Wishlist.');
    }
  }

  void saveFavouriteToStorage() {
    final encodedFavourite = json.encode(favourites);
    SLocalStorage.instance().saveData('favourites', encodedFavourite);
  }

  Future<List<ProductModel>> favouriteProducts() async {
    return await ProductRepository.instance
        .getFavouriteProducts(favourites.keys.toList());
  }
}
