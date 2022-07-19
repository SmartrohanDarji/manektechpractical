import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Widgets/custom_text.dart';
import '../models/product_list_model.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  final Function() onPress;

  const ProductItem({Key? key, required this.product, required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(.5),
                offset: const Offset(3, 2),
                blurRadius: 7)
          ]),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                child: Image.network(
                  product.featuredImage,
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: CustomText(
                    text: product.title,
                    size: 14,
                    color: Colors.grey,
                    weight: FontWeight.normal,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                InkWell(
                  onTap: onPress,
                  child: const Icon(
                    Icons.shopping_cart,
                    color: Colors.grey,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
