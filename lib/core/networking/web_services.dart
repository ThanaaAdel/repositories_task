import 'package:dio/dio.dart';
import 'package:repositories/core/networking/api_constant.dart';
import 'package:retrofit/retrofit.dart';

import '../../features/home_screen/data/model/repositories_model.dart';



part 'web_services.g.dart';

@RestApi(baseUrl: ApiConstant.apiBaseUrl)
abstract class WebServices {
  factory WebServices(Dio dio, {String baseUrl}) = _WebServices;
  @GET('search/repositories?q=created:%3E2019-01-10')
  Future<Repositories> getAllRepository(@Query('page') int page);

}