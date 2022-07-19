import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:connectivity/connectivity.dart';
import 'package:logger/logger.dart';
import 'package:manektech_practical/core/dbHelper/dbHelper.dart';

import '../feature/product_list/bloc/product_bloc.dart';
import '../feature/product_list/repo/product_list_repository.dart';
import '../feature/product_list/repo/product_list_repository_impl.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! External /* All the other required external injection are embedded here */
  await _initExternalDependencies();

  // Repository /* All the repository injection are embedded here */
  _initRepositories();

  // Bloc /* All the bloc injection are embedded here */
  _initBlocs();
}

void _initBlocs() {
  sl.registerFactory(() => ProductBloc(repository: sl()));
}

void _initRepositories() {
  sl.registerLazySingleton(() => DBHelper());
  sl.registerLazySingleton<ProductListRepository>(() =>
      ProductListRepositoryImpl(dio: sl(), connectivity: sl(), dbHelper: sl()));
}

Future<void> _initExternalDependencies() async {
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => Connectivity());
  sl.registerLazySingleton(() => Logger());
}
