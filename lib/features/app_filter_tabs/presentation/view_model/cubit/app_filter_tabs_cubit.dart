import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flowers_app/config/base_state/pagination_state.dart';
import 'package:flowers_app/config/dependency_injection/di.dart';
import 'package:flowers_app/config/dependency_injection/home_module.dart';
import 'package:flowers_app/features/app_filter_tabs/domain/entities/app_filter_tab_item_entity.dart';
import 'package:flowers_app/features/app_filter_tabs/domain/entities/app_filter_tabs_params.dart';
import 'package:flowers_app/features/app_filter_tabs/domain/use_cases/get_all_app_filter_tabs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'app_filter_tabs_events.dart';
part 'app_filter_tabs_states.dart';

@injectable
class AppFilterTabsCubit extends Cubit<AppFilterTabsStates> {
  final GetAllAppFilterTabsUseCase _getAllAppFilterTabsUseCase;

  AppFilterTabsCubit({
    required GetAllAppFilterTabsUseCase getAllAppFilterTabsUseCase,
  }) : _getAllAppFilterTabsUseCase = getAllAppFilterTabsUseCase,
       super(const AppFilterTabsStates());

  @override
  void emit(AppFilterTabsStates state) {
    if (!isClosed) super.emit(state);
  }

  Future<void> doIntent(AppFilterTabsEvents event) async => switch (event) {
    GetAllAppFilterTabsEvent() => _getAllCategories(event),
    LoadMoreAppFilterTabsEvent() => _loadMore(event),
    SelectAppFilterTabEvent() => _selectCategory(event),
  };

  Future<void> _getAllCategories(GetAllAppFilterTabsEvent event) async {
    if (event.selectedTabFilter == null) {
      final params = event.params ?? AppFilterTabsParams(page: 1);
      emit(
        state.copyWith(
          categoriesState: state.categoriesState.toLoading(query: params),
        ),
      );

      final result = await _getAllAppFilterTabsUseCase.call(params);

      result.when(
        success: (data) {
          if (data != null) {
            emit(
              state.copyWith(
                categoriesState: state.categoriesState.toSuccessFromEntity(
                  data,
                ),
                selectCategoryState:
                    state.selectCategoryState ?? data.data.first,
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
    } else {
      // emit(state.copyWith(categoriesState: state.categoriesState.toLoading()));
      final data = getIt<HomeModule>().homeData?.occasions;
      if (data != null) {
        log(
          'AppFilterTabsCubit: using cached data for occasions: ${event.selectedTabFilter} items',
        );
        emit(
          state.copyWith(
            categoriesState: state.categoriesState.toSuccess(data),
            selectCategoryState: event.selectedTabFilter,
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
    }
  }

  Future<void> _loadMore(LoadMoreAppFilterTabsEvent event) async {
    if (!state.categoriesState.canLoadMore) return;

    emit(
      state.copyWith(categoriesState: state.categoriesState.toLoadingMore()),
    );

    final result = await _getAllAppFilterTabsUseCase.call(event.params);

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
    final params = currentQuery is AppFilterTabsParams
        ? currentQuery.copyWith(page: 1)
        : AppFilterTabsParams(page: 1);

    await doIntent(GetAllAppFilterTabsEvent(params: params));
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

  void _selectCategory(SelectAppFilterTabEvent event) {
    emit(state.copyWith(selectCategoryState: event.category));
  }

  void reset() {
    emit(const AppFilterTabsStates());
  }
}
