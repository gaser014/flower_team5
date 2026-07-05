part of 'addresses_cubit.dart';

class AddressesStates extends Equatable {
  final BaseState<List<AddressEntity>> getAddressesState;
  final BaseState<List<AddressEntity>> addAddressState;
  final BaseState<List<AddressEntity>> updateAddressState;
  final BaseState<List<AddressEntity>> deleteAddressState;
  final GovernorateItem? formSelectedCity;
  final AreaItem? formSelectedArea;
  final double formSelectedLat;
  final double formSelectedLng;

  const AddressesStates({
    this.getAddressesState = const BaseState.initial(),
    this.addAddressState = const BaseState.initial(),
    this.updateAddressState = const BaseState.initial(),
    this.deleteAddressState = const BaseState.initial(),
    this.formSelectedCity,
    this.formSelectedArea,
    this.formSelectedLat = 31.04516268641246,
    this.formSelectedLng = 31.376411453247112,
  });

  AddressesStates copyWith({
    BaseState<List<AddressEntity>>? getAddressesState,
    BaseState<List<AddressEntity>>? addAddressState,
    BaseState<List<AddressEntity>>? updateAddressState,
    BaseState<List<AddressEntity>>? deleteAddressState,
    GovernorateItem? formSelectedCity,
    AreaItem? formSelectedArea,
    double? formSelectedLat,
    double? formSelectedLng,
    bool clearFormSelectedCity = false,
    bool clearFormSelectedArea = false,
    bool clearFormSelectedLat = false,
    bool clearFormSelectedLng = false,
  }) {
    return AddressesStates(
      getAddressesState: getAddressesState ?? this.getAddressesState,
      addAddressState: addAddressState ?? this.addAddressState,
      updateAddressState: updateAddressState ?? this.updateAddressState,
      deleteAddressState: deleteAddressState ?? this.deleteAddressState,
      formSelectedCity: clearFormSelectedCity
          ? null
          : (formSelectedCity ?? this.formSelectedCity),
      formSelectedArea: clearFormSelectedArea
          ? null
          : (formSelectedArea ?? this.formSelectedArea),
      formSelectedLat: clearFormSelectedLat
          ? 31.04516268641246
          : (formSelectedLat ?? this.formSelectedLat),
      formSelectedLng: clearFormSelectedLng
          ? 31.376411453247112
          : (formSelectedLng ?? this.formSelectedLng),
    );
  }

  @override
  List<Object?> get props => [
    getAddressesState,
    addAddressState,
    updateAddressState,
    deleteAddressState,
    formSelectedCity,
    formSelectedArea,
    formSelectedLat,
    formSelectedLng,
  ];
}
