import 'package:ajio_dupe_model/utils/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ShoppingCard extends StatelessWidget {
  const ShoppingCard({
    super.key,
    required this.image,
    required this.title,
    required this.price,
    this.onCardTapped,
  });

  final String image;
  final String title;
  final String price;
  final void Function()? onCardTapped;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onCardTapped,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 270,
            padding: EdgeInsets.all(15),
            alignment: Alignment.topRight,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.contain,
                image: NetworkImage(image),
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Container(
              height: 38,
              width: 38,
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
              child: FaIcon(
                FontAwesomeIcons.heart,
                color: ColorConstants.blue,
                size: 30,
              ),
            ),
          ),
          SizedBox(height: 5),
          Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: ColorConstants.black,
              fontSize: 18,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.6,
            ),
          ),
          SizedBox(height: 2),
          Text(
            "₹ ${price}",
            style: TextStyle(
              color: ColorConstants.green,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
