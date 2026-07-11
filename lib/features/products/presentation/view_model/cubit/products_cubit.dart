import 'package:equatable/equatable.dart';
import 'package:flowers_app/config/base_state/pagination_state.dart';
import 'package:flowers_app/features/app_filter_tabs/domain/entities/app_filter_tab_item_entity.dart';
import 'package:flowers_app/features/products/domain/entities/product_entity.dart';
import 'package:flowers_app/features/products/domain/entities/products_params.dart';
import 'package:flowers_app/features/products/domain/use_cases/get_all_products.dart';

import 'package:flowers_app/config/uses_cases/filter_param.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'products_events.dart';
part 'products_states.dart';

@injectable
class ProductsCubit extends Cubit<ProductsStates> {
  final GetAllProductsUseCase _getAllProductsUseCase;

  ProductsCubit({required GetAllProductsUseCase getAllProductsUseCase})
    : _getAllProductsUseCase = getAllProductsUseCase,
      super(const ProductsStates());

  @override
  void emit(ProductsStates state) {
    if (!isClosed) super.emit(state);
  }

  Future<void> doIntent(ProductsEvents event) async => switch (event) {
    GetAllProductsEvent() => _getAllProducts(event),
    LoadMoreProductsEvent() => _loadMore(event),
    SearchProductsEvent() => _searchProducts(event),
    UpdateSortByEvent() => _updateSortBy(event),
  };

  Future<void> _searchProducts(SearchProductsEvent event) async {
    final currentParams = state.productsState.query as ProductsParams;
    final newFilterList = List<FilterParam>.from(currentParams.filterList);
    
    newFilterList.removeWhere((f) => f.key == 'keyword');
    if (event.query.isNotEmpty) {
      newFilterList.add(FilterParam(key: 'keyword', value: event.query));
    }

    await _getAllProducts(GetAllProductsEvent(
      params: currentParams.copyWith(
        page: 1,
        filterList: newFilterList,
      ),
    ));
  }

  Future<void> _updateSortBy(UpdateSortByEvent event) async {
    final currentParams = state.productsState.query as ProductsParams;
    final newFilterList = List<FilterParam>.from(currentParams.filterList);
    
    newFilterList.removeWhere((f) => f.key == 'sort');
    if (event.sortBy.isNotEmpty) {
      newFilterList.add(FilterParam(key: 'sort', value: event.sortBy));
    }

    await _getAllProducts(GetAllProductsEvent(
      params: currentParams.copyWith(
        page: 1,
        filterList: newFilterList,
      ),
    ));
  }

  Future<void> _getAllProducts(GetAllProductsEvent event) async {
    if (state.productsState.isLoading) return;

    final params = event.params ?? ProductsParams(page: 1);
    emit(
      state.copyWith(
        productsState: state.productsState.toLoading(query: params),
      ),
    );

    final result = await _getAllProductsUseCase.call(params);

    result.when(
      success: (data) {
        if (data != null) {
          emit(
            state.copyWith(
              productsState: state.productsState.toSuccessFromEntity(data),
            ),
          );
        } else {
          emit(
            state.copyWith(
              productsState: state.productsState.toError(
                Exception('No data received'),
              ),
            ),
          );
        }
      },
      error: (exception) {
        emit(
          state.copyWith(
            productsState: state.productsState.toError(
              exception ?? Exception('Unknown error'),
            ),
          ),
        );
      },
    );
  }

  Future<void> _loadMore(LoadMoreProductsEvent event) async {
    if (!state.productsState.canLoadMore) return;

    emit(state.copyWith(productsState: state.productsState.toLoadingMore()));

    final result = await _getAllProductsUseCase.call(event.params);

    result.when(
      success: (data) {
        if (data != null) {
          emit(
            state.copyWith(
              productsState: state.productsState.toSuccessFromEntity(data),
            ),
          );
        } else {
          emit(
            state.copyWith(
              productsState: state.productsState.toErrorMore(
                Exception('No data received'),
              ),
            ),
          );
        }
      },
      error: (exception) {
        emit(
          state.copyWith(
            productsState: state.productsState.toErrorMore(
              exception ?? Exception('Unknown error'),
            ),
          ),
        );
      },
    );
  }

  Future<void> refreshProducts() async {
    if (state.productsState.isLoading || state.productsState.isLoadingMore)
      return;

    final currentQuery = state.productsState.query;
    final params = currentQuery is ProductsParams
        ? currentQuery.copyWith(page: 1)
        : ProductsParams(page: 1);

    await doIntent(GetAllProductsEvent(params: params));
  }

  void clearError() {
    if (state.productsState.isError) {
      emit(state.copyWith(productsState: const PaginationState.initial()));
    } else if (state.productsState.isErrorMore) {
      emit(
        state.copyWith(
          productsState: PaginationState(
            state: state.productsState.state,
            data: state.productsState.data,
            meta: state.productsState.meta,
            query: state.productsState.query,
          ),
        ),
      );
    }
  }

  void reset() {
    emit(const ProductsStates());
  }
}
