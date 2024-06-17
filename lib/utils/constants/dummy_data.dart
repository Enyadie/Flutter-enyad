import '../../features/shop/models/banner_model.dart';
import '../../features/shop/models/brand_category_model.dart';
import '../../features/shop/models/brand_model.dart';
import '../../features/shop/models/category_model.dart';
import '../../features/shop/models/product_attributes_model.dart';
import '../../features/shop/models/product_category_model.dart';
import '../../features/shop/models/product_model.dart';
import '../../features/shop/models/product_variations_model.dart';
import '../../routes/routes.dart';
import 'image_strings.dart';

class DummyData {
  static final List<BannerModel> banners = [
    BannerModel(
        targetScreen: SRoutes.store,
        imageUrl: SImages.promoBanner1,
        active: true),
    BannerModel(
        targetScreen: SRoutes.store,
        imageUrl: SImages.promoBanner3,
        active: true),
    BannerModel(
        targetScreen: SRoutes.order,
        imageUrl: SImages.promoBanner2,
        active: true),
    BannerModel(
        targetScreen: SRoutes.order,
        imageUrl: SImages.promoBanner4,
        active: true),
  ];

  static final List<BrandModel> brands = [
    BrandModel(
      id: '1',
      image: SImages.appleLogo,
      name: 'Apple',
      isFeatured: true,
      productCount: 190,
    ),
    BrandModel(
      id: '2',
      image: SImages.adidasLogo,
      name: 'Adidas',
      isFeatured: true,
      productCount: 556,
    ),
    BrandModel(
      id: '3',
      image: SImages.amazonLogo,
      name: 'Amazon',
      isFeatured: true,
      productCount: 209,
    ),
    BrandModel(
      id: '4',
      image: SImages.boseLogo,
      name: 'Bose',
      isFeatured: true,
      productCount: 311,
    ),
    BrandModel(
      id: '5',
      image: SImages.canonLogo,
      name: 'Canon',
      isFeatured: true,
      productCount: 452,
    ),
    BrandModel(
      id: '6',
      image: SImages.djiLogo,
      name: 'Dji',
      isFeatured: true,
      productCount: 226,
    ),
    BrandModel(
      id: '7',
      image: SImages.lgLogo,
      name: 'LG',
      isFeatured: true,
      productCount: 378,
    ),
    BrandModel(
      id: '8',
      image: SImages.microsoftLogo,
      name: 'Microsoft',
      isFeatured: true,
      productCount: 414,
    ),
    BrandModel(
      id: '9',
      image: SImages.goproLogo,
      name: 'GoPro',
      isFeatured: true,
      productCount: 135,
    ),
    BrandModel(
      id: '10',
      image: SImages.nikeLogo,
      name: 'Nike',
      isFeatured: true,
      productCount: 160,
    ),
    BrandModel(
      id: '11',
      image: SImages.samsungLogo,
      name: 'Samsung',
      isFeatured: true,
      productCount: 187,
    ),
    BrandModel(
      id: '12',
      image: SImages.poloLogo,
      name: 'Polo',
      isFeatured: true,
      productCount: 147,
    ),
    BrandModel(
      id: '13',
      image: SImages.sonyLogo,
      name: 'Sony',
      isFeatured: true,
      productCount: 567,
    ),
    BrandModel(
      id: '14',
      image: SImages.microsoftLogo,
      name: 'Microsoft',
      isFeatured: true,
      productCount: 117,
    ),
  ];

  static final List<CategoryModel> categories = [
    CategoryModel(
        id: '1', image: SImages.sportIcon, name: 'Sports', isFeatured: true),
    CategoryModel(
        id: '2',
        image: SImages.electronicsIcon,
        name: 'Electronics',
        isFeatured: true),
    CategoryModel(
        id: '3', image: SImages.clothIcon, name: 'Clothes', isFeatured: true),
    CategoryModel(
        id: '4', image: SImages.animalIcon, name: 'Animals', isFeatured: true),
    CategoryModel(
        id: '5',
        image: SImages.furnitureIcon,
        name: 'Furniture',
        isFeatured: true),
    CategoryModel(
        id: '6', image: SImages.shoeIcon, name: 'Shoes', isFeatured: true),
    CategoryModel(
        id: '7',
        image: SImages.cosmeticsIcon,
        name: 'Cosmetics',
        isFeatured: true),
    CategoryModel(
        id: '8',
        image: SImages.jeweleryIcon,
        name: 'Jewelry',
        isFeatured: true),
  ];

  static final List<ProductModel> products = [
    ProductModel(
      id: '002',
      title: 'Nike Air Force 1',
      thumbnail: SImages.pants_image,
      productType: 'productType.single',
      stock: 20,
      price: 8000.00,
      description: 'Iconic basketball shoes',
      isFeatured: true,
      images: [
        SImages.dress_image,
        SImages.pants_image,
        SImages.shirt_image,
      ],
      brand: BrandModel(
        name: 'Nike',
        id: '10',
        image: SImages.nikeLogo,
        isFeatured: true,
      ),
      salePrice: 7500.00,
      sku: 'AF1',
      categoryId: '6',
      productAttributes: [],
      productVariations: [
        ProductVariationModel(
          id: '1',
          stock: 20,
          price: 8000.00,
          salePrice: 7500.00,
          description: 'Nike Air Force 1',
          attributesVariables: {},
        ),
      ],
    ),
    ProductModel(
      id: '003',
      title: 'Adidas Ultraboost',
      thumbnail: SImages.shirt_image,
      productType: 'productType.variable',
      stock: 25,
      price: 12000.00,
      description: 'Running shoes with responsive cushioning',
      isFeatured: true,
      images: [
        SImages.dress_image,
        SImages.pants_image,
        SImages.shirt_image,
      ],
      brand: BrandModel(
        name: 'Adidas',
        id: '2',
        image: SImages.adidasLogo,
        isFeatured: true,
      ),
      salePrice: 10000.00,
      sku: 'UB',
      categoryId: '6',
      productAttributes: [
        ProductAttributeModel(
            name: 'Color', values: ['Black', 'White', 'Grey']),
        ProductAttributeModel(name: 'Size', values: ['US 8', 'US 9', 'US 10']),
      ],
      productVariations: [
        ProductVariationModel(
          id: '1',
          stock: 10,
          price: 12000.00,
          salePrice: 10000.00,
          description: 'Black Ultraboost, size US 8',
          attributesVariables: {
            'Color': 'Black',
            'Size': 'US 8',
          },
        ),
        ProductVariationModel(
          id: '2',
          stock: 10,
          price: 12000.00,
          salePrice: 10000.00,
          description: 'White Ultraboost, size US 9',
          attributesVariables: {
            'Color': 'White',
            'Size': 'US 9',
          },
        ),
        ProductVariationModel(
          id: '3',
          stock: 10,
          price: 12000.00,
          salePrice: 10000.00,
          description: 'Grey Ultraboost, size US 10',
          attributesVariables: {
            'Color': 'Grey',
            'Size': 'US 10',
          },
        ),
      ],
    ),
    ProductModel(
      id: '004',
      title: 'Samsung Galaxy S21',
      thumbnail: SImages.dress_image,
      productType: 'productType.single',
      stock: 15,
      price: 80000.00,
      description: 'Flagship smartphone with advanced camera',
      isFeatured: true,
      images: [
        SImages.pants_image,
        SImages.shirt_image,
      ],
      brand: BrandModel(
        name: 'Samsung',
        id: '11',
        image: SImages.samsungLogo,
        isFeatured: true,
      ),
      salePrice: 75000.00,
      sku: 'GS21',
      categoryId: '2',
      productAttributes: [],
      productVariations: [
        ProductVariationModel(
          id: '1',
          stock: 15,
          price: 80000.00,
          salePrice: 75000.00,
          description: 'Samsung Galaxy S21',
          attributesVariables: {},
        ),
      ],
    ),
    ProductModel(
      id: '005',
      title: 'Sony WH-1000XM4',
      thumbnail: SImages.pants_image,
      productType: 'productType.single',
      stock: 20,
      price: 25000.00,
      description: 'Wireless noise-canceling headphones',
      isFeatured: true,
      images: [
        SImages.shirt_image,
        SImages.dress_image,
      ],
      brand: BrandModel(
        name: 'Sony',
        id: '13',
        image: SImages.sonyLogo,
        isFeatured: true,
      ),
      salePrice: 23000.00,
      sku: 'WH1000XM4',
      categoryId: '2',
      productAttributes: [],
      productVariations: [
        ProductVariationModel(
          id: '1',
          stock: 20,
          price: 25000.00,
          salePrice: 23000.00,
          description: 'Sony WH-1000XM4',
          attributesVariables: {},
        ),
      ],
    ),
  ];

  static final List<ProductCategoryModel> productCategory = [
    ProductCategoryModel(
      productId: '002',
      categoryId: '6',
    ),
    ProductCategoryModel(
      productId: '003',
      categoryId: '6',
    ),
    ProductCategoryModel(
      productId: '004',
      categoryId: '2',
    ),
    ProductCategoryModel(
      productId: '005',
      categoryId: '2',
    ),
  ];

  static final List<BrandCategoryModel> brandCategory = [
    BrandCategoryModel(
      brandId: '1',
      categoryId: '2',
    ),
    BrandCategoryModel(
      brandId: '2',
      categoryId: '6',
    ),
    BrandCategoryModel(
      brandId: '11',
      categoryId: '2',
    ),
    BrandCategoryModel(
      brandId: '13',
      categoryId: '2',
    ),
  ];
}
