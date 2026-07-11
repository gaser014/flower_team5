import 'package:dio/dio.dart';
import 'package:flowers_app/config/env/app_env.dart';
import 'package:flowers_app/features/order_tracking/data/models/directions_result_model.dart';
import 'package:flowers_app/features/order_tracking/domain/entities/lat_lng_entity.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class DirectionsApiClient {
  static const String _baseUrl =
      'https://maps.googleapis.com/maps/api/directions/json';

  final Dio _dio;

  DirectionsApiClient() : _dio = Dio();

  Future<DirectionsResultModel> getRoute({
    required LatLngEntity origin,
    required LatLngEntity destination,
  }) async {
    final key = AppEnv.googleMapsKey;
    if (key.isEmpty) return const DirectionsResultModel(points: []);

    final response = await _dio.get(
      _baseUrl,
      queryParameters: {
        'origin': '${origin.lat},${origin.lng}',
        'destination': '${destination.lat},${destination.lng}',
        'mode': 'driving',
        'key': key,
      },
    );

    final data = response.data;
    if (data is Map<String, dynamic>) {
      return DirectionsResultModel.fromJson(data);
    }
    return const DirectionsResultModel(points: []);
  }
}
