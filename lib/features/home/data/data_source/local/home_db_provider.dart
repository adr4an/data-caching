import 'package:data_caching/features/home/data/models/product_model.dart';
import 'package:data_caching/features/home/data/data_source/local/home_db_service.dart';

class HomeDbProvider {
  final HomeDbService _homeDbService;

  // initializer list, can chain multiple initializations
  HomeDbProvider({required HomeDbService homeDbService})
      : _homeDbService = homeDbService;

  // read data from database
  Future<List<Product>?> fetchProducts() async {
    return await _homeDbService.fetchAll();  
  }

  // insert list of products into database (cache)
  Future<void> insertProducts({required List<Product> products}) async {
    await _homeDbService.insertItem(data: products);
  }

  // is data available in database
  Future<bool> isDataAvailable() async {
    return await _homeDbService.isDataExist();
  }

}