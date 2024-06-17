import 'package:enyad_store_3/data/repositories/banners/banner_repository.dart';
import 'package:get/get.dart';

import '../../../../utils/popups/loaders.dart';
import '../../models/banner_model.dart';

class BannerController extends GetxController {
  final isLoading = false.obs;
  final carouselCurrentIndex = 0.obs;
  final RxList<BannerModel> banners = <BannerModel>[].obs;

  @override
  void onInit() {
    getBanners();
    super.onInit();
  }

  void updatePageIndicator(int index) {
    carouselCurrentIndex.value = index;
  }

  Future<void> getBanners() async {
    try {
      isLoading.value = true;
      final bannerRepo = Get.put(BannerRepository());
      final banners = await bannerRepo.getBanners();

      this.banners.assignAll(banners);
    } catch (e) {
      throw SLoaders.errorSnackBar(
          title: 'Oh No!', message: 'Data fetching error. Please wait...');
    } finally {
      isLoading.value = false;
    }
  }
}
