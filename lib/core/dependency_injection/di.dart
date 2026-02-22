import 'package:data_caching/core/helper/connection_helper.dart';
import 'package:data_caching/features/home/data/services/local/home_db_provider.dart';
import 'package:data_caching/features/home/data/services/local/home_db_service.dart';
import 'package:data_caching/features/home/data/services/remote/home_api_provider.dart';
import 'package:data_caching/features/home/logic/home_repository.dart';
import 'package:data_caching/features/home/view/bloc/home_blocs/home_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

// Integerating GetIt for dependency injection
GetIt di = GetIt.instance;

Future<void> setUpDi() async {
  // Network services
  di.registerSingleton<Dio>(Dio());

  // Helper
  di.registerSingleton(InternetConnectionHelper());

  // Hive database
  await Hive.initFlutter();

  // Home db service
  di.registerSingleton(
    HomeDbService(),
  );

  // Initialize the db for storing products
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
    HomeRepository(
      di<HomeApiProvider>(),
      di<HomeDbProvider>(),
      ),
  );
  
  // Blocs & Home Blocs
  di.registerFactory<HomeBloc>(() => HomeBloc(di<HomeRepository>()));

}