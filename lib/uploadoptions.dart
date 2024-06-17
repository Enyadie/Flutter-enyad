import 'package:enyad_store_3/data/repositories/products/product_repository.dart';
import 'package:enyad_store_3/data/repositories/products/productscategoryrepository.dart';
import 'package:enyad_store_3/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'data/repositories/Brands/brands_repository.dart';
import 'data/repositories/Brands/brandscategoryrepository.dart';
import 'data/repositories/banners/banner_repository.dart';
import 'data/repositories/categories/category_repository.dart';
import 'utils/constants/dummy_data.dart';

class UploadOptionsScreen extends StatelessWidget {
  const UploadOptionsScreen({Key? key}) : super(key: key);

  void _uploadBanners() async {
    SLoaders.customToast(message: 'Banners upload started');
    final bannerRepository = Get.put(BannerRepository());
    await bannerRepository.uploadDummyData(DummyData.banners);
    SLoaders.customToast(message: 'Success,' 'Banners uploaded successfully!');
  }

  void _uploadCategories() async {
    SLoaders.customToast(message: 'Categories upload started');
    final categoryRepository = Get.put(CategoryRepository());
    await categoryRepository.uploadDummyData(DummyData.categories);
    SLoaders.customToast(
        message: 'Success,' 'Categories uploaded successfully!');
  }

  void _uploadProducts() async {
    SLoaders.customToast(message: 'Products upload started');
    final productRepository = Get.put(ProductRepository());
    await productRepository.uploadDummyData(DummyData.products);
    SLoaders.customToast(message: 'Success,' 'Products uploaded successfully!');
  }

  void _uploadBrands() async {
    SLoaders.customToast(message: 'Brands upload started');
    final brandRepository = Get.put(BrandRepository());
    await brandRepository.uploadDummyData(DummyData.brands);
    SLoaders.customToast(message: 'Success,' 'Brands uploaded successfully!');
  }

  void _uploadProductsCategory() async {
    SLoaders.customToast(message: 'Products category upload started');
    final productCategoryRepository = Get.put(ProductsCategoryRepository());
    await productCategoryRepository.uploadDummyData(DummyData.productCategory);
    SLoaders.customToast(
        message: 'Success,' 'Products category uploaded successfully!');
  }

  void _uploadBrandsCategory() async {
    SLoaders.customToast(message: 'Brands category category upload started');
    final brandCategoryRepository = Get.put(BrandsCategoryRepository());
    await brandCategoryRepository.uploadDummyData(DummyData.brandCategory);
    SLoaders.customToast(
        message: 'Success,' 'Brands category uploaded successfully!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: _uploadBanners,
              child: Text('Upload Banners'),
            ),
            ElevatedButton(
              onPressed: _uploadCategories,
              child: Text('Upload Categories'),
            ),
            ElevatedButton(
              onPressed: _uploadProducts,
              child: Text('Upload Products'),
            ),
            ElevatedButton(
              onPressed: _uploadBrands,
              child: Text('Upload Brands'),
            ),
            ElevatedButton(
              onPressed: _uploadProductsCategory,
              child: Text('Upload Category Products'),
            ),
            ElevatedButton(
              onPressed: _uploadBrandsCategory,
              child: Text('Upload Category Brands'),
            ),
          ],
        ),
      ),
    );
  }
}
