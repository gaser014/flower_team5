import 'package:equatable/equatable.dart';
import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/config/uses_cases/use_cases.dart';
import 'package:flowers_app/features/order_tracking/domain/entities/lat_lng_entity.dart';
import 'package:flowers_app/features/order_tracking/domain/entities/order_route_entity.dart';
import 'package:flowers_app/features/order_tracking/domain/repositories/order_tracking_repository.dart';
import 'package:injectable/injectable.dart';

class GetOrderRouteParams extends Equatable {
  final LatLngEntity store;
  final LatLngEntity user;

  const GetOrderRouteParams({required this.store, required this.user});

  @override
  List<Object?> get props => [store, user];
}

@injectable
class GetOrderRouteUseCase
    extends UseCase<OrderRouteEntity, GetOrderRouteParams> {
  final OrderTrackingRepository _repository;

  GetOrderRouteUseCase(this._repository);

  @override
  Future<Result<OrderRouteEntity>> call(GetOrderRouteParams params) =>
      _repository.getRoute(store: params.store, user: params.user);
}
