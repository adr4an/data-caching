import 'package:data_caching/core/helper/log_helper.dart';
import 'package:data_caching/features/home/data/models/product_model.dart';
import 'package:data_caching/features/home/data/services/local/home_db_service.dart';

class HomeDbProvider {
  final HomeDbService _homeDbService;

  // initilizer list, can chain multiple initializations
  HomeDbProvider({required HomeDbService homeDbService})
      : _homeDbService = homeDbService;

  // read data from database
  Future<Product?> fetchProducts() async {
    try {
      return await _homeDbService.fetchAll();
    }

    catch (e) {
      logger.e('Error fetching products from database: $e');
      return null;
    }
  }

  // insert data into database (cache)
  Future<void> insertProduct({required Product product}) async {
    try {
      await _homeDbService.insertItem(data: product);
    }

    catch (e) {
      logger.e('Error inserting product into database: $e');
    }
  }

  // is data available in database
  Future<bool> isDataAvailable() async {
    try {
      return await _homeDbService.isDataExist();
    }

    catch (e) {
      logger.e('Error checking data availability: $e');
      return false;
    }
  }

}