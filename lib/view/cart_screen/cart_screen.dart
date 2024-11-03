import 'package:ajio_dupe_model/controller/cart_screen_controller.dart';
import 'package:ajio_dupe_model/utils/color_constants.dart';
import 'package:ajio_dupe_model/view/cart_screen/widgets/cart_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

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
        context.read<CartScreenController>().calculateTotalPrice();
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
      bottomNavigationBar: Container(
        height: 67,
        padding: EdgeInsets.symmetric(horizontal: 18),
        color: ColorConstants.white,
        child: Row(
          children: <Widget>[
            Text(
              "Total : ₹ ${cartProvider.totalPrice}",
              style: TextStyle(
                color: ColorConstants.black,
                fontSize: 19,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.6,
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                Razorpay razorpay = Razorpay();
                var options = {
                  'key': 'rzp_live_ILgsfZCZoFIKMb',
                  'amount': cartProvider.totalPrice * 100,
                  'name': 'Acme Corp.',
                  'description': 'Fine T-Shirt',
                  'retry': {'enabled': true, 'max_count': 1},
                  'send_sms_hash': true,
                  'prefill': {
                    'contact': '8888888888',
                    'email': 'test@razorpay.com'
                  },
                  'external': {
                    'wallets': ['paytm']
                  }
                };
                razorpay.on(
                    Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
                razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
                    handlePaymentSuccessResponse);
                razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
                    handleExternalWalletSelected);
                razorpay.open(options);
              },
              child: Container(
                height: 38,
                padding: EdgeInsets.symmetric(horizontal: 17),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: ColorConstants.green,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  "Check Out",
                  style: TextStyle(
                    color: ColorConstants.white,
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.6,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    /*
    * PaymentFailureResponse contains three values:
    * 1. Error Code
    * 2. Error Description
    * 3. Metadata
    * */
    showAlertDialog(context, "Payment Failed",
        "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}");
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
    /*
    * Payment Success Response contains three values:
    * 1. Order ID
    * 2. Payment ID
    * 3. Signature
    * */
    showAlertDialog(
        context, "Payment Successful", "Payment ID: ${response.paymentId}");
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {
    showAlertDialog(
        context, "External Wallet Selected", "${response.walletName}");
  }

  void showAlertDialog(BuildContext context, String title, String message) {
    // set up the buttons
    Widget continueButton = ElevatedButton(
      child: const Text("Continue"),
      onPressed: () {},
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
