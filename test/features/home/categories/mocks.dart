import 'package:flowers_app/features/home/presentation/categories/domain/use_cases/get_all_categories.dart';
import 'package:flowers_app/features/home/presentation/categories/domain/repositories/categories_repository.dart';
import 'package:mockito/annotations.dart';

@GenerateNiceMocks([
  MockSpec<GetAllCategoriesUseCase>(),
  MockSpec<CategoriesRepository>(),
])
void main() {}
