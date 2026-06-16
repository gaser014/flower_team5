import 'package:flowers_app/features/login_Driver/data/models/driver_model.dart';
import 'package:flowers_app/features/login_Driver/domain/entities/driver_login_response_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'driver_login_response_model.g.dart';

@JsonSerializable()
class DriverLoginResponseModel {
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "token")
  String? token;
  @JsonKey(name: "driver")
  DriverModel? driver;

  DriverLoginResponseModel({this.message, this.token, this.driver});

  factory DriverLoginResponseModel.fromJson(Map<String, dynamic> json) =>
      _$DriverLoginResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$DriverLoginResponseModelToJson(this);

  DriverLoginResponseEntity toEntity() {
    return DriverLoginResponseEntity(
      message: message,
      token: token,
      driver: driver?.toEntity(),
    );
  }
}
