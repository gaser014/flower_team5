import 'package:flowers_app/features/login_Driver/domain/entities/driver_entity.dart';

class DriverLoginResponseEntity {
  final String? message;
  final String? token;
  final DriverEntity? driver;

  DriverLoginResponseEntity({this.message, this.token, this.driver});
}
