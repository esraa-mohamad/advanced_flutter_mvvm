import 'package:advanced_flutter/app/app_prefs.dart';
import 'package:advanced_flutter/data/data_source/remote_data_source.dart';
import 'package:advanced_flutter/data/network/app_api.dart';
import 'package:advanced_flutter/data/network/dio_factory.dart';
import 'package:advanced_flutter/data/network/network_info.dart';
import 'package:advanced_flutter/data/repository/repository_impl.dart';
import 'package:advanced_flutter/domain/repository/repository.dart';
import 'package:advanced_flutter/domain/usecase/login_usecase.dart';
import 'package:advanced_flutter/presentation/screens/login/viewModel/login_viewModel.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final instance =GetIt.instance;

Future<void> initAppModule() async{
  // app module , its a module where we put all generic dependencies

  // register lazy single tone بيفضل محتفظ ب الانستانس الي سجلته فيه علي مدار الابب
  // shared preferences instance
  final sharedPrefs = await SharedPreferences.getInstance();

  instance.registerLazySingleton<SharedPreferences>(
          ()=>sharedPrefs);

  // apps prefs instance
  instance.registerLazySingleton<AppPreferences>(
          () => AppPreferences(instance()));

  // network info
  instance.registerLazySingleton<NetworkInfo>(
          () => NetworkInfoImplementation(InternetConnectionChecker()));

  // dio factory
  instance.registerLazySingleton<DioFactory>(
          () => DioFactory(instance()));

  Dio dio = await instance<DioFactory>().getDio();
  // app services client
  instance.registerLazySingleton<AppServicesClient>(
          () => AppServicesClient(dio));

  // remote data source
  instance.registerLazySingleton<RemoteDataSource>(
          () => RemoteDataSourceImplementation(instance<AppServicesClient>()));

  // repository
  instance.registerLazySingleton<Repository>(
          () => RepositoryImpl(instance<RemoteDataSource>(), instance<NetworkInfo>()));
}

initLoginModule() {

  // instance for once within login
  // register factory
  if(!GetIt.I.isRegistered<LoginUseCase>()){
    // login use case
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));

    // login view model
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
  }

}