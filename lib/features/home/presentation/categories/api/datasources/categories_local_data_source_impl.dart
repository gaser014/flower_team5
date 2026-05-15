import 'package:flowers_app/features/home/presentation/categories/data/datasources/categories_local_data_source_contract.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: CategoriesLocalDataSourceContract)
class CategoriesLocalDataSourceImpl
    implements CategoriesLocalDataSourceContract {
  // Implement local data source methods here
}
