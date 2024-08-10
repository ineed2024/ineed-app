import 'package:Ineed/data/data_source/service/category_remote_data_source.dart';
import 'package:Ineed/data/data_source/service/service_remote_data_source.dart';
import 'package:Ineed/data/data_source/solicitation/solicitation_remote_data_source.dart';
import 'package:Ineed/data/repositories/services/service_repository_impl.dart';
import 'package:Ineed/data/repositories/solicitation/solicitation_repository_impl.dart';
import 'package:Ineed/domain/repositories/auth/auth_repository.dart';
import 'package:Ineed/domain/repositories/services/category_repository.dart';
import 'package:Ineed/domain/repositories/services/service_repository.dart';
import 'package:Ineed/domain/repositories/solicitation/solicitation_repository.dart';
import 'package:Ineed/domain/usecases/services/get_all_categories_use_case.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:Ineed/data/local/shared_preferences.dart';
import '../data/data_source/address/address_remote_data_source.dart';
import '../data/data_source/auth/auth_local_data_source.dart';
import '../data/data_source/auth/auth_remote_data_source.dart';
import '../data/data_source/budget/budget_remote_data_source.dart';
import '../data/data_source/card/card_remote_data_source.dart';
import '../data/data_source/configuration/configuration_local_data_source.dart';
import '../data/data_source/configuration/configuration_remote_data_source.dart';
import '../data/data_source/coupon/coupon_remote_data_source.dart';
import '../data/data_source/discount/discount_remote_data_source.dart';
import '../data/data_source/extra_tax/extra_tax_remote_data_source.dart';
import '../data/data_source/user/user_local_data_source.dart';
import '../data/data_source/user/user_remote_data_source.dart';
import '../data/data_source/visit/visit_remote_data_source.dart';
import '../data/extra_tax/extra_tax_repository_impl.dart';
import '../data/remote/custom_dio.dart';
import '../data/remote/interceptors/auth_interceptor.dart';
import '../data/repositories/address/address_repository_impl.dart';
import '../data/repositories/auth/auth_repository_impl.dart';
import '../data/repositories/budget/budget_repository_impl.dart';
import '../data/repositories/card/card_repository_impl.dart';
import '../data/repositories/configuration/configuration_repository_impl.dart';
import '../data/repositories/coupon/coupon_repository_impl.dart';
import '../data/repositories/discount/discount_repository_impl.dart';
import '../data/repositories/services/category_repository_impl.dart';
import '../data/repositories/user/user_repository_impl.dart';
import '../data/repositories/visit/visit_repository_impl.dart';
import '../domain/coupon/get_coupon_use_case.dart';
import '../domain/discount/activate_discount_use_case.dart';
import '../domain/discount/get_discount_use_case.dart';
import '../domain/extra_tax/confirm_extra_tax_use_case.dart';
import '../domain/repositories/address/address_repository.dart';
import '../domain/repositories/budget/budget_repository.dart';
import '../domain/repositories/card/card_repository.dart';
import '../domain/repositories/configuration/configuration_repository.dart';
import '../domain/repositories/coupon/coupon_repository.dart';
import '../domain/repositories/discount/discount_repository.dart';
import '../domain/repositories/extra_tax/extra_tax_repository.dart';
import '../domain/repositories/user/user_repository.dart';
import '../domain/repositories/visit/visit_repository.dart';
import '../domain/usecases/address/get_address_cep_use_case.dart';
import '../domain/usecases/auth/forgot_password_use_case.dart';
import '../domain/usecases/auth/login_user_email_use_case.dart';
import '../domain/usecases/auth/logout_use_case.dart';
import '../domain/usecases/auth/sign_in.use_case.dart';
import '../domain/usecases/auth/update_password_use_case.dart';
import '../domain/usecases/budget/confirm_budget_card_use_case.dart';
import '../domain/usecases/budget/rating_budget_use_case.dart';
import '../domain/usecases/card/create_card_use_case.dart';
import '../domain/usecases/card/delete_card_use_case.dart';
import '../domain/usecases/card/get_all_cards_use_case.dart';
import '../domain/usecases/card/get_card_use_case.dart';
import '../domain/usecases/configuration/enable_login_use_case.dart';
import '../domain/usecases/configuration/get_configuration_use_case.dart';
import '../domain/usecases/services/get_all_services_from_category_use_case.dart';
import '../domain/usecases/solicitation/create_solicitation_use_case.dart';
import '../domain/usecases/solicitation/detail_solicitation_use_case.dart';
import '../domain/usecases/solicitation/list_solicitations_use_case.dart';
import '../domain/usecases/solicitation/total_solicitation_open_use_case.dart';
import '../domain/usecases/user/profile_user_use_case.dart';
import '../domain/usecases/user/recoverPass_use_case.dart';
import '../domain/usecases/user/update_address_user_use_case.dart';
import '../domain/usecases/user/update_cpf_user_use_case.dart';
import '../domain/usecases/user/update_pass_use_case.dart';
import '../domain/usecases/user/update_phone_user_use_case.dart';
import '../domain/usecases/visit/confirm_visit_use_case.dart';
import '../domain/usecases/visit/confirm_visit_with_credit_card_use_case.dart';
import '../domain/usecases/visit/rating_visit_use_case.dart';

Future<GetIt> initGetIt(GetIt get) async {
  WidgetsFlutterBinding.ensureInitialized();
  final gh = GetItHelper(get);
  final dio = Dio();

  // Auth
  gh.factory<AuthInterceptor>(() => AuthInterceptor(get<Dio>()));

  gh.factory<AuthRemoteDataSource>(
      () => AuthRemoteDataSource(get<CustomDio>()));
  gh.factory<AuthLocalDataSource>(
      () => AuthLocalDataSource(get<SharedPreferencesManager>()));

  gh.factory<LoginUserEmailUseCase>(
      () => LoginUserEmailUseCase(get<AuthRepository>()));
  gh.factory<ForgotPasswordUseCase>(
      () => ForgotPasswordUseCase(get<AuthRepository>()));
  gh.factory<SignInUseCase>(() => SignInUseCase(get<AuthRepository>()));
  gh.factory<LogoutUseCase>(() => LogoutUseCase(get<AuthRepository>()));
  gh.factory<UpdatePasswordUseCase>(
      () => UpdatePasswordUseCase(get<AuthRepository>()));

  // services
  gh.factory<CategoryRemoteDataSource>(
      () => CategoryRemoteDataSource(get<CustomDio>()));
  gh.factory<GetAllCategoriesUseCase>(
      () => GetAllCategoriesUseCase(get<CategoryRepository>()));

  gh.factory<ServiceRemoteDataSource>(
      () => ServiceRemoteDataSource(get<CustomDio>()));
  gh.factory<GetAllServicesFromCategoryUseCase>(
      () => GetAllServicesFromCategoryUseCase(get<ServiceRepository>()));

  //Config
  gh.factory<ConfigurationRemoteDataSource>(
      () => ConfigurationRemoteDataSource(get<CustomDio>()));
  gh.factory<ConfigurationLocalDataSource>(
      () => ConfigurationLocalDataSource(get<SharedPreferencesManager>()));
  gh.factory<GetConfigurationUseCase>(
      () => GetConfigurationUseCase(get<ConfigurationRepository>()));
  gh.factory<EnableLoginUseCase>(
      () => EnableLoginUseCase(get<ConfigurationRepository>()));

  // solicitation
  gh.factory<SolicitationRemoteDataSource>(
      () => SolicitationRemoteDataSource(get<CustomDio>()));
  gh.factory<TotalSolicitationOpenUseCase>(
      () => TotalSolicitationOpenUseCase(get<SolicitationRepository>()));
  gh.factory<CreateSolicitationUseCase>(
      () => CreateSolicitationUseCase(get<SolicitationRepository>()));
  gh.factory<ListSolicitationsUseCase>(
      () => ListSolicitationsUseCase(get<SolicitationRepository>()));
  gh.factory<DetailSolicitationUseCase>(
      () => DetailSolicitationUseCase(get<SolicitationRepository>()));

  // Address
  gh.factory<AddressRemoteDataSource>(
      () => AddressRemoteDataSource(get<Dio>()));
  gh.factory<GetAddressCepUseCase>(
      () => GetAddressCepUseCase(get<AddressRepository>()));

  //budget
  gh.factory<BudgetRemoteDataSource>(
      () => BudgetRemoteDataSource(get<CustomDio>()));
  gh.factory<ConfirmBudgetCardUseCase>(
      () => ConfirmBudgetCardUseCase(get<BudgetRepository>()));
  gh.factory<RatingBudgetUseCase>(
      () => RatingBudgetUseCase(get<BudgetRepository>()));

  // Card
  gh.factory<CardRemoteDataSource>(
      () => CardRemoteDataSource(get<CustomDio>()));
  gh.factory<CreateCardUseCase>(() => CreateCardUseCase(get<CardRepository>()));
  gh.factory<GetAllCardUseCase>(() => GetAllCardUseCase(get<CardRepository>()));
  gh.factory<DeleteCardUseCase>(() => DeleteCardUseCase(get<CardRepository>()));
  gh.factory<GetCardUseCase>(() => GetCardUseCase(get<CardRepository>()));

  //discount
  gh.factory<DiscountRemoteDataSource>(
      () => DiscountRemoteDataSource(get<CustomDio>()));
  gh.factory<GetDiscountUseCase>(
      () => GetDiscountUseCase(get<DiscountRepository>()));
  gh.factory<ActivateDiscountUseCase>(
      () => ActivateDiscountUseCase(get<DiscountRepository>()));

  //extra_tax
  gh.factory<ExtraTaxRemoteDataSource>(
      () => ExtraTaxRemoteDataSource(get<CustomDio>()));
  gh.factory<ConfirmExtraTaxUseCase>(
      () => ConfirmExtraTaxUseCase(get<ExtraTaxRepository>()));

  // User
  // User
  gh.factory<UserRemoteDataSource>(
      () => UserRemoteDataSource(get<CustomDio>()));
  gh.factory<UserLocalDataSource>(
      () => UserLocalDataSource(get<SharedPreferencesManager>()));
  gh.factory<ProfileUserUseCase>(
      () => ProfileUserUseCase(get<UserRepository>()));
  gh.factory<UpdateAddressUseCase>(
      () => UpdateAddressUseCase(get<UserRepository>()));
  gh.factory<UpdateCpfUseCase>(() => UpdateCpfUseCase(get<UserRepository>()));
  gh.factory<UpdatePhoneUseCase>(
      () => UpdatePhoneUseCase(get<UserRepository>()));
  gh.factory<UpdatePassUseCase>(() => UpdatePassUseCase(get<UserRepository>()));
  gh.factory<RecoverPassUseCase>(
      () => RecoverPassUseCase(get<UserRepository>()));

  // visit
  gh.factory<VisitRemoteDataSource>(
      () => VisitRemoteDataSource(get<CustomDio>()));
  gh.factory<ConfirmVisitUseCase>(
      () => ConfirmVisitUseCase(get<VisitRepository>()));
  gh.factory<RatingVisitUseCase>(
      () => RatingVisitUseCase(get<VisitRepository>()));
  gh.factory<ConfirmVisitWithCreditCardUseCase>(
      () => ConfirmVisitWithCreditCardUseCase(get<VisitRepository>()));

  //coupon
  gh.factory<CouponRemoteDataSource>(
      () => CouponRemoteDataSource(get<CustomDio>()));
  gh.factory<GetCouponUseCase>(() => GetCouponUseCase(get<CouponRepository>()));

  // gh.factory<LoginUseCase>(() => LoginUseCase(get<AuthRepository>()));

  gh.singleton<Dio>(dio);
  gh.singleton<SharedPreferencesManager>(SharedPreferencesManager());
  gh.singleton<CustomDio>(CustomDio(get<Dio>(), get<AuthInterceptor>()));

  gh.singleton<AuthRepository>(AuthRepositoryImpl(
      get<AuthLocalDataSource>(), get<AuthRemoteDataSource>()));

  gh.singleton<ExtraTaxRepository>(
      ExtraTaxRepositoryImpl(get<ExtraTaxRemoteDataSource>()));

  gh.singleton<SolicitationRepository>(
      SolicitationRepositoryImpl(get<SolicitationRemoteDataSource>()));

  gh.singleton<CategoryRepository>(
      CategoryRepositoryImpl(get<CategoryRemoteDataSource>()));

  gh.singleton<ServiceRepository>(
      ServiceRepositoryImpl(get<ServiceRemoteDataSource>()));

  gh.singleton<UserRepository>(UserRepositoryImpl(
      get<UserRemoteDataSource>(), get<UserLocalDataSource>()));

  gh.singleton<AddressRepository>(
      AddressRepositoryImpl(get<AddressRemoteDataSource>()));

  gh.singleton<CardRepository>(CardRepositoryImpl(get<CardRemoteDataSource>()));

  gh.singleton<ConfigurationRepository>(ConfigurationRepositoryImpl(
      get<ConfigurationRemoteDataSource>(),
      get<ConfigurationLocalDataSource>()));

  gh.singleton<DiscountRepository>(
      DiscountRepositoryImpl(get<DiscountRemoteDataSource>()));

  gh.singleton<CouponRepository>(
      CouponRepositoryImpl(get<CouponRemoteDataSource>()));

  gh.singleton<VisitRepository>(
      VisitRepositoryImpl(get<VisitRemoteDataSource>()));

  gh.singleton<BudgetRepository>(
      BudgetRepositoryImpl(get<BudgetRemoteDataSource>()));

  return get;
}
