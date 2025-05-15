import 'package:flutter/foundation.dart';
import 'models/product.dart';

class WishlistProvider extends ChangeNotifier {
  final List<Product> _wishlist = [];

  List<Product> get wishlist => _wishlist;

  bool isInWishlist(Product product) {
    return _wishlist.any((item) => item.id == product.id);
  }

  void addToWishlist(Product product) {
    if (!isInWishlist(product)) {
      _wishlist.add(product);
      notifyListeners();
    }
  }

  void removeFromWishlist(Product product) {
    _wishlist.removeWhere((item) => item.id == product.id);
    notifyListeners();
  }

  void toggleWishlist(Product product) {
    if (isInWishlist(product)) {
      removeFromWishlist(product);
    } else {
      addToWishlist(product);
    }
  }
}
