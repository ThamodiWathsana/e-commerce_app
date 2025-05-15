import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../product.dart';
import 'product_screen.dart';
import '../widgets/category_item.dart';
import '../services/api_service.dart';
import '../widgets/product_card.dart';
import 'product_screen.dart';
import 'wishlist_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService _apiService = ApiService();
  List<Product> _products = [];
  bool _isLoading = true;
  int _selectedBottomNavIndex = 0;
  String _selectedCategory = 'All';
  String _selectedSortOption = 'Newest';

  int _hours = 2;
  int _minutes = 12;
  int _seconds = 56;

  @override
  void initState() {
    super.initState();
    _loadProducts();
    _startCountdownTimer();
  }

  void _startCountdownTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;

      setState(() {
        if (_seconds > 0) {
          _seconds--;
        } else {
          _seconds = 59;
          if (_minutes > 0) {
            _minutes--;
          } else {
            _minutes = 59;
            if (_hours > 0) {
              _hours--;
            }
          }
        }
      });

      _startCountdownTimer();
    });
  }

  Future<void> _loadProducts() async {
    try {
      final products = await _apiService.getProducts();
      setState(() {
        _products = products.cast<Product>();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to load products: \$e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : Column(
                  children: [
                    _buildTopUI(),
                    _buildSearchBar(),
                    Expanded(
                      child: CustomScrollView(
                        slivers: [
                          SliverToBoxAdapter(child: _buildPromoImage()),
                          SliverToBoxAdapter(child: _buildCategoriesSection()),
                          SliverToBoxAdapter(child: _buildFlashSaleHeader()),
                          SliverToBoxAdapter(child: _buildFilterOptions()),
                          _buildProductsGrid(),
                          SliverToBoxAdapter(child: SizedBox(height: 60)),
                        ],
                      ),
                    ),
                  ],
                ),
      ),
    );
  }

  Widget _buildTopUI() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Location',
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.brown, size: 18),
                    SizedBox(width: 4),
                    Text(
                      'New York, USA',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Icon(Icons.keyboard_arrow_down, color: Colors.black),
                  ],
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              shape: BoxShape.circle,
            ),
            padding: EdgeInsets.all(10),
            child: Stack(
              children: [
                Icon(Icons.notifications_outlined, size: 24),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    constraints: BoxConstraints(minWidth: 12, minHeight: 12),
                    child: Text(
                      '5',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 46,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.grey.shade300, width: 0.5),
              ),
              child: Row(
                children: [
                  SizedBox(width: 16),
                  Icon(Icons.search, color: Colors.brown, size: 20),
                  SizedBox(width: 8),
                  Text(
                    "Search",
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 12),
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: Colors.brown,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 5,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  SizedBox(width: 3),
                  Container(
                    width: 5,
                    height: 16,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  SizedBox(width: 3),
                  Container(
                    width: 5,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPromoImage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          color: const Color(0xFFF5F0E5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            'assets/top.png',
            fit: BoxFit.cover,
            width: double.infinity,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.grey[300],
                child: const Center(
                  child: Icon(Icons.image_not_supported, color: Colors.grey),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildFlashSaleHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween, // Space between title and timer
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Flash Sale',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Closing in:',
                  style: TextStyle(fontSize: 12, color: Colors.black54),
                ),
                const SizedBox(width: 8),
                _buildTimerBox(_hours.toString().padLeft(2, '0')),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2),
                  child: Text(':'),
                ),
                _buildTimerBox(_minutes.toString().padLeft(2, '0')),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2),
                  child: Text(':'),
                ),
                _buildTimerBox(_seconds.toString().padLeft(2, '0')),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimerBox(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.brown.shade50,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.brown.shade200),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildCategoriesSection() {
    final categories = [
      CategoryModel(name: 'T-Shirt', icon: Icons.style),
      CategoryModel(name: 'Pant', icon: Icons.door_sliding_outlined),
      CategoryModel(name: 'Dress', icon: Icons.dry_cleaning),
      CategoryModel(name: 'Jacket', icon: Icons.highlight),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  'Category',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'See All',
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 90, // Slightly increased to avoid clipping
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: SizedBox(
                  width: 80, // Restrict item width to prevent overflow
                  child: CategoryItem(
                    category: categories[index],
                    isSelected: _selectedCategory == categories[index].name,
                    onTap: () {
                      setState(() {
                        _selectedCategory = categories[index].name;
                      });
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFilterOptions() {
    final options = ['All', 'Newest', 'Popular', 'Man', 'Woman'];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children:
            options.map((option) {
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: ChoiceChip(
                  label: Text(option),
                  selected: _selectedSortOption == option,
                  onSelected: (selected) {
                    if (selected) {
                      setState(() {
                        _selectedSortOption = option;
                      });
                    }
                  },
                  backgroundColor: Colors.white,
                  selectedColor: Colors.brown,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: const BorderSide(color: Colors.grey, width: 0.5),
                  ),
                  labelStyle: TextStyle(
                    color:
                        _selectedSortOption == option
                            ? Colors.white
                            : Colors.black,
                    fontSize: 12,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }

  Widget _buildProductsGrid() {
    final filteredProducts =
        _selectedCategory == 'All'
            ? _products
            : _products.where((product) {
              if (_selectedCategory == 'T-Shirt')
                return product.category.contains('clothing');
              if (_selectedCategory == 'Pant')
                return product.category.contains('clothing');
              if (_selectedCategory == 'Dress')
                return product.category.contains('women');
              if (_selectedCategory == 'Jacket')
                return product.category.contains('clothing');
              return true;
            }).toList();

    if (_selectedSortOption == 'Newest') {
      filteredProducts.sort((a, b) => b.id.compareTo(a.id));
    } else if (_selectedSortOption == 'Popular') {
      filteredProducts.sort((a, b) => b.rating.rate.compareTo(a.rating.rate));
    }

    if (filteredProducts.isEmpty) {
      return SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Center(
            child: Text(
              'No products found for \$_selectedCategory category',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
        ),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: MediaQuery.of(context).size.width > 400 ? 0.7 : 0.6,
          crossAxisSpacing: 12,
          mainAxisSpacing: 16,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            if (index >= filteredProducts.length) return null;
            final product = filteredProducts[index];
            return ProductCard(
              product: product,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => ProductDetailsScreen(product: product),
                  ),
                );
              },
            );
          },
          childCount: filteredProducts.length < 4 ? filteredProducts.length : 4,
        ),
      ),
    );
  }
}

class CategoryModel {
  final String name;
  final IconData icon;

  CategoryModel({required this.name, required this.icon});
}
