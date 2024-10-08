import 'package:ajio_dupe_model/controller/cart_screen_controller.dart';
import 'package:ajio_dupe_model/utils/color_constants.dart';
import 'package:ajio_dupe_model/view/cart_screen/widgets/cart_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        context.read<CartScreenController>().getCartedProduct();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<CartScreenController>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.blue,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: FaIcon(
            FontAwesomeIcons.arrowLeft,
            color: ColorConstants.white,
          ),
        ),
        title: Text(
          "My Cart",
          style: TextStyle(
            color: ColorConstants.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: ListView.separated(
        padding: EdgeInsets.only(top: 20),
        separatorBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Divider(
            height: 5,
            thickness: 5,
            color: ColorConstants.shadowBlack,
          ),
        ),
        itemCount: cartProvider.cart.length,
        itemBuilder: (context, index) => CartWidget(
          name: cartProvider.cart[index].name.toString(),
          image: cartProvider.cart[index].image.toString(),
          desc: cartProvider.cart[index].description.toString(),
          price: cartProvider.cart[index].price.toString(),
          qty: cartProvider.cart[index].qty.toString(),
          onTapRemove: () {
            context.read<CartScreenController>().removeProduct(index);
          },
          onIncrementQty: () {
            context.read<CartScreenController>().incrementQty(index);
          },
          onDecrementQty: () {
            context.read<CartScreenController>().decrementQty(index);
          },
        ),
      ),
    );
  }
}
