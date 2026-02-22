import 'package:data_caching/config/constants/api_constants.dart';
import 'package:data_caching/core/helper/log_helper.dart';
import 'package:dio/dio.dart';

/* responsible for fetching data from the API
returns the status code */
class HomeApiProvider {
  // Dio instance for making HTTP requests
  final Dio dio;
  
  HomeApiProvider(this.dio);

  Future<dynamic> getProductStatus() async {
    try {
      // request URL for fetching products
      final requestUrl = EnvironmentVariables.getProducts;
      final response = await dio.get(requestUrl);

      return response;
    } 
    on DioException catch (e, st) {
      logger.e('DioException occurred: ${e.message}\n$st');
      rethrow;
    } catch (e, st) {
      logger.e('Unexpected error: $e\n$st');
      throw Exception('Failed to load home data');
    }
  }
}