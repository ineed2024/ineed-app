import 'package:Ineed/domain/entities/discount/discount_entity.dart';
import 'package:Ineed/domain/repositories/discount/discount_repository.dart';
import 'package:Ineed/domain/usecases/base/base_future_use_case.dart';
import 'package:Ineed/domain/utils/resource_data.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetDiscountUseCase
    extends BaseFutureUseCase<void, ResourceData<List<DiscountEntity>>> {
  DiscountRepository _discountRepository;
  GetDiscountUseCase(this._discountRepository);
  @override
  Future<ResourceData<List<DiscountEntity>>> call([void params]) async {
    return await _discountRepository.getDiscount();
  }
}
