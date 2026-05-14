import 'package:equatable/equatable.dart';
import 'package:flowers_app/features/home/domain/entities/home_category_entity.dart';
import 'package:flowers_app/features/home/domain/entities/home_occasion_entity.dart';
import 'package:flowers_app/features/products/domain/entities/product_entity.dart';

class HomeEntity extends Equatable {
  final List<ProductEntity>? products;
  final List<HomeCategoryEntity>? categories;
  final List<ProductEntity>? bestSeller;
  final List<HomeOccasionEntity>? occasions;

  const HomeEntity({
    this.products,
    this.categories,
    this.bestSeller,
    this.occasions,
  });

  @override
  List<Object?> get props => [
        products,
        categories,
        bestSeller,
        occasions,
      ];
}
