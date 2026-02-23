import 'package:data_caching/core/dependency_injection/di.dart';
import 'package:data_caching/core/helper/connection_helper.dart';
import 'package:data_caching/core/helper/log_helper.dart';
import 'package:data_caching/core/resources/data_state.dart';
import 'package:data_caching/features/home/data/models/product_model.dart';
import 'package:data_caching/features/home/data/services/local/home_db_provider.dart';
import 'package:data_caching/features/home/data/services/remote/home_api_provider.dart';
import 'package:dio/dio.dart';

// Fetch products from the server and cache them in local db.
class HomeRepository {
  // remote data source 
  final HomeApiProvider _apiProvider;

  // local data source
  final HomeDbProvider _dbProvider;

  HomeRepository(this._apiProvider, this._dbProvider);

  // get products for home
  Future<DataState<List<Product>?>> fetchProducts() async {
    // check the connection status
    final bool isConnected = 
      await di<InternetConnectionHelper>().checkInternetConnection();

    // is database available or not
    final bool isDbAvailable =
      await _dbProvider.isDataAvailable();
    
    // connected to the internet
    if (isConnected) {
      // fetch data from the server
      try {
        final Response response = 
          await _apiProvider.getProductStatus();

        // success response from server
        if (response.statusCode == 200) {
          // response.data is expected to be a List of product maps
          final List<dynamic> raw = response.data as List<dynamic>;

          // convert response to list of Product models
          final List<Product> products = raw
              .map((e) => Product.fromJson(e as Map<String, dynamic>))
              .toList();

          // cache the data in local database
          await _dbProvider.insertProducts(products: products);

          // get the items from cache
          final List<Product>? cachedProducts = await _dbProvider.fetchProducts();

          // send to state management as success response
          return DataSuccess(cachedProducts);
        } 
        
        // failed response and return data from cache if available
        else if (response.statusCode != 200) {
          if (isDbAvailable) {
            final List<Product>? localSource = 
              await _dbProvider.fetchProducts();

            // only return success if localSource is non-null
            if (localSource != null) return DataSuccess(localSource);
          }
        }

      } 

      // error while fetching data from server
      catch (e) {
          if (isDbAvailable) {
            logger.d('Load [Products] from Local DataBase');
            // if there is cached data, return it
            final List<Product>? localSource = 
              await _dbProvider.fetchProducts();
            if (localSource != null) return DataSuccess(localSource);
          } 
          else {
            return const DataError("No haha connection");
          }
      }

    } 
    
    // use data from the database when offline
    else {
      if (isDbAvailable) {
        logger.e('Load fetching products from local db');
        // if there is cached data, return it
        final List<Product>? localSource = 
          await _dbProvider.fetchProducts();
        if (localSource != null) return DataSuccess(localSource);
      }
    }

    return const DataError("No hahaha connection");
    
  }

}