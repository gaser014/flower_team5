import 'package:flowers_app/config/base_state/pagination_state.dart';
import 'package:flowers_app/config/uses_cases/pagination_params.dart';
import 'package:flowers_app/features/products/domain/entities/product_entity.dart';
import 'package:flowers_app/features/best_seller/domain/use_cases/get_best_sellers_use_case.dart';
import 'package:flowers_app/features/best_seller/presentation/view_model/cubit/best_seller_events.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class BestSellerCubit extends Cubit<PaginationState<ProductEntity>> {
  final GetBestSellersUseCase _getBestSellersUseCase;

  BestSellerCubit(this._getBestSellersUseCase)
    : super(const PaginationState.initial());

  void onEvent(BestSellerEvents event) {
    switch (event) {
      case GetBestSellersEvent():
        getBestSellers(isRefresh: event.isRefresh);
    }
  }

  Future<void> getBestSellers({bool isRefresh = false}) async {
    if (isRefresh) {
      emit(state.toLoading(query: const PaginationParams()));
    } else if (state.isInitial) {
      emit(state.toLoading(query: const PaginationParams()));
    } else if (state.canLoadMore) {
      emit(state.toLoadingMore());
    } else {
      return;
    }

    final result = await _getBestSellersUseCase.execute(state.query);

    result.when(
      success: (data) {
        if (data != null) {
          emit(state.toSuccessFromEntity(data));
        } else {
          emit(state.toError(Exception('No data received')));
        }
      },
      error: (exception) => state.isLoadingMore
          ? emit(state.toErrorMore(exception ?? Exception('Unknown error')))
          : emit(state.toError(exception ?? Exception('Unknown error'))),
    );
  }
}
