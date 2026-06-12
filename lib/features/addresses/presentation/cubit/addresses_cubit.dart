import 'package:equatable/equatable.dart';
import 'package:flowers_app/config/base_state/base_state.dart';
import 'package:flowers_app/config/uses_cases/use_cases.dart';
import 'package:flowers_app/features/addresses/domain/entities/address_entity.dart';
import 'package:flowers_app/features/addresses/domain/use_cases/get_addresses.dart';
import 'package:flowers_app/features/addresses/domain/use_cases/add_address.dart';
import 'package:flowers_app/features/addresses/domain/use_cases/update_address.dart';
import 'package:flowers_app/features/addresses/domain/use_cases/delete_address.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'addresses_events.dart';
part 'addresses_states.dart';

@injectable
class AddressesCubit extends Cubit<AddressesStates> {
  final GetAddressesUseCase _getAddressesUseCase;
  final AddAddressUseCase _addAddressUseCase;
  final UpdateAddressUseCase _updateAddressUseCase;
  final DeleteAddressUseCase _deleteAddressUseCase;

  AddressesCubit({
    required GetAddressesUseCase getAddressesUseCase,
    required AddAddressUseCase addAddressUseCase,
    required UpdateAddressUseCase updateAddressUseCase,
    required DeleteAddressUseCase deleteAddressUseCase,
  }) : _getAddressesUseCase = getAddressesUseCase,
       _addAddressUseCase = addAddressUseCase,
       _updateAddressUseCase = updateAddressUseCase,
       _deleteAddressUseCase = deleteAddressUseCase,
       super(const AddressesStates());

  @override
  void emit(AddressesStates state) {
    if (!isClosed) super.emit(state);
  }

  Future<void> doIntent(AddressesEvents event) async => switch (event) {
    GetAddressesEvent() => _getAddresses(event),
    AddAddressEvent() => _addAddress(event),
    UpdateAddressEvent() => _updateAddress(event),
    DeleteAddressEvent() => _deleteAddress(event),
  };

  Future<void> _getAddresses(GetAddressesEvent event) async {
    if (state.getAddressesState.isLoading) return;

    emit(state.copyWith(getAddressesState: const BaseState.loading()));

    final result = await _getAddressesUseCase(NoParams());

    result.when(
      success: (data) {
        if (data != null) {
          emit(state.copyWith(getAddressesState: BaseState.success(data)));
        } else {
          emit(
            state.copyWith(
              getAddressesState: BaseState.error(Exception('No data received')),
            ),
          );
        }
      },
      error: (exception) {
        emit(
          state.copyWith(
            getAddressesState: BaseState.error(
              exception ?? Exception('Unknown error'),
            ),
          ),
        );
      },
    );
  }

  Future<void> _addAddress(AddAddressEvent event) async {
    if (state.addAddressState.isLoading) return;

    emit(state.copyWith(addAddressState: const BaseState.loading()));

    final result = await _addAddressUseCase(event.entity);

    result.when(
      success: (data) {
        if (data != null) {
          emit(state.copyWith(addAddressState: BaseState.success(data)));
        } else {
          emit(
            state.copyWith(
              addAddressState: BaseState.error(Exception('No data received')),
            ),
          );
        }
      },
      error: (exception) {
        emit(
          state.copyWith(
            addAddressState: BaseState.error(
              exception ?? Exception('Unknown error'),
            ),
          ),
        );
      },
    );
  }

  Future<void> _updateAddress(UpdateAddressEvent event) async {
    if (state.updateAddressState.isLoading) return;

    emit(state.copyWith(updateAddressState: const BaseState.loading()));

    final result = await _updateAddressUseCase(event.entity);

    result.when(
      success: (data) {
        if (data != null) {
          emit(state.copyWith(updateAddressState: BaseState.success(data)));
        } else {
          emit(
            state.copyWith(
              updateAddressState: BaseState.error(
                Exception('No data received'),
              ),
            ),
          );
        }
      },
      error: (exception) {
        emit(
          state.copyWith(
            updateAddressState: BaseState.error(
              exception ?? Exception('Unknown error'),
            ),
          ),
        );
      },
    );
  }

  Future<void> _deleteAddress(DeleteAddressEvent event) async {
    if (state.deleteAddressState.isLoading) return;

    emit(state.copyWith(deleteAddressState: const BaseState.loading()));

    final result = await _deleteAddressUseCase.call(event.id);

    result.when(
      success: (data) {
        emit(state.copyWith(deleteAddressState: BaseState.success(data)));
      },
      error: (exception) {
        emit(
          state.copyWith(
            deleteAddressState: BaseState.error(
              exception ?? Exception('Unknown error'),
            ),
          ),
        );
      },
    );
  }

  void reset() {
    emit(const AddressesStates());
  }
}
