import 'package:enyad_store_3/data/repositories/products/product_repository.dart';
import 'package:enyad_store_3/features/shop/models/category_model.dart';
import 'package:enyad_store_3/features/shop/models/product_model.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/categories/category_repository.dart';
import '../../../../utils/popups/loaders.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  final _categoryRepository = Get.put(CategoryRepository());
  final isLoading = false.obs;
  RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  RxList<CategoryModel> featuredCategories = <CategoryModel>[].obs;

  @override
  void onInit() {
    getCategories();
    super.onInit();
  }

  Future<void> getCategories() async {
    try {
      isLoading.value = true;

      final categories = await _categoryRepository.getAllCategories();

      allCategories.assignAll(categories);

      featuredCategories.assignAll(allCategories
          .where((category) => category.isFeatured && category.parentId.isEmpty)
          .take(12)
          .toList());

      ///[remove take 12 if necessary]
    } catch (e) {
      throw SLoaders.errorSnackBar(
          title: 'Oh No!', message: 'Data fetching error. Please wait...');
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<CategoryModel>> getSubCategories(String categoryId) async {
    try {
      final subCategories =
          await _categoryRepository.getSubCategories(categoryId);
      return subCategories;
    } catch (e) {
      // SLoaders.errorSnackBar(title: 'Oh No!', message: e.toString());
      return [];
    }
  }

  Future<List<ProductModel>> getCategoryProducts(
      {required String categoryId, int limit = 4}) async {
    try {
      final products = await ProductRepository.instance
          .getProductForCategory(categoryId: categoryId, limit: limit);
      return products;
    } catch (e) {
      // SLoaders.errorSnackBar(title: 'Oh No!', message: e.toString());
      return [];
    }
  }
}
