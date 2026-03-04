import 'package:data_caching/core/resources/data_state.dart';
import 'package:data_caching/features/home/data/models/product_model.dart';

abstract class HomeRepository {
  Future<DataState<List<Product>?>> fetchProducts();
}