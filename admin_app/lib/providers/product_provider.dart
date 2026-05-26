import 'package:flutter/material.dart';

import '../models/product_model.dart';

import '../core/services/api_service.dart';

class ProductProvider with ChangeNotifier {
  List<ProductModel> _products = [];

  bool _isLoading = false;

  List<ProductModel> get products => _products;

  bool get isLoading => _isLoading;

  // FETCH PRODUCTS
  Future<void> fetchProducts() async {
    _isLoading = true;

    notifyListeners();

    _products = await ApiService().getProducts();

    _isLoading = false;

    notifyListeners();
  }

  // ADD PRODUCT
  Future<bool> addProduct(ProductModel product) async {
    bool success = await ApiService().addProduct(product);

    if (success) {
      await fetchProducts();
    }

    return success;
  }

  // UPDATE PRODUCT
  Future<bool> updateProduct(ProductModel product) async {
    bool success = await ApiService().updateProduct(product);

    if (success) {
      await fetchProducts();
    }

    return success;
  }

  // DELETE PRODUCT
  Future<bool> deleteProduct(int id) async {
    final success = await ApiService().deleteProduct(id);

    if (success) {
      _products.removeWhere((e) => e.id == id);

      notifyListeners();
    }

    return success;
  }

  // GET BY ID
  ProductModel? getById(int id) {
    try {
      return _products.firstWhere((e) => e.id == id);
    } catch (e) {
      return null;
    }
  }
}
