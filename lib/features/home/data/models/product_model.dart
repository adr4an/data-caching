import 'package:data_caching/hive_helper/fields/rating_fields.dart';
import 'package:hive/hive.dart';
import 'package:data_caching/hive_helper/hive_types.dart';
import 'package:data_caching/hive_helper/hive_adapters.dart';
import 'package:data_caching/hive_helper/fields/product_fields.dart';

part 'product_model.g.dart';

@HiveType(typeId: HiveTypes.product, adapterName: HiveAdapters.product)
class Product extends HiveObject{
	@HiveField(ProductFields.id)
  final int id;
	@HiveField(ProductFields.title)
  final String title;
	@HiveField(ProductFields.price)
  final double price;
	@HiveField(ProductFields.description)
  final String description;
	@HiveField(ProductFields.category)
  final String category;
	@HiveField(ProductFields.image)
  final String image;
	@HiveField(ProductFields.rating)
  final Rating rating;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  // fetch product from API (loca)
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      // Using .toDouble() ensures it doesn't crash if the JSON is an int
      price: (json['price'] as num).toDouble(),
      description: json['description'],
      category: json['category'],
      image: json['image'],
      rating: Rating.fromJson(json['rating']),
    );
  }

  // save product to database (useful for local storage)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'category': category,
      'image': image,
      'rating': rating.toJson(),
    };
  }
}


@HiveType(typeId: HiveTypes.rating, adapterName: HiveAdapters.rating)
class Rating extends HiveObject{
	@HiveField(RatingFields.rate)
  final double rate;
	@HiveField(RatingFields.count)
  final int count;

  Rating({required this.rate, required this.count});

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      rate: (json['rate'] as num).toDouble(),
      count: json['count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rate': rate,
      'count': count,
    };
  }
}