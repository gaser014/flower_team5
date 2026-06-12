part of 'addresses_cubit.dart';

class AddressesStates extends Equatable {
  final BaseState<List<AddressEntity>> getAddressesState;
  final BaseState<AddressEntity> addAddressState;
  final BaseState<AddressEntity> updateAddressState;
  final BaseState<void> deleteAddressState;

  const AddressesStates({
    this.getAddressesState = const BaseState.initial(),
    this.addAddressState = const BaseState.initial(),
    this.updateAddressState = const BaseState.initial(),
    this.deleteAddressState = const BaseState.initial(),
  });

  AddressesStates copyWith({
    BaseState<List<AddressEntity>>? getAddressesState,
    BaseState<AddressEntity>? addAddressState,
    BaseState<AddressEntity>? updateAddressState,
    BaseState<void>? deleteAddressState,
  }) {
    return AddressesStates(
      getAddressesState: getAddressesState ?? this.getAddressesState,
      addAddressState: addAddressState ?? this.addAddressState,
      updateAddressState: updateAddressState ?? this.updateAddressState,
      deleteAddressState: deleteAddressState ?? this.deleteAddressState,
    );
  }

  @override
  List<Object?> get props => [getAddressesState, addAddressState, updateAddressState, deleteAddressState];
}
