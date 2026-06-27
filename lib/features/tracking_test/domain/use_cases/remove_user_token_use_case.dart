import 'package:injectable/injectable.dart';

import '../repositories/tracking_repository.dart';

@Injectable()
class RemoveUserTokenUseCase {
  final TrackingRepository repository;

  RemoveUserTokenUseCase(this.repository);

  Future<void> call({required String userId, required String token}) {
    return repository.removeUserToken(userId, token);
  }
}
