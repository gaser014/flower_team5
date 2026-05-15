import 'package:flowers_app/config/base_state/base_state.dart';
import 'package:flowers_app/features/products/domain/entities/product_entity.dart';
import 'package:flowers_app/features/product_details/domain/use_cases/get_product_details_use_case.dart';
import 'package:flowers_app/features/product_details/presentation/view_model/cubit/product_details_events.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'product_details_states.dart';

@injectable
class ProductDetailsCubit extends Cubit<BaseState<ProductEntity>> {
  final GetProductDetailsUseCase _getProductDetailsUseCase;

  ProductDetailsCubit(this._getProductDetailsUseCase)
      : super(const BaseState.initial());

  void onEvent(ProductDetailsEvents event) {
    switch (event) {
      case GetProductDetailsEvent():
        _fetchProduct(event.id);
      case SetProductDetailsEvent():
        _setProduct(event.product);
    }
  }

  Future<void> _fetchProduct(String id) async {
    emit(const BaseState.loading());
    final result = await _getProductDetailsUseCase.execute(id);
    result.when(
      success: (data) {
        if (data != null) {
          emit(BaseState.success(data));
        } else {
          emit(BaseState.error(Exception('No product data received')));
        }
      },
      error: (exception) =>
          emit(BaseState.error(exception ?? Exception('Unknown error'))),
    );
  }

  void _setProduct(ProductEntity product) {
    emit(BaseState.success(product));
  }
}
