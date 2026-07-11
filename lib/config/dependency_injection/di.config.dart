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
import '../../features/home/api/api_client/home_api_client.dart' as _i592;
import '../../features/home/api/datasources/home_remote_data_source_impl.dart'
    as _i796;
import '../../features/home/data/datasources/home_remote_data_source_contract.dart'
    as _i969;
import '../../features/home/data/repositories/home_repository_impl.dart'
    as _i76;
import '../../features/home/domain/entities/home_entity.dart' as _i628;
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
import '../../features/track/api/datasources/track_local_data_source_impl.dart'
    as _i536;
import '../../features/track/api/datasources/track_remote_data_source_impl.dart'
    as _i978;
import '../../features/track/data/datasources/track_local_data_source_contract.dart'
    as _i389;
import '../../features/track/data/datasources/track_remote_data_source_contract.dart'
    as _i732;
import '../../features/track/data/repositories/track_repository_impl.dart'
    as _i253;
import '../../features/track/domain/repositories/track_repository.dart'
    as _i300;
import '../../features/track/domain/use_cases/get_last_tracked_order_use_case.dart'
    as _i942;
import '../../features/track/domain/use_cases/get_order_use_case.dart' as _i906;
import '../../features/track/domain/use_cases/mark_delivered_use_case.dart'
    as _i588;
import '../../features/track/domain/use_cases/save_last_tracked_order_use_case.dart'
    as _i396;
import '../../features/track/domain/use_cases/watch_order_use_case.dart'
    as _i150;
import '../../features/track/domain/use_cases/watch_user_order_use_case.dart'
    as _i475;
import '../../features/track/presentation/view_model/cubit/track_cubit.dart'
    as _i7;
import '../api/app_interceptor.dart' as _i449;
import '../api/dio_module.dart' as _i784;
import '../fcm/order_notification_service.dart' as _i560;
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
    gh.lazySingleton<_i974.Logger>(() => injectableModule.logger);
    gh.lazySingleton<_i627.FirebaseRemoteConfig>(
      () => injectableModule.firebaseRemoteConfig,
    );
    gh.lazySingleton<_i974.FirebaseFirestore>(() => firebaseModule.firestore);
    gh.factory<_i923.LocationRemoteDataSourceContract>(
      () => _i534.LocationRemoteDataSourceImpl(),
    );
    gh.lazySingleton<_i389.TrackLocalDataSourceContract>(
      () => _i536.TrackLocalDataSourceImpl(),
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
    gh.lazySingleton<_i567.AddressesApiClient>(
      () => _i567.AddressesApiClient(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i173.AppFilterTabsApiClient>(
      () => _i173.AppFilterTabsApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i429.SignUpApiClient>(
      () => _i429.SignUpApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i618.BestSellerApiClient>(
      () => _i618.BestSellerApiClient(gh<_i361.Dio>()),
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
    gh.lazySingleton<_i473.HomeModule>(
      () => _i473.HomeModule(gh<_i628.HomeEntity>()),
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
    gh.lazySingleton<_i732.TrackRemoteDataSourceContract>(
      () => _i978.TrackRemoteDataSourceImpl(
        firestore: gh<_i974.FirebaseFirestore>(),
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
    gh.lazySingleton<_i560.OrderNotificationService>(
      () => _i560.OrderNotificationService(gh<_i974.FirebaseFirestore>()),
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
    gh.lazySingleton<_i300.TrackRepository>(
      () => _i253.TrackRepositoryImpl(
        remoteDataSource: gh<_i732.TrackRemoteDataSourceContract>(),
        localDataSource: gh<_i389.TrackLocalDataSourceContract>(),
        orderNotificationService: gh<_i560.OrderNotificationService>(),
      ),
    );
    gh.factory<_i619.ProductDetailsRemoteDataSourceContract>(
      () => _i906.ProductDetailsRemoteDataSourceImpl(
        gh<_i327.ProductDetailsApiClient>(),
      ),
    );
    gh.factory<_i942.GetLastTrackedOrderUseCase>(
      () => _i942.GetLastTrackedOrderUseCase(gh<_i300.TrackRepository>()),
    );
    gh.factory<_i906.GetOrderUseCase>(
      () => _i906.GetOrderUseCase(gh<_i300.TrackRepository>()),
    );
    gh.factory<_i588.MarkDeliveredUseCase>(
      () => _i588.MarkDeliveredUseCase(gh<_i300.TrackRepository>()),
    );
    gh.factory<_i396.SaveLastTrackedOrderUseCase>(
      () => _i396.SaveLastTrackedOrderUseCase(gh<_i300.TrackRepository>()),
    );
    gh.factory<_i150.WatchOrderUseCase>(
      () => _i150.WatchOrderUseCase(gh<_i300.TrackRepository>()),
    );
    gh.factory<_i475.WatchUserOrderUseCase>(
      () => _i475.WatchUserOrderUseCase(gh<_i300.TrackRepository>()),
    );
    gh.factory<_i902.LoginRepositoryContract>(
      () => _i1066.LoginRepositoryImpl(
        gh<_i736.LoginRemoteDataSourceContract>(),
        gh<_i325.LoginLocalDataSourceContract>(),
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
    gh.factory<_i7.TrackCubit>(
      () => _i7.TrackCubit(
        getOrderUseCase: gh<_i906.GetOrderUseCase>(),
        watchOrderUseCase: gh<_i150.WatchOrderUseCase>(),
        markDeliveredUseCase: gh<_i588.MarkDeliveredUseCase>(),
        saveLastTrackedOrderUseCase: gh<_i396.SaveLastTrackedOrderUseCase>(),
        getLastTrackedOrderUseCase: gh<_i942.GetLastTrackedOrderUseCase>(),
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
    gh.factory<_i593.ProductsCubit>(
      () => _i593.ProductsCubit(
        getAllProductsUseCase: gh<_i845.GetAllProductsUseCase>(),
      ),
    );
    gh.factory<_i60.MainProfileCubit>(
      () => _i60.MainProfileCubit(
        gh<_i818.GetMainProfileUseCase>(),
        gh<_i71.SaveUserUseCase>(),
      ),
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
    gh.factory<_i820.ProductDetailsCubit>(
      () => _i820.ProductDetailsCubit(gh<_i90.GetProductDetailsUseCase>()),
    );
    gh.factory<_i809.SignUpCubit>(
      () => _i809.SignUpCubit(gh<_i45.SignUpUseCase>()),
    );
    return this;
  }
}

class _$DioModule extends _i784.DioModule {}

class _$InjectableModule extends _i109.InjectableModule {}

class _$FirebaseModule extends _i1055.FirebaseModule {}
