class EnvironmentVariables {
  EnvironmentVariables._();

  // base url Endpoint
  static String get baseUrl => 'https://fakestoreapi.com';
  // get Products
  static String get getProducts => '$baseUrl/products?limit=5';
}
