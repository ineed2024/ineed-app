import 'dart:io';

import 'package:Ineed/app/utils/ui_helper.dart';
import 'package:Ineed/di/di.dart';
import 'package:Ineed/domain/entities/user/user_entity.dart';
import 'package:Ineed/domain/utils/resource_data.dart';
import 'package:Ineed/domain/utils/status.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../domain/configurations/configuration_entity.dart';
import '../../../../domain/entities/service/category_entity.dart';
import '../../../../domain/entities/service/service_entity.dart';
import '../../../../domain/entities/solicitation/create_solicitation_entity.dart';
import '../../../../domain/entities/solicitation/solicitation_entity.dart';
import '../../../../domain/usecases/configuration/get_configuration_use_case.dart';
import '../../../../domain/usecases/solicitation/create_solicitation_use_case.dart';
import '../../../../domain/usecases/user/profile_user_use_case.dart';

part 'create_solicitation_controller.g.dart';

@Injectable()
class CreateSolicitationController = _CreateSolicitationControllerBase
    with _$CreateSolicitationController;

abstract class _CreateSolicitationControllerBase with Store {
  final getCondigurationUseCase = getIt.get<GetConfigurationUseCase>();
  final getProfileUserUseCase = getIt.get<ProfileUserUseCase>();
  final createSolicitationUserUseCase = getIt.get<CreateSolicitationUseCase>();

  @observable
  ResourceData<SolicitationEntity> resourceSolicitation =
      ResourceData(status: Status.initial);

  @observable
  ResourceData<ConfigurationEntity> resourceConfiguration =
      ResourceData(status: Status.initial);

  @observable
  ResourceData<UserEntity> resourceUser = ResourceData(status: Status.initial);

  @observable
  String? address;

  String? phonenumber;
  String? cpfOrCnpj;

  @observable
  int? typeAddress;

  @observable
  DateTime? date;

  @observable
  TimeOfDay? startTime;

  @observable
  TimeOfDay? endTime;

  @observable
  bool customerSuppliesMaterial = false; // optional

  @observable
  bool urgent = false; // optional

  @observable
  String? observation; // optional

  @observable
  List<File> images = ObservableList<File>(); // optional

  @observable
  bool isValid = false;

  bool formIsValid = false;

  @action
  init() async {
    resourceConfiguration = ResourceData(status: Status.loading);
    resourceUser = ResourceData(status: Status.loading);
    resourceConfiguration = await getCondigurationUseCase();
    resourceUser = await getProfileUserUseCase();
    formatAddress();
  }

  @action
  formatAddress() {
    if (resourceUser.data!.address != null &&
        resourceUser.data!.number != null &&
        resourceUser.data!.city != null &&
        resourceUser.data!.uf != null) {
      final complement = resourceUser.data!.complement != null
          ? resourceUser.data!.complement
          : '';
      address =
          '${resourceUser.data!.address} ${resourceUser.data!.number} $complement\n${resourceUser.data!.city} - ${resourceUser.data!.uf}';
    }
  }

  @action
  updateAddress(ResourceData<UserEntity> data) {
    resourceUser = data;
    formatAddress();
  }

  changeFormIsValid(bool value) {
    formIsValid = value;
    isFormValidate();
  }

  bool isUserPhonenumber() {
    return resourceUser.data != null &&
            resourceUser.data!.phonenumber != null &&
            resourceUser.data!.phonenumber!.isNotEmpty
        ? true
        : false;
  }

  bool isUserCPFOrCNPJ() {
    return resourceUser.data != null &&
            resourceUser.data!.cpfCnpj != null &&
            resourceUser.data!.cpfCnpj!.isNotEmpty
        ? true
        : false;
  }

  changeObservation(String newObservation) {
    observation = newObservation;
    isFormValidate();
  }

  changeCpfOrCnpj(String newObservation) {
    cpfOrCnpj = newObservation;
    isFormValidate();
  }

  @action
  onChangePhonenumber(String newPhoneNumber) {
    phonenumber = newPhoneNumber;
    isFormValidate();
  }

  @action
  addImage(File newImage) {
    images.add(newImage);
  }

  @action
  removeImage(int index) {
    images.removeAt(index);
    isFormValidate();
  }

  @action
  changeAddress(String newAddress) {
    address = newAddress;
    isFormValidate();
  }

  @action
  changeDate(DateTime newDate) {
    date = newDate;
    isFormValidate();
  }

  @action
  changeStartTime(TimeOfDay newTimeOfDay) {
    startTime = newTimeOfDay;
    isFormValidate();
  }

  @action
  changeEndTime(TimeOfDay newTimeOfDay) {
    endTime = newTimeOfDay;
    isFormValidate();
  }

  changeTypeAddress(int newTypeAddress) {
    typeAddress = newTypeAddress;
    isFormValidate();
  }

  @action
  Future<ResourceData<SolicitationEntity>> createSolicitation(
      CategoryEntity category, List<ServiceEntity> listServices) async {
    resourceSolicitation = ResourceData(status: Status.loading);
    resourceSolicitation =
        await createSolicitationUserUseCase(CreateSolicitationEntity(
      address: address,
      images: images,
      note: observation,
      material: customerSuppliesMaterial,
      urgent: urgent,
      immobileId: typeAddress,
      services: listServices,
      finalDate:
          '${UIHelper.formatDateFromDateTimeReverse(date!)} ${UIHelper.formatTimeFromTimeOfDay(endTime!)}',
      initialDate:
          '${UIHelper.formatDateFromDateTimeReverse(date!)} ${UIHelper.formatTimeFromTimeOfDay(startTime!)}',
    ));
    return resourceSolicitation;
  }

  @action
  isFormValidate() {
    if (address != null &&
        typeAddress != null &&
        date != null &&
        startTime != null &&
        endTime != null &&
        (isUserPhonenumber() || phonenumber != null) &&
        (isUserCPFOrCNPJ() || cpfOrCnpj != null) &&
        formIsValid) {
      isValid = true;
      return;
    }
    isValid = false;
  }
}
