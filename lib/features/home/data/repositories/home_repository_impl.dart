import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/features/home/data/datasources/home_remote_data_source_contract.dart';
import 'package:flowers_app/features/home/domain/entities/home_entity.dart';
import 'package:flowers_app/features/home/domain/repositories/home_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSourceContract _remoteDataSource;

  HomeRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<HomeEntity>> getHomeData() async {
    final result = await _remoteDataSource.getHomeData();

    return result.when(
      success: (data) {
        return Success<HomeEntity>(data: data?.toEntity());
      },
      error: (error) {
        return Error(exception: error);
      },
    );
  }
}
