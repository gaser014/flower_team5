import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/config/uses_cases/use_cases.dart';
import 'package:flowers_app/features/track/domain/entities/track_order_entity.dart';
import 'package:flowers_app/features/track/domain/repositories/track_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetOrderUseCase extends UseCase<TrackOrderEntity, String> {
  final TrackRepository _repository;

  GetOrderUseCase(this._repository);

  @override
  Future<Result<TrackOrderEntity>> call(String orderId) =>
      _repository.getOrder(orderId: orderId);
}
