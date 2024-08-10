import 'package:Ineed/di/di.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:Ineed/domain/utils/resource_data.dart';
import 'package:Ineed/domain/utils/status.dart';

import '../../../../domain/entities/list/list_item.dart';
import '../../../../domain/usecases/services/get_all_services_from_category_use_case.dart';
part 'choose_service_controller.g.dart';

@Injectable()
class ChooseServiceController = _ChooseServiceControllerBase
    with _$ChooseServiceController;

abstract class _ChooseServiceControllerBase with Store {
  final getAllServicesFromCategoryUseCase =
      getIt.get<GetAllServicesFromCategoryUseCase>();

  @observable
  ResourceData<List<ListItem>> resourceServices =
      ResourceData(status: Status.initial);

  @observable
  Status statusButton = Status.initial;

  @action
  Future<void> getAllServicesFromCategory(int categoryId) async {
    resourceServices = ResourceData(status: Status.loading);
    final resource = await getAllServicesFromCategoryUseCase(categoryId);
    resourceServices = ResourceData(
        status: Status.success,
        data: List.from(resource.data ?? [])
            .map((e) => ListItem(data: e))
            .toList());
  }

  @action
  void onSelectedListItem(bool newValue, int index) {
    resourceServices.data![index].isSelected = newValue;
    resourceServices = resourceServices;
    print(resourceServices.data!.where((el) => el.isSelected).isNotEmpty);
    statusButton =
        resourceServices.data!.where((el) => el.isSelected).isNotEmpty
            ? Status.success
            : Status.failed;
  }
}
