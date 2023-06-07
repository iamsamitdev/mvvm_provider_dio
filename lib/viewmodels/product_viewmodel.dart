import 'package:flutter/foundation.dart';
import 'package:mvvm_provider_dio/models/product_model.dart';
import 'package:mvvm_provider_dio/services/product_api_service.dart';

class ProductViewModel extends ChangeNotifier {

  // Create product api service instance
  final ProductApiService _productApiService = ProductApiService();

  // Product list
  List<ProductModel> _products = [];

  // Getter
  List<ProductModel> get products => _products;

  // Load products
  Future<void> loadProducts() async {
    _products = await _productApiService.getProducts();
    notifyListeners();
  }

}