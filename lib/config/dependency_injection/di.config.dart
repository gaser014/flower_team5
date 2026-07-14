// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:dio/dio.dart' as _i361;
import 'package:firebase_remote_config/firebase_remote_config.dart' as _i627;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart'
    as _i161;
import 'package:logger/logger.dart' as _i974;

import '../../core/api/datasources/auth_local_data_source_impl.dart' as _i424;
import '../../core/data/data_sources/auth_local_data_source.dart' as _i759;
import '../../features/addresses/api/api_client/addresses_api_client.dart'
    as _i567;
import '../../features/addresses/api/data_sources/addresses_local_data_source_impl.dart'
    as _i75;
import '../../features/addresses/api/data_sources/addresses_remote_data_source_impl.dart'
    as _i882;
import '../../features/addresses/data/data_sources/addresses_local_data_source_contract.dart'
    as _i399;
import '../../features/addresses/data/data_sources/addresses_remote_data_source_contract.dart'
    as _i747;
import '../../features/addresses/data/repositories/addresses_repository_impl.dart'
    as _i837;
import '../../features/addresses/domain/repositories/addresses_repository.dart'
    as _i1;
import '../../features/addresses/domain/use_cases/add_address.dart' as _i952;
import '../../features/addresses/domain/use_cases/delete_address.dart' as _i441;
import '../../features/addresses/domain/use_cases/get_addresses.dart' as _i825;
import '../../features/addresses/domain/use_cases/get_nearest_address.dart'
    as _i640;
import '../../features/addresses/domain/use_cases/update_address.dart' as _i175;
import '../../features/addresses/presentation/cubit/addresses_cubit.dart'
    as _i3;
import '../../features/app_filter_tabs/api/api_client/app_filter_tabs_api_client.dart'
    as _i173;
import '../../features/app_filter_tabs/api/datasources/app_filter_tabs_remote_data_source_impl.dart'
    as _i849;
import '../../features/app_filter_tabs/data/datasources/app_filter_tabs_remote_data_source_contract.dart'
    as _i823;
import '../../features/app_filter_tabs/data/repositories/app_filter_tabs_repository_impl.dart'
    as _i539;
import '../../features/app_filter_tabs/domain/repositories/app_filter_tabs_repository.dart'
    as _i902;
import '../../features/app_filter_tabs/domain/use_cases/get_all_app_filter_tabs.dart'
    as _i313;
import '../../features/app_filter_tabs/presentation/view_model/cubit/app_filter_tabs_cubit.dart'
    as _i468;
import '../../features/auth/sign_up/api/api_client/sign_up_api_client.dart'
    as _i429;
import '../../features/auth/sign_up/api/data_sources/sign_up_remote_data_source_impl.dart'
    as _i1052;
import '../../features/auth/sign_up/data/data_sources/sign_up_remote_data_source.dart'
    as _i897;
import '../../features/auth/sign_up/data/repositories/sign_up_repository_impl.dart'
    as _i442;
import '../../features/auth/sign_up/domain/repositories/sign_up_repository_contract.dart'
    as _i100;
import '../../features/auth/sign_up/domain/use_cases/sign_up_use_case.dart'
    as _i45;
import '../../features/auth/sign_up/presentation/cubit/sign_up_cubit.dart'
    as _i809;
import '../../features/best_seller/api/api_client/best_seller_api_client.dart'
    as _i618;
import '../../features/best_seller/api/datasources/best_seller_remote_data_source_impl.dart'
    as _i1015;
import '../../features/best_seller/data/datasources/best_seller_remote_data_source_contract.dart'
    as _i1017;
import '../../features/best_seller/data/repositories/best_seller_repository_impl.dart'
    as _i360;
import '../../features/best_seller/domain/repositories/best_seller_repository.dart'
    as _i727;
import '../../features/best_seller/domain/use_cases/get_best_sellers_use_case.dart'
    as _i414;
import '../../features/best_seller/presentation/view_model/cubit/best_seller_cubit.dart'
    as _i702;
import '../../features/cart/api/api_client/cart_api_client.dart' as _i673;
import '../../features/cart/api/datasources/cart_remote_data_source_impl.dart'
    as _i210;
import '../../features/cart/data/datasources/cart_remote_data_source_contract.dart'
    as _i258;
import '../../features/cart/data/repositories/cart_repository_impl.dart'
    as _i642;
import '../../features/cart/domain/repositories/cart_repository.dart' as _i322;
import '../../features/cart/domain/use_cases/add_product_to_cart_use_case.dart'
    as _i473;
import '../../features/cart/domain/use_cases/clear_user_cart_use_case.dart'
    as _i314;
import '../../features/cart/domain/use_cases/get_cart_data_use_case.dart'
    as _i254;
import '../../features/cart/domain/use_cases/remove_product_from_cart_use_case.dart'
    as _i24;
import '../../features/cart/domain/use_cases/update_product_in_cart_usecase.dart'
    as _i774;
import '../../features/cart/presentation/view_model/cart_sync_service.dart'
    as _i143;
import '../../features/cart/presentation/view_model/cubit/cart_cubit.dart'
    as _i323;
import '../../features/categories/api/api_client/categories_api_client.dart'
    as _i612;
import '../../features/categories/api/datasources/categories_local_data_source_impl.dart'
    as _i575;
import '../../features/categories/api/datasources/categories_remote_data_source_impl.dart'
    as _i740;
import '../../features/categories/data/datasources/categories_local_data_source_contract.dart'
    as _i641;
import '../../features/categories/data/datasources/categories_remote_data_source_contract.dart'
    as _i234;
import '../../features/categories/data/repositories/categories_repository_impl.dart'
    as _i245;
import '../../features/categories/domain/repositories/categories_repository.dart'
    as _i488;
import '../../features/categories/domain/use_cases/get_all_categories.dart'
    as _i63;
import '../../features/categories/presentation/view_model/cubit/categories_cubit.dart'
    as _i806;
import '../../features/checkout/api/api_client/checkout_api_client.dart'
    as _i832;
import '../../features/checkout/api/datasources/checkout_remote_data_source_impl.dart'
    as _i551;
import '../../features/checkout/api/datasources/order_firestore_data_source_impl.dart'
    as _i315;
import '../../features/checkout/data/datasources/checkout_remote_data_source_contract.dart'
    as _i85;
import '../../features/checkout/data/datasources/order_firestore_data_source_contract.dart'
    as _i975;
import '../../features/checkout/data/repositories/checkout_repository_impl.dart'
    as _i949;
import '../../features/checkout/domain/repositories/checkout_repository.dart'
    as _i498;
import '../../features/checkout/domain/use_cases/checkout_with_card_usecase.dart'
    as _i413;
import '../../features/checkout/domain/use_cases/checkout_with_cash_usecase.dart'
    as _i447;
import '../../features/checkout/domain/use_cases/sync_card_order_usecase.dart'
    as _i682;
import '../../features/checkout/presentation/view_model/cubit/checkout_cubit.dart'
    as _i574;
import '../../features/home/api/api_client/home_api_client.dart' as _i592;
import '../../features/home/api/datasources/home_remote_data_source_impl.dart'
    as _i796;
import '../../features/home/data/datasources/home_remote_data_source_contract.dart'
    as _i969;
import '../../features/home/data/repositories/home_repository_impl.dart'
    as _i76;
import '../../features/home/domain/repositories/home_repository.dart' as _i0;
import '../../features/home/domain/use_cases/get_home_use_case.dart' as _i261;
import '../../features/location/api/data_sources/location_local_data_source_impl.dart'
    as _i570;
import '../../features/location/api/data_sources/location_remote_data_source_impl.dart'
    as _i534;
import '../../features/location/data/data_sources/location_local_data_source_contract.dart'
    as _i96;
import '../../features/location/data/data_sources/location_remote_data_source_contract.dart'
    as _i923;
import '../../features/location/data/repositories/location_repository_impl.dart'
    as _i115;
import '../../features/location/domain/repositories/location_repository.dart'
    as _i332;
import '../../features/location/domain/use_cases/get_current_location.dart'
    as _i1026;
import '../../features/location/domain/use_cases/request_location_permission.dart'
    as _i742;
import '../../features/location/presentation/cubit/location_cubit.dart'
    as _i181;
import '../../features/login/api/api_client/login_api_client.dart' as _i395;
import '../../features/login/api/datasources/login_local_data_source_impl.dart'
    as _i438;
import '../../features/login/api/datasources/login_remote_data_source_impl.dart'
    as _i904;
import '../../features/login/data/datasources/login_local_data_source_contract.dart'
    as _i325;
import '../../features/login/data/datasources/login_remote_data_source_contract.dart'
    as _i736;
import '../../features/login/data/repositories/login_repository_impl.dart'
    as _i1066;
import '../../features/login/domain/repositories/login_repository.dart'
    as _i902;
import '../../features/login/domain/use_cases/get_user_use_case.dart' as _i12;
import '../../features/login/domain/use_cases/login_use_case.dart' as _i191;
import '../../features/login/domain/use_cases/save_user_use_case.dart' as _i71;
import '../../features/login/presentation/view_model/cubit/login_cubit.dart'
    as _i753;
import '../../features/main/presentation/view_model/cubit/home_cubit.dart'
    as _i679;
import '../../features/main_profile/api/api_client/main_profile_api_client.dart'
    as _i89;
import '../../features/main_profile/api/datasources/main_profile_remote_data_source_impl.dart'
    as _i522;
import '../../features/main_profile/data/datasources/main_profile_remote_data_source_contract.dart'
    as _i525;
import '../../features/main_profile/data/repositories/main_profile_repository_impl.dart'
    as _i164;
import '../../features/main_profile/domain/repositories/main_profile_repository.dart'
    as _i488;
import '../../features/main_profile/domain/use_cases/get_main_profile_use_case.dart'
    as _i818;
import '../../features/main_profile/presentation/view_model/cubit/main_profile_cubit.dart'
    as _i60;
import '../../features/product_details/api/api_client/product_details_api_client.dart'
    as _i327;
import '../../features/product_details/api/datasources/product_details_remote_data_source_impl.dart'
    as _i906;
import '../../features/product_details/data/datasources/product_details_remote_data_source_contract.dart'
    as _i619;
import '../../features/product_details/data/repositories/product_details_repository_impl.dart'
    as _i285;
import '../../features/product_details/domain/repositories/product_details_repository.dart'
    as _i88;
import '../../features/product_details/domain/use_cases/get_product_details_use_case.dart'
    as _i90;
import '../../features/product_details/presentation/view_model/cubit/product_details_cubit.dart'
    as _i820;
import '../../features/products/api/api_client/products_api_client.dart'
    as _i41;
import '../../features/products/api/datasources/products_local_data_source_impl.dart'
    as _i1032;
import '../../features/products/api/datasources/products_remote_data_source_impl.dart'
    as _i838;
import '../../features/products/data/datasources/products_local_data_source_contract.dart'
    as _i47;
import '../../features/products/data/datasources/products_remote_data_source_contract.dart'
    as _i106;
import '../../features/products/data/repositories/products_repository_impl.dart'
    as _i1045;
import '../../features/products/domain/repositories/products_repository.dart'
    as _i27;
import '../../features/products/domain/use_cases/get_all_products.dart'
    as _i845;
import '../../features/products/presentation/view_model/cubit/products_cubit.dart'
    as _i593;
import '../../features/reset_password/api/api_client/reset_password_api_client.dart'
    as _i801;
import '../../features/reset_password/data/repositories/reset_password_repository_impl.dart'
    as _i854;
import '../../features/reset_password/domain/repositories/reset_password_repository.dart'
    as _i833;
import '../../features/reset_password/domain/use_cases/reset_password_use_case.dart'
    as _i572;
import '../../features/reset_password/presentation/view_model/cubit/reset_password_cubit.dart'
    as _i1008;
import '../api/app_interceptor.dart' as _i449;
import '../api/dio_module.dart' as _i784;
import '../firebase/firebase_module.dart' as _i1055;
import 'home_module.dart' as _i473;
import 'injectable_module.dart' as _i109;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final dioModule = _$DioModule();
    final injectableModule = _$InjectableModule();
    final firebaseModule = _$FirebaseModule();
    gh.singleton<_i361.Dio>(() => dioModule.dio());
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => dioModule.secureStorage(),
    );
    gh.lazySingleton<_i361.CancelToken>(() => dioModule.cancelToken());
    gh.lazySingleton<_i161.InternetConnection>(
      () => dioModule.internetConnection(),
    );
    gh.lazySingleton<_i473.HomeModule>(() => _i473.HomeModule());
    gh.lazySingleton<_i974.Logger>(() => injectableModule.logger);
    gh.lazySingleton<_i627.FirebaseRemoteConfig>(
      () => injectableModule.firebaseRemoteConfig,
    );
    gh.lazySingleton<_i974.FirebaseFirestore>(() => firebaseModule.firestore);
    gh.factory<_i923.LocationRemoteDataSourceContract>(
      () => _i534.LocationRemoteDataSourceImpl(),
    );
    gh.factory<_i325.LoginLocalDataSourceContract>(
      () => _i438.LoginLocalDataSourceImpl(),
    );
    gh.factory<_i96.LocationLocalDataSourceContract>(
      () => _i570.LocationLocalDataSourceImpl(),
    );
    gh.factory<_i47.ProductsLocalDataSourceContract>(
      () => _i1032.ProductsLocalDataSourceImpl(),
    );
    gh.lazySingleton<_i641.CategoriesLocalDataSourceContract>(
      () => _i575.CategoriesLocalDataSourceImpl(),
    );
    gh.lazySingleton<_i567.AddressesApiClient>(
      () => _i567.AddressesApiClient(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i173.AppFilterTabsApiClient>(
      () => _i173.AppFilterTabsApiClient(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i612.CategoriesApiClient>(
      () => _i612.CategoriesApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i429.SignUpApiClient>(
      () => _i429.SignUpApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i618.BestSellerApiClient>(
      () => _i618.BestSellerApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i673.CartApiClient>(() => _i673.CartApiClient(gh<_i361.Dio>()));
    gh.factory<_i832.CheckoutApiClient>(
      () => _i832.CheckoutApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i592.HomeApiClient>(() => _i592.HomeApiClient(gh<_i361.Dio>()));
    gh.factory<_i395.LoginApiClient>(
      () => _i395.LoginApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i89.MainProfileApiClient>(
      () => _i89.MainProfileApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i327.ProductDetailsApiClient>(
      () => _i327.ProductDetailsApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i41.ProductsApiClient>(
      () => _i41.ProductsApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i801.ResetPasswordApiClient>(
      () => _i801.ResetPasswordApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i969.HomeRemoteDataSourceContract>(
      () => _i796.HomeRemoteDataSourceImpl(gh<_i592.HomeApiClient>()),
    );
    gh.factory<_i747.AddressesRemoteDataSourceContract>(
      () => _i882.AddressesRemoteDataSourceImpl(
        apiClient: gh<_i567.AddressesApiClient>(),
      ),
    );
    gh.factory<_i399.AddressesLocalDataSourceContract>(
      () => _i75.AddressesLocalDataSourceImpl(),
    );
    gh.singleton<_i449.AppInterceptors>(
      () => _i449.AppInterceptors(
        dio: gh<_i361.Dio>(),
        fss: gh<_i558.FlutterSecureStorage>(),
      ),
    );
    gh.factory<_i833.ResetPasswordRepositoryContract>(
      () =>
          _i854.ResetPasswordRepositoryImpl(gh<_i801.ResetPasswordApiClient>()),
    );
    gh.lazySingleton<_i332.LocationRepository>(
      () => _i115.LocationRepositoryImpl(
        gh<_i923.LocationRemoteDataSourceContract>(),
        gh<_i96.LocationLocalDataSourceContract>(),
      ),
    );
    gh.factory<_i640.GetNearestAddressUseCase>(
      () => _i640.GetNearestAddressUseCase(gh<_i332.LocationRepository>()),
    );
    gh.lazySingleton<_i759.AuthLocalDataSourceContract>(
      () =>
          _i424.AuthLocalDataSourceImpl(fss: gh<_i558.FlutterSecureStorage>()),
    );
    gh.factory<_i736.LoginRemoteDataSourceContract>(
      () => _i904.LoginRemoteDataSourceImpl(gh<_i395.LoginApiClient>()),
    );
    gh.factory<_i258.CartRemoteDataSourceContract>(
      () => _i210.CartRemoteDataSourceImpl(
        cartApiClient: gh<_i673.CartApiClient>(),
      ),
    );
    gh.factory<_i1026.GetCurrentLocationUseCase>(
      () => _i1026.GetCurrentLocationUseCase(gh<_i332.LocationRepository>()),
    );
    gh.factory<_i742.RequestLocationPermissionUseCase>(
      () => _i742.RequestLocationPermissionUseCase(
        gh<_i332.LocationRepository>(),
      ),
    );
    gh.factory<_i975.OrderFirestoreDataSourceContract>(
      () => _i315.OrderFirestoreDataSourceImpl(gh<_i974.FirebaseFirestore>()),
    );
    gh.factory<_i823.AppFilterTabsRemoteDataSourceContract>(
      () => _i849.AppFilterTabsRemoteDataSourceImpl(
        apiClient: gh<_i173.AppFilterTabsApiClient>(),
      ),
    );
    gh.factory<_i1.AddressesRepository>(
      () => _i837.AddressesRepositoryImpl(
        addressesRemoteDataSourceContract:
            gh<_i747.AddressesRemoteDataSourceContract>(),
      ),
    );
    gh.factory<_i106.ProductsRemoteDataSourceContract>(
      () => _i838.ProductsRemoteDataSourceImpl(
        apiClient: gh<_i41.ProductsApiClient>(),
      ),
    );
    gh.lazySingleton<_i897.SignUpRemoteDataSource>(
      () => _i1052.SignUpRemoteDataSourceImpl(gh<_i429.SignUpApiClient>()),
    );
    gh.factory<_i1017.BestSellerRemoteDataSourceContract>(
      () => _i1015.BestSellerRemoteDataSourceImpl(
        gh<_i618.BestSellerApiClient>(),
      ),
    );
    gh.factory<_i525.MainProfileRemoteDataSourceContract>(
      () => _i522.MainProfileRemoteDataSourceImpl(
        gh<_i89.MainProfileApiClient>(),
      ),
    );
    gh.factory<_i0.HomeRepository>(
      () => _i76.HomeRepositoryImpl(gh<_i969.HomeRemoteDataSourceContract>()),
    );
    gh.factory<_i619.ProductDetailsRemoteDataSourceContract>(
      () => _i906.ProductDetailsRemoteDataSourceImpl(
        gh<_i327.ProductDetailsApiClient>(),
      ),
    );
    gh.factory<_i85.CheckoutRemoteDataSourceContract>(
      () => _i551.CheckoutRemoteDataSourceImpl(gh<_i832.CheckoutApiClient>()),
    );
    gh.lazySingleton<_i234.CategoriesRemoteDataSourceContract>(
      () => _i740.CategoriesRemoteDataSourceImpl(
        apiClient: gh<_i612.CategoriesApiClient>(),
      ),
    );
    gh.factory<_i572.ResetPasswordUseCase>(
      () => _i572.ResetPasswordUseCase(
        gh<_i833.ResetPasswordRepositoryContract>(),
      ),
    );
    gh.factory<_i902.LoginRepositoryContract>(
      () => _i1066.LoginRepositoryImpl(
        gh<_i736.LoginRemoteDataSourceContract>(),
        gh<_i325.LoginLocalDataSourceContract>(),
      ),
    );
    gh.factory<_i498.CheckoutRepository>(
      () => _i949.CheckoutRepositoryImpl(
        gh<_i85.CheckoutRemoteDataSourceContract>(),
        gh<_i975.OrderFirestoreDataSourceContract>(),
        gh<_i759.AuthLocalDataSourceContract>(),
      ),
    );
    gh.factory<_i902.AppFilterTabsRepository>(
      () => _i539.AppFilterTabsRepositoryImpl(
        appFilterTabsRemoteDataSourceContract:
            gh<_i823.AppFilterTabsRemoteDataSourceContract>(),
      ),
    );
    gh.factory<_i727.BestSellerRepository>(
      () => _i360.BestSellerRepositoryImpl(
        gh<_i1017.BestSellerRemoteDataSourceContract>(),
      ),
    );
    gh.factory<_i261.GetHomeUseCase>(
      () => _i261.GetHomeUseCase(gh<_i0.HomeRepository>()),
    );
    gh.lazySingleton<_i100.SignUpRepositoryContract>(
      () => _i442.SignUpRepositoryImpl(
        gh<_i897.SignUpRemoteDataSource>(),
        gh<_i759.AuthLocalDataSourceContract>(),
      ),
    );
    gh.factory<_i414.GetBestSellersUseCase>(
      () => _i414.GetBestSellersUseCase(gh<_i727.BestSellerRepository>()),
    );
    gh.factory<_i27.ProductsRepository>(
      () => _i1045.ProductsRepositoryImpl(
        productsRemoteDataSourceContract:
            gh<_i106.ProductsRemoteDataSourceContract>(),
      ),
    );
    gh.factory<_i322.CartRepository>(
      () => _i642.CartRepositoryImpl(
        cartRemoteDataSourceContract: gh<_i258.CartRemoteDataSourceContract>(),
      ),
    );
    gh.factory<_i413.CheckoutWithCardUseCase>(
      () => _i413.CheckoutWithCardUseCase(gh<_i498.CheckoutRepository>()),
    );
    gh.factory<_i447.CheckoutWithCashUseCase>(
      () => _i447.CheckoutWithCashUseCase(gh<_i498.CheckoutRepository>()),
    );
    gh.factory<_i682.SyncCardOrderUseCase>(
      () => _i682.SyncCardOrderUseCase(gh<_i498.CheckoutRepository>()),
    );
    gh.factory<_i574.CheckoutCubit>(
      () => _i574.CheckoutCubit(
        gh<_i447.CheckoutWithCashUseCase>(),
        gh<_i413.CheckoutWithCardUseCase>(),
        gh<_i682.SyncCardOrderUseCase>(),
      ),
    );
    gh.factory<_i952.AddAddressUseCase>(
      () => _i952.AddAddressUseCase(gh<_i1.AddressesRepository>()),
    );
    gh.factory<_i441.DeleteAddressUseCase>(
      () => _i441.DeleteAddressUseCase(gh<_i1.AddressesRepository>()),
    );
    gh.factory<_i825.GetAddressesUseCase>(
      () => _i825.GetAddressesUseCase(gh<_i1.AddressesRepository>()),
    );
    gh.factory<_i175.UpdateAddressUseCase>(
      () => _i175.UpdateAddressUseCase(gh<_i1.AddressesRepository>()),
    );
    gh.factory<_i3.AddressesCubit>(
      () => _i3.AddressesCubit(
        getAddressesUseCase: gh<_i825.GetAddressesUseCase>(),
        addAddressUseCase: gh<_i952.AddAddressUseCase>(),
        updateAddressUseCase: gh<_i175.UpdateAddressUseCase>(),
        deleteAddressUseCase: gh<_i441.DeleteAddressUseCase>(),
      ),
    );
    gh.factory<_i488.MainProfileRepositoryContract>(
      () => _i164.MainProfileRepositoryImpl(
        gh<_i525.MainProfileRemoteDataSourceContract>(),
      ),
    );
    gh.factory<_i845.GetAllProductsUseCase>(
      () => _i845.GetAllProductsUseCase(gh<_i27.ProductsRepository>()),
    );
    gh.factory<_i88.ProductDetailsRepository>(
      () => _i285.ProductDetailsRepositoryImpl(
        gh<_i619.ProductDetailsRemoteDataSourceContract>(),
      ),
    );
    gh.factory<_i818.GetMainProfileUseCase>(
      () => _i818.GetMainProfileUseCase(
        gh<_i488.MainProfileRepositoryContract>(),
      ),
    );
    gh.factory<_i313.GetAllAppFilterTabsUseCase>(
      () =>
          _i313.GetAllAppFilterTabsUseCase(gh<_i902.AppFilterTabsRepository>()),
    );
    gh.factory<_i12.GetUserUseCase>(
      () => _i12.GetUserUseCase(gh<_i902.LoginRepositoryContract>()),
    );
    gh.factory<_i191.LoginUseCase>(
      () => _i191.LoginUseCase(gh<_i902.LoginRepositoryContract>()),
    );
    gh.factory<_i71.SaveUserUseCase>(
      () => _i71.SaveUserUseCase(gh<_i902.LoginRepositoryContract>()),
    );
    gh.lazySingleton<_i679.HomeCubit>(
      () => _i679.HomeCubit(gh<_i261.GetHomeUseCase>()),
    );
    gh.lazySingleton<_i488.CategoriesRepository>(
      () => _i245.CategoriesRepositoryImpl(
        categoriesRemoteDataSourceContract:
            gh<_i234.CategoriesRemoteDataSourceContract>(),
      ),
    );
    gh.lazySingleton<_i63.GetAllCategoriesUseCase>(
      () => _i63.GetAllCategoriesUseCase(gh<_i488.CategoriesRepository>()),
    );
    gh.factory<_i593.ProductsCubit>(
      () => _i593.ProductsCubit(
        getAllProductsUseCase: gh<_i845.GetAllProductsUseCase>(),
      ),
    );
    gh.factory<_i1008.ResetPasswordCubit>(
      () => _i1008.ResetPasswordCubit(gh<_i572.ResetPasswordUseCase>()),
    );
    gh.factory<_i60.MainProfileCubit>(
      () => _i60.MainProfileCubit(
        gh<_i818.GetMainProfileUseCase>(),
        gh<_i71.SaveUserUseCase>(),
      ),
    );
    gh.factory<_i473.AddProductToCartUseCase>(
      () => _i473.AddProductToCartUseCase(repo: gh<_i322.CartRepository>()),
    );
    gh.factory<_i314.ClearUserCartUseCase>(
      () => _i314.ClearUserCartUseCase(repo: gh<_i322.CartRepository>()),
    );
    gh.factory<_i254.GetCartDataUseCase>(
      () => _i254.GetCartDataUseCase(repo: gh<_i322.CartRepository>()),
    );
    gh.factory<_i24.RemoveProductFromCartUseCase>(
      () => _i24.RemoveProductFromCartUseCase(repo: gh<_i322.CartRepository>()),
    );
    gh.factory<_i774.UpdateProductInCartUsecase>(
      () => _i774.UpdateProductInCartUsecase(repo: gh<_i322.CartRepository>()),
    );
    gh.factory<_i702.BestSellerCubit>(
      () => _i702.BestSellerCubit(gh<_i414.GetBestSellersUseCase>()),
    );
    gh.lazySingleton<_i181.LocationCubit>(
      () => _i181.LocationCubit(
        gh<_i742.RequestLocationPermissionUseCase>(),
        gh<_i1026.GetCurrentLocationUseCase>(),
        gh<_i825.GetAddressesUseCase>(),
        gh<_i640.GetNearestAddressUseCase>(),
      ),
    );
    gh.factory<_i45.SignUpUseCase>(
      () => _i45.SignUpUseCase(gh<_i100.SignUpRepositoryContract>()),
    );
    gh.factory<_i468.AppFilterTabsCubit>(
      () => _i468.AppFilterTabsCubit(
        getAllAppFilterTabsUseCase: gh<_i313.GetAllAppFilterTabsUseCase>(),
      ),
    );
    gh.factory<_i753.LoginCubit>(
      () => _i753.LoginCubit(
        gh<_i191.LoginUseCase>(),
        gh<_i71.SaveUserUseCase>(),
      ),
    );
    gh.factory<_i90.GetProductDetailsUseCase>(
      () => _i90.GetProductDetailsUseCase(gh<_i88.ProductDetailsRepository>()),
    );
    gh.factory<_i806.CategoriesCubit>(
      () => _i806.CategoriesCubit(
        getAllCategoriesUseCase: gh<_i63.GetAllCategoriesUseCase>(),
      ),
    );
    gh.factory<_i820.ProductDetailsCubit>(
      () => _i820.ProductDetailsCubit(gh<_i90.GetProductDetailsUseCase>()),
    );
    gh.factory<_i143.CartSyncService>(
      () => _i143.CartSyncService(
        addProductToCartUseCase: gh<_i473.AddProductToCartUseCase>(),
        removeProductFromCartUseCase: gh<_i24.RemoveProductFromCartUseCase>(),
        updateProductInCartUseCase: gh<_i774.UpdateProductInCartUsecase>(),
      ),
    );
    gh.factory<_i809.SignUpCubit>(
      () => _i809.SignUpCubit(gh<_i45.SignUpUseCase>()),
    );
    gh.lazySingleton<_i323.CartCubit>(
      () => _i323.CartCubit(
        getCartDataUseCase: gh<_i254.GetCartDataUseCase>(),
        clearUserCartUseCase: gh<_i314.ClearUserCartUseCase>(),
        cartSyncService: gh<_i143.CartSyncService>(),
      ),
    );
    return this;
  }
}

class _$DioModule extends _i784.DioModule {}

class _$InjectableModule extends _i109.InjectableModule {}

class _$FirebaseModule extends _i1055.FirebaseModule {}
