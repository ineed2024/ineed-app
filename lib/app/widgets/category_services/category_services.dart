import 'package:Ineed/app/styles/app_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../domain/entities/service/service_entity.dart';

class CategoryServices extends StatelessWidget {
  final CrossAxisAlignment crossAxisAlignment;
  final String titleCategory;
  final List<ServiceEntity> list;

  const CategoryServices(
      {Key? key,
      this.crossAxisAlignment = CrossAxisAlignment.start,
      required this.titleCategory,
      required this.list})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(titleCategory,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 36.w,
              color: AppColorScheme.primaryColor,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w600,
            )),
        ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: list.length,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => Container(
            padding: const EdgeInsets.all(1),
            child: Text(list[index].title!,
                textAlign: crossAxisAlignment == CrossAxisAlignment.start
                    ? TextAlign.start
                    : TextAlign.center,
                style: TextStyle(fontSize: 20.w)),
          ),
        )
      ],
    );
  }
}
