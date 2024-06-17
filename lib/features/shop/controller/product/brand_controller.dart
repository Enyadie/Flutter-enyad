import 'package:enyad_store_3/data/repositories/Brands/brands_repository.dart';
import 'package:enyad_store_3/data/repositories/products/product_repository.dart';
import 'package:enyad_store_3/features/shop/models/brand_model.dart';
import 'package:enyad_store_3/utils/popups/loaders.dart';
import 'package:get/get.dart';

import '../../models/product_model.dart';

class BrandController extends GetxController {
  static BrandController get instance => Get.find();

  RxBool isLoading = true.obs;
  final RxList<BrandModel> featuredBrands = <BrandModel>[].obs;
  final RxList<BrandModel> allBrands = <BrandModel>[].obs;
  final brandRepo = Get.put(BrandRepository());

  @override
  void onInit() {
    getFutureBrands();
    super.onInit();
  }

  Future<void> getFutureBrands() async {
    try {
      isLoading.value = true;
      final brands = await brandRepo.getAllBrand();
      allBrands.assignAll(brands);
      featuredBrands.assignAll(
          allBrands.where((brand) => brand.isFeatured ?? false).take(4));
    } catch (e) {
      SLoaders.errorSnackBar(title: 'Oh no!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<BrandModel>> getBrandsCategory(String categoryId) async {
    try {
      final brands = await brandRepo.getBrandsCategory(categoryId);
      return brands;
    } catch (e) {
      SLoaders.errorSnackBar(title: 'Oh no!', message: e.toString());
      return [];
    }
  }

  Future<List<ProductModel>> getBrandProducts(
      {required String brandId, int limit = -1}) async {
    try {
      final products = await ProductRepository.instance
          .getProductForBrand(brandId: brandId, limit: limit);
      return products;
    } catch (e) {
      SLoaders.errorSnackBar(title: 'Oh no!', message: e.toString());
      return [];
    }
  }
}
