import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/repositories/categories_repository.dart';
import 'categories_state.dart';

@injectable
class CategoriesCubit extends Cubit<CategoriesState> {
  final CategoriesRepository _repository;

  CategoriesCubit(this._repository) : super(CategoriesInitial());

  Future<void> loadInitialData() async {
    emit(CategoriesLoading());
    
    final categoriesResult = await _repository.getCategories();
    final productsResult = await _repository.getProducts(null);
    
    categoriesResult.when(
      error: (failure) => emit(CategoriesError(failure?.toString() ?? "Unknown error")),
      success: (categories) {
        productsResult.when(
          error: (failure) => emit(CategoriesError(failure?.toString() ?? "Unknown error")),
          success: (products) {
            emit(CategoriesLoaded(categories ?? [], products ?? [], selectedCategoryId: null));
          },
        );
      },
    );
  }

  Future<void> selectCategory(String? categoryId) async {
    if (state is CategoriesLoaded) {
      final currentState = state as CategoriesLoaded;
      
      emit(currentState.copyWith(
        isLoadingProducts: true,
        selectedCategoryId: categoryId,
        resetSelectedCategory: categoryId == null,
      ));
      
      final productsResult = await _repository.getProducts(categoryId);
      
      productsResult.when(
        error: (failure) => emit(CategoriesError(failure?.toString() ?? "Unknown error")),
        success: (products) {
          emit(currentState.copyWith(
            products: products ?? [],
            selectedCategoryId: categoryId,
            resetSelectedCategory: categoryId == null,
            isLoadingProducts: false,
          ));
        },
      );
    }
  }
}
