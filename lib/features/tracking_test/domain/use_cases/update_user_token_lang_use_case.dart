import 'package:injectable/injectable.dart';

import '../repositories/tracking_repository.dart';

@Injectable()
class UpdateUserTokenLangUseCase {
  final TrackingRepository repository;

  UpdateUserTokenLangUseCase(this.repository);

  Future<void> call({
    required String userId,
    required String token,
    required String lang,
  }) {
    return repository.updateUserTokenLang(userId, token, lang);
  }
}
