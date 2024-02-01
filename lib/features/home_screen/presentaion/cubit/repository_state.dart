import 'package:freezed_annotation/freezed_annotation.dart';


part 'repository_state.freezed.dart';

@freezed
class RepositoriesState<T> with _$RepositoriesState<T> {
  const factory RepositoriesState.idle() = _Idle;

  const factory RepositoriesState.loading() = Loading;

  const factory RepositoriesState.success(T data) = Success<T>;

  const factory RepositoriesState.error({required String error}) =Error;
}