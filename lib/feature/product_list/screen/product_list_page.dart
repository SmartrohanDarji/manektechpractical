import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manektech_practical/feature/product_list/screen/product_list_screen.dart';

import '../../../core/injection_container.dart';
import '../bloc/product_bloc.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({Key? key}) : super(key: key);

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductBloc>(
      create: (_) => sl<ProductBloc>(),
      child: const ProductListScreen(),
    );
  }
}
