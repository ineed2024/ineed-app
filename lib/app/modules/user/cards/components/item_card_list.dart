import 'package:Ineed/app/styles/app_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../domain/card/card_entity.dart';

class ItemCardList extends StatelessWidget {
  final CardEntity card;
  final Function()? onActionDelete;
  final bool invisibleTrailing;
  final Function(CardEntity) onTap;

  const ItemCardList(
      {Key? key,
      required this.card,
      required this.onActionDelete,
      required this.invisibleTrailing,
      required this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap != null
          ? () {
              onTap(card);
            }
          : null,
      leading: Icon(
        // FlutterIcons.creditcard_ant,
        Icons.card_giftcard,
        color: AppColorScheme.tagBlue2,
      ),
      title: Text('${card.cardNumber}'),
      trailing: !invisibleTrailing
          ? IconButton(
              icon: Icon(
                // FlutterIcons.trash_2_fea,
                Icons.abc,
                size: 42.h,
                color: AppColorScheme.feedbackDangerDark,
              ),
              onPressed: onActionDelete,
            )
          : null,
    );
  }
}
