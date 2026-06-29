part of 'app_filter_tabs_cubit.dart';

sealed class AppFilterTabsEvents {
  const AppFilterTabsEvents();
}

class GetAllAppFilterTabsEvent extends AppFilterTabsEvents {
  final AppFilterTabsParams? params;
  final AppFilterTabItemEntity? selectedTabFilter;
  const GetAllAppFilterTabsEvent({this.params, this.selectedTabFilter});
}

class LoadMoreAppFilterTabsEvent extends AppFilterTabsEvents {
  final AppFilterTabsParams params;
  const LoadMoreAppFilterTabsEvent({required this.params});
}

class SelectAppFilterTabEvent extends AppFilterTabsEvents {
  final AppFilterTabItemEntity category;
  const SelectAppFilterTabEvent({required this.category});
}
