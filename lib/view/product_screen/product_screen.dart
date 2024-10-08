import 'package:ajio_dupe_model/controller/cart_screen_controller.dart';
import 'package:ajio_dupe_model/controller/product_screen_controller.dart';
import 'package:ajio_dupe_model/utils/color_constants.dart';
import 'package:ajio_dupe_model/view/cart_screen/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key, required this.id});

  final int id;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await context
            .read<ProductScreenController>()
            .getProduct(widget.id.toString());
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = context.watch<ProductScreenController>();
    return Scaffold(
      backgroundColor: ColorConstants.white,
      appBar: _buildAppBarSection(context, productProvider),
      body: productProvider.isLoading
          ? Center(
              child: CircularProgressIndicator(color: ColorConstants.blue),
            )
          : Column(
              children: <Widget>[
                _buildProductDetailsSection(productProvider),
                _buildBottomContainerSection(productProvider),
              ],
            ),
    );
  }

  AppBar _buildAppBarSection(
      BuildContext context, ProductScreenController productProvider) {
    return AppBar(
      backgroundColor: ColorConstants.white,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back,
          color: ColorConstants.blue,
          size: 26,
        ),
      ),
      centerTitle: true,
      title: Text(
        "SHOPKART",
        style: TextStyle(
          color: ColorConstants.blue,
          letterSpacing: -1,
          fontSize: 26,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildProductDetailsSection(ProductScreenController productProvider) {
    return Expanded(
      child: ListView(
        padding: EdgeInsets.all(18),
        children: <Widget>[
          Container(
            height: 500,
            alignment: Alignment.topRight,
            padding: EdgeInsets.all(35),
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.contain,
                image: NetworkImage(
                    "${productProvider.product!.image.toString()}"),
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Container(
              height: 50,
              width: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: ColorConstants.white,
                borderRadius: BorderRadius.circular(9),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    offset: Offset(4, 3),
                    blurRadius: 5,
                    color: ColorConstants.shadowBlack,
                  ),
                ],
              ),
              child: Icon(
                Icons.favorite_border_outlined,
                color: ColorConstants.blue,
                size: 40,
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            "${productProvider.product!.title.toString()}",
            style: TextStyle(
              color: ColorConstants.blue,
              fontSize: 27,
              fontWeight: FontWeight.w600,
              letterSpacing: -1,
            ),
          ),
          SizedBox(height: 5),
          Row(
            children: <Widget>[
              SizedBox(width: 1.2),
              Text(
                "${productProvider.product!.rating!.rate.toString()}",
                style: TextStyle(
                  color: ColorConstants.green,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 8),
              Text(
                "(${productProvider.product!.rating!.count.toString()}) ratings",
                style: TextStyle(
                  color: ColorConstants.blue,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Text(
            "${productProvider.product!.description.toString()}",
            textAlign: TextAlign.justify,
            style: TextStyle(
              color: ColorConstants.black,
              fontSize: 19,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomContainerSection(ProductScreenController productProvider) {
    return Container(
      height: 100,
      padding: EdgeInsets.symmetric(horizontal: 23),
      decoration: BoxDecoration(
        color: ColorConstants.white,
        border: Border.symmetric(
          horizontal: BorderSide(width: 0.5, color: Colors.grey.shade300),
        ),
      ),
      child: Row(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Price",
                style: TextStyle(
                  color: ColorConstants.black,
                  fontSize: 15,
                ),
              ),
              Text(
                "₹ ${productProvider.product!.price.toString()}",
                style: TextStyle(
                  color: ColorConstants.green,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -1,
                ),
              ),
            ],
          ),
          SizedBox(width: 75),
          Expanded(
            child: GestureDetector(
              onTap: () async {
                await context.read<CartScreenController>().addProduct(
                      id: productProvider.product!.id!,
                      name: productProvider.product!.title.toString(),
                      price: productProvider.product!.price!,
                      image: productProvider.product!.image.toString(),
                      description:
                          productProvider.product!.description.toString(),
                    );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartScreen(),
                  ),
                );
              },
              child: Container(
                height: 64,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                decoration: BoxDecoration(
                  color: ColorConstants.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Icon(
                      Icons.shopping_cart_outlined,
                      color: ColorConstants.white,
                      size: 28,
                    ),
                    Text(
                      "Add to Cart",
                      style: TextStyle(
                        color: ColorConstants.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
