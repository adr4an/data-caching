import 'package:hive/hive.dart';
import 'package:data_caching/features/home/data/models/product_model.dart';

void registerAdapters() {
	Hive.registerAdapter(ProductAdapter());
	Hive.registerAdapter(RatingAdapter());
}
