import 'package:equatable/equatable.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/entities/product_entity.dart';

abstract class CategoriesState extends Equatable {
  const CategoriesState();

  @override
  List<Object?> get props => [];
}

class CategoriesInitial extends CategoriesState {}

class CategoriesLoading extends CategoriesState {}

class CategoriesLoaded extends CategoriesState {
  final List<CategoryEntity> categories;
  final List<ProductEntity> products;
  final String? selectedCategoryId;
  final bool isLoadingProducts;

  const CategoriesLoaded(
    this.categories,
    this.products, {
    this.selectedCategoryId,
    this.isLoadingProducts = false,
  });

  CategoriesLoaded copyWith({
    List<CategoryEntity>? categories,
    List<ProductEntity>? products,
    String? selectedCategoryId,
    bool? isLoadingProducts,
    bool resetSelectedCategory = false,
  }) {
    return CategoriesLoaded(
      categories ?? this.categories,
      products ?? this.products,
      selectedCategoryId: resetSelectedCategory ? null : (selectedCategoryId ?? this.selectedCategoryId),
      isLoadingProducts: isLoadingProducts ?? this.isLoadingProducts,
    );
  }

  @override
  List<Object?> get props => [categories, products, selectedCategoryId, isLoadingProducts];
}

class CategoriesError extends CategoriesState {
  final String message;

  const CategoriesError(this.message);

  @override
  List<Object?> get props => [message];
}
