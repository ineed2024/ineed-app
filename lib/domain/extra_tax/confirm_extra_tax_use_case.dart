import 'package:Ineed/domain/entities/extra_tax/confirm_extra_tax_entity.dart';
import 'package:Ineed/domain/entities/extra_tax/extra_tax_entity.dart';
import 'package:Ineed/domain/repositories/extra_tax/extra_tax_repository.dart';
import 'package:Ineed/domain/usecases/base/base_future_use_case.dart';
import 'package:Ineed/domain/utils/resource_data.dart';
import 'package:injectable/injectable.dart';

@injectable
class ConfirmExtraTaxUseCase extends BaseFutureUseCase<ConfirmExtraTaxEntity,
    ResourceData<ExtraTaxEntity>> {
  ExtraTaxRepository _extraTaxRepository;
  ConfirmExtraTaxUseCase(this._extraTaxRepository);
  @override
  Future<ResourceData<ExtraTaxEntity>> call(
      [ConfirmExtraTaxEntity? params]) async {
    return await _extraTaxRepository.confirmExtraTax(params!);
  }
}
