import 'package:flowers_app/config/base_response/entity/base_pagination_entity.dart';
import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/config/uses_cases/use_cases.dart';
import 'package:flowers_app/features/app_filter_tabs/domain/entities/app_filter_tab_item_entity.dart';
import 'package:flowers_app/features/app_filter_tabs/domain/entities/app_filter_tabs_params.dart';
import 'package:flowers_app/features/app_filter_tabs/domain/repositories/app_filter_tabs_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetAllAppFilterTabsUseCase
    extends
        UseCase<
          BasePaginationEntity<AppFilterTabItemEntity>,
          AppFilterTabsParams
        > {
  final AppFilterTabsRepository repository;

  GetAllAppFilterTabsUseCase(this.repository);

  @override
  Future<Result<BasePaginationEntity<AppFilterTabItemEntity>>> call(
    AppFilterTabsParams parm,
  ) {
    return repository.getAllCategories(params: parm);
  }
}
