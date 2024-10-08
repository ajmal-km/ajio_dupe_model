import 'package:ajio_dupe_model/utils/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({
    super.key,
    this.image,
    required this.name,
    required this.price,
    required this.qty,
    this.onIncrementQty,
    this.onDecrementQty,
    this.onTapRemove,
    this.desc,
  });

  final String? image;
  final String name;
  final String? desc;
  final String price;
  final String qty;
  final void Function()? onIncrementQty;
  final void Function()? onDecrementQty;
  final void Function()? onTapRemove;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            decoration: BoxDecoration(
              color: ColorConstants.shadowBlack,
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                    color: ColorConstants.white,
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: NetworkImage(image!),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: ColorConstants.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            letterSpacing: -0.4,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "₹ ${price}",
                          style: TextStyle(
                            color: ColorConstants.green,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      onPressed: onIncrementQty,
                      icon: FaIcon(
                        FontAwesomeIcons.plus,
                        color: ColorConstants.black,
                        size: 18,
                      ),
                    ),
                    Text(
                      qty,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: ColorConstants.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    IconButton(
                      onPressed: onDecrementQty,
                      icon: FaIcon(
                        FontAwesomeIcons.minus,
                        color: ColorConstants.black,
                        size: 18,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onTapRemove,
            child: Container(
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: ColorConstants.black,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(12)),
              ),
              child: Text(
                "Remove",
                style: TextStyle(
                  color: ColorConstants.white,
                  fontSize: 21,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.5,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
