import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flowers_app/config/api/end_points.dart';
import 'package:flowers_app/config/dependency_injection/di.dart';
import 'payment_states.dart';
import 'package:injectable/injectable.dart';

@injectable
class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(PaymentInitial());

  Future<void> checkoutCredit() async {
    emit(PaymentLoading());
    try {
      final dio = getIt<Dio>();
      final response = await dio.post(EndPoints.creditCheckOut);
      
      final url = response.data['url'] ?? response.data['session']?['url'] ?? '';
      
      if (url.toString().isNotEmpty) {
        emit(PaymentCheckoutSuccess(url.toString()));
      } else {
        emit(PaymentError("Failed to retrieve payment URL"));
      }
    } catch (e) {
      emit(PaymentError("Something went wrong"));
    }
  }

  Future<void> checkoutCash() async {
    emit(PaymentLoading());
    // Simulate cash checkout or call an API for cash checkout if there is one
    await Future.delayed(const Duration(milliseconds: 500));
    emit(PaymentCashSuccess());
  }
}
