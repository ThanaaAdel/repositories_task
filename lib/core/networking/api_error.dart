import 'package:json_annotation/json_annotation.dart';


part 'api_error.g.dart';

@JsonSerializable()
class ApiErrorModel {
  String? message;


  ApiErrorModel({this.message});
  factory ApiErrorModel.fromJson(Map<String, dynamic> json) => _$ApiErrorModelFromJson(json);

  Map<String, dynamic> toJson() => _$ApiErrorModelToJson(this);
}
