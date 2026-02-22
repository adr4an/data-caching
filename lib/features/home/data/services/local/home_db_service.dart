import 'package:data_caching/config/constants/db_keys.dart';
import 'package:data_caching/core/helper/log_helper.dart';
import 'package:data_caching/core/repos/interface_repos.dart';
import 'package:data_caching/features/home/data/models/product_model.dart';
import 'package:hive/hive.dart';

class HomeDbService implements InterfaceRepository {
  // Box key
  static const String _boxKey = DbKeys.dbProducts;

  // Product box
  late final Box<Product> _productBox;

  // init database
  Future<void> init() async {
    try {
      Hive.registerAdapter(ProductAdapter());
      Hive.registerAdapter(RatingAdapter());
      _productBox = await Hive.openBox(_boxKey);
      
      // Open the box 
      logger.d('Product box opened successfully');
    }

    catch (e) {
      logger.e('Error opening product box: $e');
    }
  }

  @override
  Future<void> insertItem({required Product data}) async {
    try {
      await _productBox.put(_boxKey, data);
      logger.d('Product inserted successfully');
    }

    catch (e) {
      logger.e('Error inserting product: $e');
    }
  }

  @override
  Future<Product?> fetchAll() {
    try {
      // Check if the box is open and has data 
      if (_productBox.isOpen && _productBox.isNotEmpty) {
        return Future.value(_productBox.get(_boxKey));
      } 
      
      // If the box is not open or empty, return null
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
    try {
      // can be true or false
     return Future.value(_productBox.isNotEmpty);
    }

    catch (e) {
      logger.e('Error checking if box is empty: $e');
      return Future.value(true);
    }
  }
  
}