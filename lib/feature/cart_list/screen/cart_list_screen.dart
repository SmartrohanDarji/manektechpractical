import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manektech_practical/feature/Widgets/custom_text.dart';
import 'package:manektech_practical/feature/product_list/bloc/product_event.dart';

import '../../product_list/bloc/product_bloc.dart';
import '../../product_list/bloc/product_state.dart';
import '../widgets/cart_item.dart';

class CartListScreen extends StatefulWidget {
  const CartListScreen({Key? key}) : super(key: key);

  @override
  _CartListScreenState createState() => _CartListScreenState();
}

class _CartListScreenState extends State<CartListScreen> {
  int totalQty = 0;
  int totalPrice = 0;

  @override
  void initState() {
    // TODO: implement initState
    getListData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("My Cart"),
          backgroundColor: Colors.blue,
        ),
        body: BlocBuilder<ProductBloc, ProductState>(
            buildWhen: (previous, current) =>
                current is GetCartListSuccessfulState,
            builder: (context, state) {
              if (state is Loading) {
                return const SizedBox(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is GetCartListSuccessfulState) {
                totalQty = state.cartList.length;
                return ListView.builder(
                    itemCount: state.cartList.length,
                    itemBuilder: (context, index) {
                      return CartItem(state.cartList[index]);
                    });
              } else {
                return const SizedBox.shrink();
              }
            }),
        bottomNavigationBar:
            BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
          if (state is Loading) {
            return const SizedBox(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is GetTotalDataSuccessfulState) {
            return Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              color: Colors.blue,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomText(
                      text: "Total Items: ${state.totalDataModel.totalItem}"),
                  CustomText(
                      text: "Grand Total: \$${state.totalDataModel.grandTotal}")
                ],
              ),
            );
          } else {
            return SizedBox.shrink();
          }
        }));
  }

  void getListData() {
    context.read<ProductBloc>().add(GetCartListEvent());
  }
}
