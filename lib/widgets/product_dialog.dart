import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nijaao_web/data/products.dart';
import 'package:nijaao_web/models/product.dart';
import 'package:nijaao_web/theme/app_theme.dart';
import 'package:nijaao_web/utils/responsive.dart';
import 'package:nijaao_web/widgets/product_card.dart';

class ProductDialog extends StatefulWidget {
  const ProductDialog({super.key});

  @override
  State<ProductDialog> createState() => _ProductDialogState();
}

class _ProductDialogState extends State<ProductDialog>
    with SingleTickerProviderStateMixin {
  String _selectedCategory = 'All';
  late AnimationController _fadeController;
  Product? _selectedProduct;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);
    final List<Product> filteredProducts = _selectedCategory == 'All'
        ? ProductData.products
        : ProductData.products
              .where(
                (p) =>
                    p.category.toLowerCase() == _selectedCategory.toLowerCase(),
              )
              .toList();

    return MaterialApp(
      title: "Nijaao | Product",
      builder: (context, child) => Scaffold(
        body: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Center(
            child: Container(
              width: isMobile ? double.infinity : 950,
              height: isMobile ? MediaQuery.sizeOf(context).height * 0.9 : 680,
              margin: EdgeInsets.all(isMobile ? 12 : 24),
              decoration: BoxDecoration(
                color: AppTheme.backgroundIvory,
                borderRadius: BorderRadius.circular(isMobile ? 24 : 32),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.12),
                    blurRadius: 32,
                    offset: const Offset(0, 16),
                  ),
                ],
                border: Border.all(
                  color: AppTheme.darkGreen.withOpacity(0.08),
                  width: 1,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(isMobile ? 24 : 32),
                child: Stack(
                  children: [
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (child, anim) {
                        return FadeTransition(
                          opacity: anim,
                          child: SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(0, 0.05),
                              end: Offset.zero,
                            ).animate(anim),
                            child: child,
                          ),
                        );
                      },
                      child: _selectedProduct == null
                          ? _buildProductListSection(filteredProducts, isMobile)
                          : _buildProductDetailSection(
                              _selectedProduct!,
                              isMobile,
                            ),
                    ),

                    // Close Button
                    Positioned(
                      top: 20,
                      right: 20,
                      child: Material(
                        color: Colors.white,
                        shape: const CircleBorder(),
                        elevation: 2,
                        shadowColor: AppTheme.darkGreen.withOpacity(0.2),
                        child: IconButton(
                          icon: const Icon(
                            Icons.close_rounded,
                            color: AppTheme.darkGreen,
                            size: 22,
                          ),
                          onPressed: () {
                            if (_selectedProduct != null) {
                              setState(() {
                                _selectedProduct = null;
                              });
                            } else {
                              Navigator.of(context).pop();
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductListSection(List<Product> products, bool isMobile) {
    return Container(
      key: const ValueKey('list'),
      padding: EdgeInsets.fromLTRB(
        isMobile ? 20 : 40,
        36,
        isMobile ? 20 : 40,
        24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header titles
          const Text(
            'Coming Soon to Nijaao',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w900,
              color: AppTheme.darkGreen,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Here’s a little preview of what we’re preparing for you.',
            style: TextStyle(fontSize: 15, color: AppTheme.textGrey),
          ),
          const SizedBox(height: 24),

          // Categories chips row
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: ProductData.categories.map((category) {
                final bool isSelected = _selectedCategory == category;
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: ChoiceChip(
                    label: Text(category),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) {
                        setState(() {
                          _selectedCategory = category;
                        });
                      }
                    },
                    selectedColor: AppTheme.darkGreen,
                    backgroundColor: Colors.white,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : AppTheme.darkGreen,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.w500,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(
                        color: isSelected
                            ? Colors.transparent
                            : AppTheme.darkGreen.withOpacity(0.12),
                      ),
                    ),
                    showCheckmark: false,
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 24),

          // Products Display (Grid)
          Expanded(
            child: AnimatedSize(
              duration: const Duration(milliseconds: 300),
              child: products.isEmpty
                  ? const Center(
                      child: Text(
                        'No products found in this category.',
                        style: TextStyle(color: AppTheme.textGrey),
                      ),
                    )
                  : GridView.builder(
                      itemCount: products.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: isMobile ? 1 : 3,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        childAspectRatio: isMobile ? 1.15 : 0.78,
                      ),
                      itemBuilder: (context, index) {
                        return TweenAnimationBuilder<double>(
                          tween: Tween(begin: 0.0, end: 1.0),
                          duration: Duration(milliseconds: 200 + (index * 100)),
                          builder: (context, value, child) {
                            return Transform.translate(
                              offset: Offset(0, 30 * (1.0 - value)),
                              child: Opacity(opacity: value, child: child),
                            );
                          },
                          child: ProductCard(
                            product: products[index],
                            onTap: () {
                              setState(() {
                                _selectedProduct = products[index];
                              });
                            },
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductDetailSection(Product product, bool isMobile) {
    return Container(
      key: const ValueKey('detail'),
      padding: EdgeInsets.all(isMobile ? 24 : 48),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isMobile) const SizedBox(height: 36),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  color: AppTheme.darkGreen,
                ),
                onPressed: () {
                  setState(() {
                    _selectedProduct = null;
                  });
                },
              ),
              const Text(
                'Back to gallery',
                style: TextStyle(
                  color: AppTheme.darkGreen,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: Responsive(
              mobile: Column(
                children: [
                  Expanded(child: _buildProductDetailImage(product)),
                  const SizedBox(height: 24),
                  Expanded(
                    child: SingleChildScrollView(
                      child: _buildProductDetailInfo(product),
                    ),
                  ),
                ],
              ),
              desktop: Row(
                children: [
                  Expanded(flex: 5, child: _buildProductDetailImage(product)),
                  const SizedBox(width: 48),
                  Expanded(flex: 5, child: _buildProductDetailInfo(product)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductDetailImage(Product product) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppTheme.backgroundIvory,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Center(
        child: Image.asset(
          product.image,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(
              Icons.shopping_bag_outlined,
              size: 84,
              color: AppTheme.darkGreen,
            );
          },
        ),
      ),
    );
  }

  Widget _buildProductDetailInfo(Product product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppTheme.accentGold.withOpacity(0.12),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            'COMING SOON TO EXCLUSIVE CATALOGUE',
            style: TextStyle(
              color: AppTheme.darkGreen,
              fontSize: 11,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          product.name,
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w900,
            color: AppTheme.darkGreen,
            letterSpacing: -1.0,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Category: ${product.category}',
          style: const TextStyle(
            color: AppTheme.naturalGreen,
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          product.shortDescription,
          style: const TextStyle(
            fontSize: 16,
            color: AppTheme.textGrey,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 32),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _selectedProduct = null;
            });
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.darkGreen,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 0,
          ),
          child: const Text(
            'Notify Me on Launch',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ],
    );
  }
}
