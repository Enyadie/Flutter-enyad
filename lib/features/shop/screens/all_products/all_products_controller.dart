import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enyad_store_3/data/repositories/products/product_repository.dart';
import 'package:enyad_store_3/features/shop/models/product_model.dart';
import 'package:enyad_store_3/utils/popups/loaders.dart';
import 'package:get/get.dart';

class AllProductsController extends GetxController {
  static AllProductsController get instance => Get.find();

  final RxString selectedSortedOption = 'Name'.obs;

  final RxList<ProductModel> products = <ProductModel>[].obs;

  final repository = ProductRepository.instance;

  Future<List<ProductModel>> getProductsByQuery(
      Query<Map<String, dynamic>> query) async {
    try {
      final products = await repository.getFeaturedProductsByQuery(query);
      return products;
    } catch (e) {
      SLoaders.errorSnackBar(title: 'Oh No!', message: e.toString());
      return [];
    }
  }

  void sortProducts(String sortOptions) {
    selectedSortedOption.value = sortOptions;

    switch (sortOptions) {
      case 'Name':
        products.sort((a, b) => a.title.compareTo(b.title));
        break;
      case 'Higher Price':
        products.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'Lower Price':
        products.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'Sale':
        products.sort((a, b) {
          if (b.salePrice > 0) {
            return a.salePrice.compareTo(b.salePrice);
          } else if (a.salePrice > 0) {
            return -1;
          } else {
            return 1;
          }
        });
        break;
      case 'Newest':
        products.sort((a, b) => a.date!.compareTo(b.date!));
        break;
      case 'Popularity':
        products.sort((a, b) => a.title.compareTo(b.title));
        break;
      default:
        products.sort((a, b) => a.title.compareTo(b.title));
    }
  }

  void assignProducts(List<ProductModel> products) {
    ///assign the products to the list
    this.products.assignAll(products);
    sortProducts('Name');
  }
}
