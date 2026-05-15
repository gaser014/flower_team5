part of 'categories_cubit.dart';

sealed class CategoriesEvents {
  const CategoriesEvents();
}

class GetAllCategoriesEvent extends CategoriesEvents {
  final CategoriesParams? params;
  const GetAllCategoriesEvent({this.params});
}

class SearchCategoriesEvent extends CategoriesEvents {
  final String query;
  const SearchCategoriesEvent({required this.query});
}

class UpdateSortByEvent extends CategoriesEvents {
  final String sortBy;
  const UpdateSortByEvent({required this.sortBy});
}

class LoadMoreCategoriesEvent extends CategoriesEvents {
  final CategoriesParams params;
  const LoadMoreCategoriesEvent({required this.params});
}

class SelectCategoryEvent extends CategoriesEvents {
  final AppFilterTabItemEntity category;
  const SelectCategoryEvent({required this.category});
}
