import 'package:flowers_app/features/products/data/datasources/products_local_data_source_contract.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ProductsLocalDataSourceContract)
class ProductsLocalDataSourceImpl implements ProductsLocalDataSourceContract {
  // Implement local data source methods here
}
