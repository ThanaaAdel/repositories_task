import 'package:bloc/bloc.dart';
import 'package:repositories/features/home_screen/presentaion/cubit/repository_state.dart';
import '../../data/model/repositories_model.dart';
import '../../logic/repo/repo.dart';

class CubitRepository extends Cubit<RepositoriesState<Repositories>> {
  final MyRepo myRepo;
  CubitRepository(this.myRepo) : super( const RepositoriesState.idle());

  void emitGetAllRepository({int page = 1}) async {
    var data = await myRepo.getAllRepository(page);

    data.when(success: (allUsers) {

      emit(RepositoriesState.success(allUsers));
    }, failure: (error) {
      emit(RepositoriesState.error(error:   error.apiErrorModel.message ?? ''));
    });
  }


}