import 'package:Ineed/app/modules/user/address/address_page.dart';
import 'package:Ineed/app/modules/user/cards/cards_module.dart';
import 'package:Ineed/app/modules/user/coupon/coupon_page.dart';
import 'package:Ineed/app/modules/user/update-password/update_password_page.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'update-field/update_field_page.dart';

class UserModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/update-field',
        child: (_, args) => UpdateFieldPage(
              type: args.data,
            )),
    ChildRoute('/updatePassword', child: (_, args) => UpdatePasswordPage()),
    ChildRoute('/address', child: (_, args) => AddressPage()),
    ModuleRoute('/cards', module: CardsModule()),
    ChildRoute('/coupons', child: (_, args) => CouponPage()),
  ];
}
