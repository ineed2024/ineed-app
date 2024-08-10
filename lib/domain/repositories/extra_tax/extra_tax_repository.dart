import 'package:Ineed/domain/entities/extra_tax/confirm_extra_tax_entity.dart';
import 'package:Ineed/domain/entities/extra_tax/extra_tax_entity.dart';
import 'package:Ineed/domain/utils/resource_data.dart';

abstract class ExtraTaxRepository {
  Future<ResourceData<ExtraTaxEntity>> confirmExtraTax(
      ConfirmExtraTaxEntity params);
}
