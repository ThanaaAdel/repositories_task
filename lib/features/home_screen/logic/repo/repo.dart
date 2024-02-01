

import 'package:repositories/core/networking/api_error_handler.dart';

import '../../../../core/networking/api_result.dart';
import '../../../../core/networking/web_services.dart';
import '../../data/model/repositories_model.dart';


class MyRepo {
  final WebServices webServices;

  MyRepo(this.webServices);

  Future<ApiResult<Repositories>> getAllRepository(int page) async {
    try {
      var response = await webServices.getAllRepository(page);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

}