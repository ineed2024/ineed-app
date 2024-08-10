import 'package:Ineed/domain/entities/extra_tax/confirm_extra_tax_entity.dart';
import 'package:Ineed/domain/entities/extra_tax/extra_tax_entity.dart';
import 'package:Ineed/domain/repositories/extra_tax/extra_tax_repository.dart';
import 'package:Ineed/domain/utils/resource_data.dart';

import '../data_source/extra_tax/extra_tax_remote_data_source.dart';

class ExtraTaxRepositoryImpl implements ExtraTaxRepository {
  ExtraTaxRemoteDataSource _extraTaxRemoteDataSource;

  ExtraTaxRepositoryImpl(this._extraTaxRemoteDataSource);

  @override
  Future<ResourceData<ExtraTaxEntity>> confirmExtraTax(
      ConfirmExtraTaxEntity params) async {
    final resource = await _extraTaxRemoteDataSource.confirmExtraTax(params);

    return resource;
  }
}
