import 'package:flowers_app/features/app_filter_tabs/domain/entities/app_filter_tab_item_entity.dart';

sealed class HomeEvents {}

class ChangeBottomNavIndexEvent extends HomeEvents {
  final int index;
  final AppFilterTabItemEntity? category;
  ChangeBottomNavIndexEvent(this.index, {this.category});
}

class GetAllHomeDataEvent extends HomeEvents {}
