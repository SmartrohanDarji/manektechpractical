import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/injection_container.dart';
import '../../product_list/bloc/product_bloc.dart';
import 'cart_list_screen.dart';

class CartListPage extends StatefulWidget {
  const CartListPage({Key? key}) : super(key: key);

  @override
  _CartListPageState createState() => _CartListPageState();
}

class _CartListPageState extends State<CartListPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductBloc>(
      create: (_) => sl<ProductBloc>(),
      child: CartListScreen(),
    );
  }
}
