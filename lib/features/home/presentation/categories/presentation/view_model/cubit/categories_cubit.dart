import 'package:equatable/equatable.dart';
import 'package:flowers_app/config/base_state/pagination_state.dart';
import 'package:flowers_app/features/home/presentation/categories/domain/entities/categories_params.dart';
import 'package:flowers_app/features/home/presentation/categories/domain/entities/category_entity.dart';
import 'package:flowers_app/features/home/presentation/categories/domain/use_cases/get_all_categories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';


part 'categories_events.dart';
part 'categories_states.dart';

@injectable
class CategoriesCubit extends Cubit<CategoriesStates> {
  final GetAllCategoriesUseCase _getAllCategoriesUseCase;

  CategoriesCubit({required GetAllCategoriesUseCase getAllCategoriesUseCase})
    : _getAllCategoriesUseCase = getAllCategoriesUseCase,
      super(const CategoriesStates());

  @override
  void emit(CategoriesStates state) {
    if (!isClosed) super.emit(state);
  }

  Future<void> doIntent(CategoriesEvents event) async => switch (event) {
    GetAllCategoriesEvent() => _getAllCategories(event),
    LoadMoreCategoriesEvent() => _loadMore(event),
    SelectCategoryEvent() => _selectCategory(event),
  };

  Future<void> _getAllCategories(GetAllCategoriesEvent event) async {
    if (state.categoriesState.isLoading) return;

    final params = event.params ?? CategoriesParams(page: 1);
    emit(
      state.copyWith(
        categoriesState: state.categoriesState.toLoading(query: params),
      ),
    );

    final result = await _getAllCategoriesUseCase.call(params);

    result.when(
      success: (data) {
        if (data != null) {
          emit(
            state.copyWith(
              categoriesState: state.categoriesState.toSuccessFromEntity(data),
              selectCategoryState: state.selectCategoryState ?? const CategoryEntity(id: null, name: 'All'),
            ),
          );
        } else {
          emit(
            state.copyWith(
              categoriesState: state.categoriesState.toError(
                Exception('No data received'),
              ),
            ),
          );
        }
      },
      error: (exception) {
        emit(
          state.copyWith(
            categoriesState: state.categoriesState.toError(
              exception ?? Exception('Unknown error'),
            ),
          ),
        );
      },
    );
  }

  Future<void> _loadMore(LoadMoreCategoriesEvent event) async {
    if (!state.categoriesState.canLoadMore) return;

    emit(
      state.copyWith(categoriesState: state.categoriesState.toLoadingMore()),
    );

    final result = await _getAllCategoriesUseCase.call(event.params);

    result.when(
      success: (data) {
        if (data != null) {
          emit(
            state.copyWith(
              categoriesState: state.categoriesState.toSuccessFromEntity(data),
            ),
          );
        } else {
          emit(
            state.copyWith(
              categoriesState: state.categoriesState.toErrorMore(
                Exception('No data received'),
              ),
            ),
          );
        }
      },
      error: (exception) {
        emit(
          state.copyWith(
            categoriesState: state.categoriesState.toErrorMore(
              exception ?? Exception('Unknown error'),
            ),
          ),
        );
      },
    );
  }

  Future<void> refreshCategories() async {
    if (state.categoriesState.isLoading ||
        state.categoriesState.isLoadingMore) {
      return;
    }

    final currentQuery = state.categoriesState.query;
    final params = currentQuery is CategoriesParams
        ? currentQuery.copyWith(page: 1)
        : CategoriesParams(page: 1);

    await doIntent(GetAllCategoriesEvent(params: params));
  }

  void clearError() {
    if (state.categoriesState.isError) {
      emit(state.copyWith(categoriesState: const PaginationState.initial()));
    } else if (state.categoriesState.isErrorMore) {
      emit(
        state.copyWith(
          categoriesState: PaginationState(
            state: state.categoriesState.state,
            data: state.categoriesState.data,
            meta: state.categoriesState.meta,
            query: state.categoriesState.query,
          ),
        ),
      );
    }
  }

  void _selectCategory(SelectCategoryEvent event) {
    emit(state.copyWith(selectCategoryState: event.category));
  }

  void reset() {
    emit(const CategoriesStates());
  }
}
