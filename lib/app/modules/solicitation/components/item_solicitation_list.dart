import 'package:Ineed/app/styles/app_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Ineed/app/constants/solicitation_status.dart';

import '../../../../domain/entities/solicitation/solicitation_entity.dart';

class ItemSolicitationList extends StatelessWidget {
  const ItemSolicitationList({
    Key? key,
    required this.onTap,
    required this.solicitation,
  }) : super(key: key);

  final SolicitationEntity solicitation;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final category = solicitation.services!.first.categoryEntity;
    return Card(
      child: ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/icons-category/imagem/${category!.image}',
                  height: 100.h,
                  width: 100.w,
                ),
                Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: Text(
                              '${category.title}',
                              textAlign: TextAlign.start,
                              style: TextStyle(fontWeight: FontWeight.w600),
                            )),
                            ClipPath(
                                clipper: ShapeBorderClipper(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)))),
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      top: 2, bottom: 2, left: 5, right: 5),
                                  color: solicitation.status!.color,
                                  child: Text(
                                    solicitation.status!.valueOf,
                                    style: TextStyle(
                                        fontSize: 24.sp,
                                        color: AppColorScheme.white),
                                  ),
                                ))
                          ],
                        ),
                        // SizedBox(
                        //   height: 16.h,
                        // ),
                        // for (ServiceEntity service in solicitation.services)
                        //   Text(
                        //     '${service.title}',
                        //     textAlign: TextAlign.start,
                        //   )
                      ]),
                ),
              ],
            ),
            SizedBox(
              height: 30.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('COD: ${solicitation.id}'),
                Text(
                    '${solicitation.requestDate?.day.toString().padLeft(2, '0')}/${solicitation.requestDate?.month.toString().padLeft(2, '0')}/${solicitation.requestDate?.year}'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    '${solicitation.address}',
                    maxLines: 3,
                  ),
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  Text(
                      'Início: ${solicitation.initialDate?.hour.toString().padLeft(2, '0')}:${solicitation.initialDate?.minute.toString().padLeft(2, '0')}'),
                  Text(
                      'Fim: ${solicitation.finalDate?.hour.toString().padLeft(2, '0')}:${solicitation.finalDate?.minute.toString().padLeft(2, '0')}'),
                ]),
              ],
            ),
            if (solicitation.material!)
              Row(children: [
                Icon(
                  // FlutterIcons.check_ant,
                  Icons.check,
                  color: AppColorScheme.black,
                  size: 20,
                ),
                Text(
                  'Material Fornecido',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ]),
            if (solicitation.urgent!)
              Row(children: [
                Icon(
                  Icons.check,
                  color: AppColorScheme.black,
                  size: 20,
                ),
                Text(
                  'Urgente',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ])
          ],
        ),
        // trailing: Icon(FlutterIcons.right_ant,
        //     color: AppColorScheme.black),
        onTap: onTap,
      ),
    );
  }
}
