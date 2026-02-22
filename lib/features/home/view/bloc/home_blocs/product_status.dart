import 'package:data_caching/features/home/data/models/product_model.dart';
import 'package:flutter/material.dart';

@immutable
abstract class HomeProductStatus {}

class HomeProductStatusInit extends HomeProductStatus {}

class HomeProductStatusLoading extends HomeProductStatus {}

class HomeProductStatusCompleted extends HomeProductStatus {
  final Product product;

  HomeProductStatusCompleted(this.product);
}

class HomeProductStatusError extends HomeProductStatus {
  final String message;

  HomeProductStatusError(this.message);
}