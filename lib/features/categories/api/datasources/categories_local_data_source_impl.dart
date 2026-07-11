import '../../data/datasources/categories_local_data_source_contract.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: CategoriesLocalDataSourceContract)
class CategoriesLocalDataSourceImpl
    implements CategoriesLocalDataSourceContract {
  // Implement local data source methods here
}
