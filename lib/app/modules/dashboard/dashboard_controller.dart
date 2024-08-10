import 'package:Ineed/di/di.dart';
import 'package:Ineed/domain/utils/resource_data.dart';
import 'package:Ineed/domain/utils/status.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../domain/entities/service/category_entity.dart';
import '../../../domain/usecases/services/get_all_categories_use_case.dart';
import '../../../domain/usecases/solicitation/total_solicitation_open_use_case.dart';

part 'dashboard_controller.g.dart';

@Injectable()
class DashboardController = _DashboardControllerBase with _$DashboardController;

abstract class _DashboardControllerBase with Store {
  final _totalSolicitationOpenUseCase =
      getIt.get<TotalSolicitationOpenUseCase>();

  final _getAllCategoriesUseCase = getIt.get<GetAllCategoriesUseCase>();
  // final _ratingBudgetUseCase = getIt.get<RatingBudgetUseCase>();
  // final _confirmExtraTaxUseCase = getIt.get<ConfirmExtraTaxUseCase>();
  // final _getCouponUseCase = getIt.get<GetCouponUseCase>();
  // final _activateDiscountUseCase = getIt.get<ActivateDiscountUseCase>();
  // final _getAddressUseCase = getIt.get<GetAddressCepUseCase>();
  // final _updatePasswordUseCase = getIt.get<UpdatePasswordUseCase>();

  // TODO: REMOVER OS CASOS DE USO DE TESTE DEPOIS

  int totalSolicitationOpen = 0;

  @observable
  bool hasSolicitationOpen = true;

  @observable
  ResourceData<List<CategoryEntity>> categories =
      ResourceData(status: Status.initial);

  init() {
    getAllCategories();
    checkSolicitations();
  }

  // TODO: REMOVER DEPOIS
  testsUseCases() async {
    // var result = await _updatePasswordUseCase(
    //     UpdatePasswordEntity(passwordNew: '123456', passwordOld: '1234566'));

    // print("Result Login Fb: \n ${result.data.toString()}");
  }

  @action
  getAllCategories() async {
    categories = ResourceData(status: Status.loading);
    categories = await _getAllCategoriesUseCase();
    categories.data?.sort(
        (CategoryEntity a, CategoryEntity b) => a.title!.compareTo(b.title!));
  }

  @action
  checkSolicitations() async {
    hasSolicitationOpen = false;
    totalSolicitationOpen = await _totalSolicitationOpenUseCase();
    hasSolicitationOpen = totalSolicitationOpen > 0;
  }
}
