import 'package:data_caching/core/helper/connection_helper.dart';
import 'package:data_caching/features/home/data/data_source/local/home_db_provider.dart';
import 'package:data_caching/features/home/data/data_source/local/home_db_service.dart';
import 'package:data_caching/features/home/data/data_source/remote/home_api_provider.dart';
import 'package:data_caching/features/home/data/repos/home_repo_impl.dart';
import 'package:data_caching/features/home/presentation/blocs/home_blocs/home_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

GetIt di = GetIt.instance;

Future<void> setUpDi() async {
  // Network services
  di.registerSingleton<Dio>(Dio());

  // Helper
  di.registerSingleton(InternetConnectionHelper());

  // Hive database
  await Hive.initFlutter();

  // Home db service
  di.registerSingleton(HomeDbService(),);

  // register adapters & open the box for products
  await di<HomeDbService>().init();

  // db & home provider
  di.registerSingleton(
    HomeDbProvider(
      homeDbService: di<HomeDbService>(),
    ),
  );

  // api & home provider
  di.registerSingleton(
    HomeApiProvider(di<Dio>()),
  );

  // repo & home repository
  di.registerSingleton(
    HomeRepoImpl(
      di<HomeApiProvider>(),
      di<HomeDbProvider>(),
    ),
  );
  
  // Blocs & New object every request
  di.registerFactory<HomeBloc>(
    () => HomeBloc(di<HomeRepoImpl>())
  );

}

/* 
  Integerating GetIt for dependency injection 
  A global container that stores and provides your objects. 
*/

/* 
  register singleton -> same object every request
  register factory -> new object every request
*/