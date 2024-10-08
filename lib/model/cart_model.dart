import 'package:hive/hive.dart';
part 'cart_model.g.dart';

@HiveType(typeId: 1)
class CartModel {
  CartModel({
    this.id,
    this.image,
    this.price,
    this.qty = 0,
    this.name,
    this.description,
  });

  @HiveField(0)
  int? id;
  @HiveField(1)
  String? image;
  @HiveField(2)
  double? price;
  @HiveField(3)
  int qty;
  @HiveField(4)
  String? name;
  @HiveField(5)
  String? description;
}
