// lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../product.dart';

class ApiService {
  static const String baseUrl = 'https://fakestoreapi.com';

  // Get all products
  Future<List<Product>> getProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/products'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => Product.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  // Get product by ID
  Future<Product> getProductById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/products/$id'));

    if (response.statusCode == 200) {
      return Product.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load product details');
    }
  }

  // Get all categories
  Future<List<String>> getCategories() async {
    final response = await http.get(Uri.parse('$baseUrl/products/categories'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => item.toString()).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  // Get products by category
  Future<List<Product>> getProductsByCategory(String categoryName) async {
    final response = await http.get(
      Uri.parse('$baseUrl/products/category/$categoryName'),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => Product.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load products for this category');
    }
  }
}
