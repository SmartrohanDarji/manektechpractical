import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manektech_practical/feature/cart_list/models/cart.dart';
import 'package:number_pagination/number_pagination.dart';

import '../../cart_list/screen/cart_list_page.dart';
import '../bloc/product_bloc.dart';
import '../bloc/product_event.dart';
import '../bloc/product_state.dart';
import '../models/product_list_model.dart';
import '../widgets/product_item.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({Key? key}) : super(key: key);

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  int selectedPageNumber = 1;
  int perPage = 5;
  @override
  void initState() {
    // TODO: implement initState
    fetchProducts(selectedPageNumber, perPage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductBloc, ProductState>(
      listener: (BuildContext ctx, state) async {
        if (state is Error) {
          final snackBar = SnackBar(content: Text(state.message));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else if (state is GetProductListSuccessfulState) {
          print(state.productListModel.data.length);
          context.read<ProductBloc>().add(GetCartCountEvent());
        } else if (state is AddProductToCartSuccessfulState) {
          print(state.message);
          context.read<ProductBloc>().add(GetCartCountEvent());
        } else if (state is GetCartCountSuccessfulState) {
          //context.read<ProductBloc>().add(SelectPageEvent(selectedPageNumber));
        }
      },
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Center(child: const Text("Shopping Mall")),
            backgroundColor: Colors.blue,
            actions: [
              Badge(
                badgeContent: BlocBuilder<ProductBloc, ProductState>(
                    buildWhen: (previous, current) =>
                        current is GetCartCountSuccessfulState,
                    builder: (context, state) {
                      if (state is Loading) {
                        return const SizedBox(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      } else if (state is GetCartCountSuccessfulState) {
                        return Text(
                          state.count.toString(),
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        );
                      } else {
                        return SizedBox.shrink();
                      }
                    }),
                position: const BadgePosition(start: 30, bottom: 30),
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CartListPage()));
                  },
                  icon: const Icon(Icons.shopping_cart),
                ),
              ),
              const SizedBox(
                width: 20.0,
              ),
            ],
          ),
          body: Stack(
            children: [
              Column(
                children: [
                  BlocBuilder<ProductBloc, ProductState>(
                      buildWhen: (previous, current) =>
                          current is GetProductListSuccessfulState,
                      builder: (context, state) {
                        if (state is Loading) {
                          return const SizedBox(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        } else if (state is GetProductListSuccessfulState) {
                          return Expanded(
                            child: GridView.count(
                                crossAxisCount:
                                    MediaQuery.of(context).orientation ==
                                            Orientation.portrait
                                        ? 2
                                        : 3,
                                childAspectRatio: 1.1,
                                padding: const EdgeInsets.all(10),
                                mainAxisSpacing: 6,
                                crossAxisSpacing: 6,
                                children: state.productListModel.data
                                    .map((Product product) {
                                  return ProductItem(
                                    product: product,
                                    onPress: () {
                                      context.read<ProductBloc>().add(
                                          AddProductToCartEvent(
                                              product.id.toString()));
                                    },
                                  );
                                }).toList()),
                          );
                        } else {
                          return SizedBox.shrink();
                        }
                      }),
                  BlocBuilder<ProductBloc, ProductState>(
                      buildWhen: (previous, current) =>
                          current is GetProductListSuccessfulState,
                      builder: (context, state) {
                        if (state is Loading) {
                          return const SizedBox(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        } else if (state is GetProductListSuccessfulState) {
                          return NumberPagination(
                            onPageChanged: (int pageNumber) {
                              setState(() {
                                selectedPageNumber = pageNumber;
                              });
                              fetchProducts(selectedPageNumber, perPage);
                            },
                            pageTotal:
                                (state.productListModel.totalRecord / perPage)
                                    .ceil(),
                            pageInit:
                                selectedPageNumber, // picked number when init page
                            colorPrimary: Colors.black,
                            colorSub: Colors.white,
                          );
                        } else {
                          return SizedBox.shrink();
                        }
                      }),
                ],
              ),
              BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
                if (state is Loading) {
                  return const SizedBox(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else {
                  return SizedBox.shrink();
                }
              })
            ],
          )),
    );
  }

  void fetchProducts(int page, int perPage) {
    context
        .read<ProductBloc>()
        .add(GetProductListEvent(page.toString(), perPage.toString()));
  }
}
