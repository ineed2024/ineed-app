import 'package:Ineed/app/styles/app_color_scheme.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../domain/entities/service/category_entity.dart';

class CategoryItemGridView extends StatelessWidget {
  final CategoryEntity? categoryEntity;
  final Function()? onPressed;

  const CategoryItemGridView({Key? key, this.categoryEntity, this.onPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "${categoryEntity!.id}-${categoryEntity!.title}",
      child: Material(
        child: InkWell(
          onTap: () => onPressed!(),
          child: Container(
            child: Column(
              children: [
                Card(
                  elevation: 5,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    child: Image.asset(
                      'assets/images/icons-category/imagem/${categoryEntity!.image}',
                      height: 100.h,
                      width: 100.w,
                    ),
                  ),
                ),
                Flexible(
                  child: Text(categoryEntity!.title!,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: TextStyle(
                          fontSize: 20.h,
                          letterSpacing: 0.15.sp,
                          fontFamily: 'roboto',
                          fontStyle: FontStyle.normal,
                          color: AppColorScheme.black,
                          fontWeight: FontWeight.w400)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
