import 'package:flutter/material.dart';
import 'profile_screen.dart';
import 'home_page.dart';
import 'shopping_cart.dart';
import 'wishlist_screen.dart';

class GlobalPage extends StatefulWidget {
  const GlobalPage({Key? key}) : super(key: key);

  @override
  _GlobalPageState createState() => _GlobalPageState();
}

class _GlobalPageState extends State<GlobalPage>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0; // Initialize to 0 for Home to be selected by default
  late AnimationController _controller;
  int _previousIndex = 0;
  bool _showBottomNav = true;

  // List of icons for navigation items
  static const List<IconData> _navIcons = [
    Icons.home,
    Icons.shopping_bag_outlined,
    Icons.favorite_border,
    Icons.messenger_outline,
    Icons.person_outline_outlined,
  ];

  static final List<Widget> _pages = [
    HomeScreen(),
    ShoppingCartScreen(),
    WishlistScreen(),
    WishlistScreen(),
    ProfileCompletionScreen(),
  ];

  static _GlobalPageState? _instance;

  @override
  void initState() {
    super.initState();
    _instance = this;
    _controller = AnimationController(
      duration: const Duration(milliseconds: 350),
      vsync: this,
    );
    // Start with the Home icon highlighted
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _instance = null;
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (_selectedIndex == index) return;

    _previousIndex = _selectedIndex;
    setState(() {
      _selectedIndex = index;
      _updateBottomNavVisibility(index); // Update visibility based on index
    });

    _controller.reset();
    _controller.forward();
  }

  void _updateBottomNavVisibility(int index) {
    setState(() {
      _showBottomNav =
          index != 1 && index != 4; // Hide for ShoppingCart (1) and Profile (4)
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _pages[_selectedIndex],
          if (_showBottomNav)
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF0E0D20),
                  borderRadius: BorderRadius.circular(38),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                margin: const EdgeInsets.only(bottom: 25),
                height: 70,
                width: MediaQuery.of(context).size.width * 0.85,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildAnimatedNavItem(_navIcons[0], 0),
                    _buildAnimatedNavItem(_navIcons[1], 1),
                    _buildAnimatedNavItem(_navIcons[2], 2),
                    _buildAnimatedNavItem(_navIcons[3], 3),
                    _buildAnimatedNavItem(_navIcons[4], 4),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildAnimatedNavItem(IconData icon, int index) {
    final isSelected = _selectedIndex == index;
    final wasSelected = _previousIndex == index;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        double scale = 1.0;
        if (isSelected) {
          scale = 1.0 + (_controller.value * 0.2);
        } else if (wasSelected) {
          scale = 1.2 - (_controller.value * 0.2);
        }

        Color backgroundColor = Colors.transparent;
        if (isSelected) {
          backgroundColor = const Color.fromARGB(
            255,
            240,
            238,
            236,
          ).withOpacity(_controller.value);
        } else if (wasSelected) {
          backgroundColor = const Color(
            0xFFFD5536,
          ).withOpacity(1 - _controller.value);
        }

        return InkWell(
          onTap: () => _onItemTapped(index),
          child: TweenAnimationBuilder(
            tween: Tween<double>(
              begin: isSelected ? 0.8 : 1.0,
              end: isSelected ? 1.0 : 1.0,
            ),
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            builder: (context, double value, child) {
              return Transform.scale(
                scale: scale,
                child: Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Opacity(
                      opacity: isSelected ? 1.0 : 0.7,
                      child: Icon(
                        icon,
                        size: 25,
                        color:
                            isSelected
                                ? const Color.fromARGB(255, 78, 43, 4)
                                : Colors.grey,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
