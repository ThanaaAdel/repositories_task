import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../../features/home_screen/logic/repo/repo.dart';
import '../../features/home_screen/presentaion/cubit/repository_cubit.dart';
import '../networking/web_services.dart';

final getIt = GetIt.instance;

void initGetIt() {
  getIt.registerLazySingleton<CubitRepository>(() => CubitRepository(getIt()));
  getIt.registerLazySingleton<MyRepo>(() => MyRepo(getIt()));
  getIt.registerLazySingleton<WebServices>(
      () => WebServices(createAndSetupDio()));
}

  Dio createAndSetupDio() {
    Dio dio = Dio();

    dio
      ..options.connectTimeout = const Duration(minutes: 1)
      ..options.receiveTimeout = const Duration(minutes: 1);

    dio.interceptors.add(LogInterceptor(
      responseBody: true,
      error: true,
      requestHeader: false,
      responseHeader: false,
      request: true,
      requestBody: true,
    ));

    return dio;
  }
