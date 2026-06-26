import 'package:injectable/injectable.dart';

import '../entities/user_entity.dart';
import '../repositories/tracking_repository.dart';

@Injectable()
class AddUserUseCase {
  final TrackingRepository repository;

  AddUserUseCase(this.repository);

  Future<void> call(UserEntity user) {
    return repository.addUser(user);
  }
}
