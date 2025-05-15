import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../wishlist_provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;

  const ProductDetailsScreen({Key? key, required this.product})
    : super(key: key);

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  String _selectedSize = 'M';
  String _selectedColor = 'Brown';
  int _currentImageIndex = 0;
  final PageController _pageController = PageController();

  final List<String> _sizes = ['S', 'M', 'L', 'XL', 'XXL', 'XXXL'];
  final List<Color> _colors = [
    const Color(0xFFD2B48C), // Light brown
    const Color(0xFF8B4513), // Dark brown
    const Color(0xFFA0522D), // Sienna
    const Color(0xFFCD853F), // Peru
    const Color(0xFF000000), // Black
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F8F8),
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImageSlider(),
            _buildProductInfo(),
            const SizedBox(height: 16),
            _buildSizeSelection(),
            const SizedBox(height: 16),
            _buildColorSelection(),
            const SizedBox(height: 16),
            _buildTotalPrice(),
          ],
        ),
      ),
      bottomNavigationBar: _buildAddToCartButton(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Color(0xFFF8F8F8),
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
      title: const Text(
        'Product Details',
        style: TextStyle(color: Colors.black, fontSize: 16),
      ),
      centerTitle: true,
      actions: [
        Consumer<WishlistProvider>(
          builder: (context, wishlistProvider, child) {
            final isInWishlist = wishlistProvider.isInWishlist(widget.product);
            return Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: IconButton(
                icon: Icon(
                  isInWishlist ? Icons.favorite : Icons.favorite_border,
                  color: isInWishlist ? Colors.red : Colors.black,
                ),
                onPressed: () {
                  wishlistProvider.toggleWishlist(widget.product);
                },
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildImageSlider() {
    // Generate additional images for the carousel
    final List<String> imageUrls = [
      widget.product.image,
      'https://fakestoreapi.com/img/71z3kpMAYsL._AC_UY879_.jpg',
      'https://fakestoreapi.com/img/71YXzeOuslL._AC_UY879_.jpg',
      'https://fakestoreapi.com/img/51Y5NI-I5jL._AC_UX679_.jpg',
      'https://fakestoreapi.com/img/81XH0e8fefL._AC_UY879_.jpg',
    ];

    return Container(
      height: 300,
      color: Color(0xFFF8F8F8),
      child: Stack(
        children: [
          // Main image
          PageView.builder(
            controller: _pageController,
            itemCount: imageUrls.length,
            onPageChanged: (index) {
              setState(() {
                _currentImageIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return Image.network(imageUrls[index], fit: BoxFit.contain);
            },
          ),

          // Small image indicators
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Container(
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: imageUrls.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      _pageController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: Container(
                      width: 60,
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border:
                            _currentImageIndex == index
                                ? Border.all(color: Colors.brown, width: 2)
                                : null,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Image.network(
                          imageUrls[index],
                          fit: BoxFit.cover,
                        ),
                      ),
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

  Widget _buildProductInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Female's Style",
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
              const Spacer(),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 16),
                  const SizedBox(width: 4),
                  const Text(
                    '4.5',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'Light Brown Jacket',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          const Text(
            'Product Details',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          const SizedBox(height: 4),
          const Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',
            style: TextStyle(color: Colors.grey, fontSize: 14),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size(50, 30),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              alignment: Alignment.centerLeft,
            ),
            child: const Text(
              'Read more',
              style: TextStyle(color: Colors.brown, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSizeSelection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Select Size',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          const SizedBox(height: 8),
          Row(
            children:
                _sizes.map((size) {
                  final isSelected = _selectedSize == size;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _selectedSize = size;
                        });
                      },
                      child: Container(
                        width: 36,
                        height: 36,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.brown : Colors.white,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color:
                                isSelected
                                    ? Colors.brown
                                    : Colors.grey.shade400,
                          ),
                        ),
                        child: Text(
                          size,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildColorSelection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Select Color',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              const SizedBox(width: 8),
              Text(': Brown', style: TextStyle(fontSize: 16)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children:
                _colors.map((color) {
                  final isSelected =
                      color == _colors[_colors.indexOf(color)] &&
                      (_selectedColor == 'Brown'
                          ? _colors.indexOf(color) == 0
                          : _colors.indexOf(color) != 0);
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (color == _colors[0]) {
                          _selectedColor = 'Brown';
                        } else {
                          _selectedColor = 'Other';
                        }
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 12),
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                        border:
                            isSelected
                                ? Border.all(color: Colors.brown, width: 2)
                                : null,
                      ),
                    ),
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }

  // Total Price is now handled in the bottom bar
  Widget _buildTotalPrice() {
    return const SizedBox.shrink();
  }

  Widget _buildAddToCartButton() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total Price',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              SizedBox(
                width: 160,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.shopping_cart, color: Colors.white),
                  label: const Text(
                    'Add to Cart',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8B4513),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Align(
            alignment: Alignment.centerLeft,
            child: const Text(
              '\$83.97',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
