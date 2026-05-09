part of 'categories_cubit.dart';

sealed class CategoriesEvents {
  const CategoriesEvents();
}

class GetAllCategoriesEvent extends CategoriesEvents {
  final CategoriesParams? params;
  const GetAllCategoriesEvent({this.params});
}

class LoadMoreCategoriesEvent extends CategoriesEvents {
  final CategoriesParams params;
  const LoadMoreCategoriesEvent({required this.params});
}

