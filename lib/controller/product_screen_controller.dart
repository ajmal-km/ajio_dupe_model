import 'package:ajio_dupe_model/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductScreenController with ChangeNotifier {
  ProductModel? product;
  bool isLoading = false;
  Future<void> getProduct(String id) async {
    isLoading = true;
    notifyListeners();
    try {
      final url = Uri.parse("https://fakestoreapi.com/products/$id");
      var response = await http.get(url);
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        product = productModelFromJson(response.body);
      }
    } catch (e) {
      print(e);
    }
    isLoading = false;
    notifyListeners();
  }
}
