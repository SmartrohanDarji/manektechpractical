import 'package:flutter/material.dart';
import 'core/dbHelper/dbHelper.dart';
import 'core/injection_container.dart' as di;
import 'core/injection_container.dart';
import 'feature/product_list/screen/product_list_page.dart';

void main() {
  di.init().then((value) => runApp(MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    sl<DBHelper>().initDatabase();
    // TODO: implement initState
    super.initState();
  }

  // This widgets is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ProductListPage(),
    );
  }
}
