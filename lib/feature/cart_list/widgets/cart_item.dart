import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manektech_practical/feature/Widgets/custom_text.dart';
import 'package:manektech_practical/feature/cart_list/models/cart.dart';

class CartItem extends StatefulWidget {
  Cart cartListItemData;

  CartItem(this.cartListItemData, {Key? key}) : super(key: key);

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Card(
        elevation: 2,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(8), topLeft: Radius.circular(8)),
              child: Image.network(
                widget.cartListItemData.image!,
                height: MediaQuery.of(context).size.height *
                    (MediaQuery.of(context).orientation == Orientation.portrait
                        ? 0.15
                        : 0.40),
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 18, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                        text: widget.cartListItemData.productName!, size: 18),
                    SizedBox(
                      height: MediaQuery.of(context).size.height *
                          (MediaQuery.of(context).orientation ==
                                  Orientation.portrait
                              ? 0.02
                              : 0.06),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CustomText(text: "Price"),
                        CustomText(
                          text:
                              "\$${widget.cartListItemData.price!.toString()}",
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height *
                          (MediaQuery.of(context).orientation ==
                                  Orientation.portrait
                              ? 0.02
                              : 0.06),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: "Quantity",
                        ),
                        CustomText(
                          text: widget.cartListItemData.quantity.toString(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
