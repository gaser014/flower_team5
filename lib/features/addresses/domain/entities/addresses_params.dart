import 'package:flowers_app/config/uses_cases/params.dart';

class AddressParams extends Params {
  final String id;

  const AddressParams({required this.id});

  @override
  List<Object?> get props => [id];
}
