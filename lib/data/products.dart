import 'package:nijaao_web/models/product.dart';

class ProductData {
  static const List<Product> products = [
    Product(
      name: 'Premium Mustard Oil',
      category: 'Oils',
      image: 'assets/product/1000055475-removebg-preview.png',
      shortDescription: 'Pure wood-pressed mustard oil for authentic taste and health.',
    ),
    Product(
      name: 'Refined Sunflower Oil',
      category: 'Oils',
      image: 'assets/product/1000055869-removebg-preview.png',
      shortDescription: 'Light and healthy sunflower oil perfect for your daily cooking.',
    ),
    Product(
      name: 'Organic Grocery Pack',
      category: 'Grocery',
      image: 'assets/product/1000055870-removebg-preview.png',
      shortDescription: 'Handpicked organic staples for a better tomorrow.',
    ),
    Product(
      name: 'Pure Honey',
      category: 'Food',
      image: 'assets/product/1000056218-removebg-preview.png',
      shortDescription: 'Naturally sourced honey, rich in nutrients and flavor.',
    ),
    Product(
      name: 'Home Essentials',
      category: 'Household',
      image: 'assets/product/1000055475-removebg-preview.png',
      shortDescription: 'Everything you need to keep your home running smoothly.',
    ),
    Product(
      name: 'Natural Care Soap',
      category: 'Personal Care',
      image: 'assets/product/1000055869-removebg-preview.png',
      shortDescription: 'Gentle on skin, tough on impurities. Inspired by nature.',
    ),
  ];

  static const List<String> categories = [
    'All',
    'Oils',
    'Grocery',
    'Food',
    'Household',
    'Personal Care',
  ];
}
