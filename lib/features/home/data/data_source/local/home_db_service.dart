import 'package:data_caching/core/constants/db_keys.dart';
import 'package:data_caching/core/helper/log_helper.dart';
import 'package:data_caching/core/repos/interface_repos.dart';
import 'package:data_caching/features/home/data/models/product_model.dart';
import 'package:hive/hive.dart';

class HomeDbService implements InterfaceRepository<List<Product>> {
  // Box key
  static const String _boxKey = DbKeys.dbProducts;

  // Product box (store a List<Product>)
  late final Box _productBox;

  // register adapters and open the box for products
  Future<void> init() async {
    try {
      Hive.registerAdapter(ProductAdapter());
      Hive.registerAdapter(RatingAdapter());

      _productBox = await Hive.openBox(_boxKey);
    } 

    catch (e) {
      logger.e('Error registering Hive adapters: $e');
    }
  }

  @override
  Future<void> insertItem({required List<Product> data}) async {
    try {
      await _productBox.put(_boxKey, data);
      logger.d('Products inserted successfully');
    }

    catch (e) {
      logger.e('Error inserting products: $e');
    }
  }

  @override
  Future<List<Product>?> fetchAll() {
    try {
      // check if the box is loaded in memory and has data
      if (_productBox.isOpen && _productBox.isNotEmpty) {
        final dynamic data = _productBox.get(_boxKey);
        return Future.value(data as List<Product>?);
      } 
      
      else {
        return Future.value(null); 
      }
    }

    catch (e) {
      logger.e('Error fetching products: $e');
      return Future.value(null);
    }
  }

  @override
  Future<bool> isDataExist() {
    // return true if data exists, otherwise false
    try {
     return Future.value(_productBox.isNotEmpty);
    }

    catch (e) {
      logger.e('Box is not opened or accessible: $e');
      return Future.value(false);
    }
  }
  
}