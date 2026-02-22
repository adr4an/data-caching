import 'package:data_caching/features/home/data/models/product_model.dart';

abstract class InterfaceRepository <T> {
  // fetch all data from db
  Future<Product?> fetchAll();

  // insert data to db
  Future<void> insertItem({required Product data});

  // is data exist in db
  Future<bool> isDataExist();

}