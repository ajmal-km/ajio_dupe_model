import 'dart:convert';

import 'package:ajio_dupe_model/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreenController with ChangeNotifier {
  List<ProductModel> productList = [];
  List categories = [];
  int selectedCategoryIndex = 0;
  bool isLoading = false;
  bool isGridLoading = false;
  Future<void> getCategory() async {
    isLoading = true;
    categories = ["All"];
    notifyListeners();
    try {
      final url = Uri.parse("https://fakestoreapi.com/products/categories");
      var response = await http.get(url);
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        categories.addAll(jsonDecode(response.body));
      }
    } catch (e) {
      print(e);
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> getAllProducts() async {
    isGridLoading = true;
    notifyListeners();
    try {
      final url = Uri.parse("https://fakestoreapi.com/products");
      var response = await http.get(url);
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        productList = productModelListFromJson(response.body);
      }
    } catch (e) {
      print(e);
    }
    isGridLoading = false;
    notifyListeners();
  }

  Future<void> getCategorizedProducts(String category) async {
    isGridLoading = true;
    notifyListeners();
    try {
      final url =
          Uri.parse("https://fakestoreapi.com/products/category/$category");
      var response = await http.get(url);
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        productList = productModelListFromJson(response.body);
      }
    } catch (e) {
      print(e);
    }
    isGridLoading = false;
    notifyListeners();
  }

  void setSelectedCategory(int index) {
    selectedCategoryIndex = index;
    notifyListeners();
    if (selectedCategoryIndex == 0) {
      getAllProducts();
    } else {
      getCategorizedProducts(categories[selectedCategoryIndex]);
    }
  }
}
