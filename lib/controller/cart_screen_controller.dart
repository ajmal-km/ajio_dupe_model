import 'dart:developer';
import 'package:ajio_dupe_model/model/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class CartScreenController with ChangeNotifier {
  final cartBox = Hive.box<CartModel>("cartBox");
  List<CartModel> cart = [];
  List cartKeys = [];
  double totalPrice = 0;

  Future<void> addProduct({
    required int id,
    required String name,
    String? image,
    String? description,
    required double price,
  }) async {
    bool isAlreadyCarted = false;
    for (int i = 0; i < cart.length; i++) {
      if (id == cart[i].id) {
        isAlreadyCarted = true;
      }
    }
    print(isAlreadyCarted);
    if (isAlreadyCarted) {
      print("Item already carted !");
    } else {
      await cartBox.add(
        CartModel(
          id: id,
          image: image,
          name: name,
          description: description,
          price: price.toDouble(),
          qty: 1,
        ),
      );
      getCartedProduct();
    }
  }

  void getCartedProduct() {
    cartKeys = cartBox.keys.toList();
    cart = cartBox.values.toList();
    notifyListeners();
  }

  Future<void> removeProduct(int index) async {
    await cartBox.deleteAt(index);
    getCartedProduct();
  }

  void incrementQty(int index) {
    cartKeys[index];
    int currentQty = cart[index].qty;
    currentQty++;
    log(currentQty.toString());
    cartBox.put(
        cartKeys[index],
        CartModel(
          id: cart[index].id,
          image: cart[index].image,
          description: cart[index].description,
          name: cart[index].name,
          price: cart[index].price,
          qty: currentQty,
        ));
    getCartedProduct();
  }

  void decrementQty(int index) {
    cartKeys[index];
    int currentQty = cart[index].qty;
    if (cart[index].qty > 1) {
      currentQty--;
      log(currentQty.toString());
      cartBox.put(
          cartKeys[index],
          CartModel(
            id: cart[index].id,
            image: cart[index].image,
            description: cart[index].description,
            name: cart[index].name,
            price: cart[index].price,
            qty: currentQty,
          ));
      getCartedProduct();
    }
  }

  void calculateTotalPrice() {
    totalPrice = 0;
    for (int i = 0; i < cart.length; i++) {
      totalPrice += (cart[i].price! * cart[i].qty);
    }
    log(totalPrice.toString());
  }
}
