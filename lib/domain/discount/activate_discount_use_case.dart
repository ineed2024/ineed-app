import 'package:Ineed/domain/entities/discount/discount_user_entity.dart';
import 'package:Ineed/domain/repositories/discount/discount_repository.dart';
import 'package:Ineed/domain/usecases/base/base_future_use_case.dart';
import 'package:Ineed/domain/utils/resource_data.dart';
import 'package:injectable/injectable.dart';

@injectable
class ActivateDiscountUseCase
    extends BaseFutureUseCase<String, ResourceData<DiscountUserEntity>> {
  DiscountRepository _discountRepository;
  ActivateDiscountUseCase(this._discountRepository);
  @override
  Future<ResourceData<DiscountUserEntity>> call([String? params]) async {
    return await _discountRepository.activateDiscount(params!);
  }
}
