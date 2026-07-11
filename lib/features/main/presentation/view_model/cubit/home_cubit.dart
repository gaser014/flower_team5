import 'package:equatable/equatable.dart';
import 'package:flowers_app/config/base_state/base_state.dart';
import 'package:flowers_app/config/dependency_injection/di.dart';
import 'package:flowers_app/config/dependency_injection/home_module.dart';
import 'package:flowers_app/config/uses_cases/use_cases.dart';
import 'package:flowers_app/features/app_filter_tabs/domain/entities/app_filter_tab_item_entity.dart';
import 'package:flowers_app/features/home/domain/use_cases/get_home_use_case.dart';
import 'package:flowers_app/features/main/presentation/view_model/cubit/home_events.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'home_state.dart';

@LazySingleton()
class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._getHomeUseCase) : super(const HomeState());
  final GetHomeUseCase _getHomeUseCase;

  void doIndented(HomeEvents event) {
    switch (event) {
      case ChangeBottomNavIndexEvent(index: final index):
        _changeBottomNavIndex(index);

      case GetAllHomeDataEvent():
        _getHomeData();
    }
  }

  void _changeBottomNavIndex(int index, {AppFilterTabItemEntity? category}) {
    emit(
      state.copyWith(
        bottomNavIndex: index,
        clearSelectedCategory: category != null,
        selectedCategory: category,
      ),
    );
  }

  Future<void> _getHomeData() async {
    emit(state.copyWith(getAllHomeDataState: const BaseState.loading()));
    final result = await _getHomeUseCase.call(NoParams());
    result.when(
      success: (homeModel) {
        if (getIt.isRegistered<HomeModule>()) {
          getIt.unregister<HomeModule>();
        }

        getIt.registerSingleton<HomeModule>(HomeModule()..homeData = homeModel);
        emit(state.copyWith(getAllHomeDataState: BaseState.success(homeModel)));
      },
      error: (exception) {
        emit(state.copyWith(getAllHomeDataState: BaseState.error(exception)));
      },
    );
  }
}
