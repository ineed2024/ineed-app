import 'package:Ineed/app/styles/app_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../domain/entities/service/category_entity.dart';

class Header extends StatelessWidget {
  final CategoryEntity categoryEntity;

  Header({required this.categoryEntity});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Align(
        alignment: Alignment.bottomLeft,
        child: Material(
            color: AppColorScheme.primaryColor,
            elevation: 6,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)),
            child: Container(
              width: double.maxFinite,
              height: 70,
            )),
      ),
      Align(alignment: Alignment.topLeft, child: _buildHeaderCategory())
    ]);
  }

  _buildHeaderCategory() => Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Hero(
                tag: "${categoryEntity.id}-${categoryEntity.title}",
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Image.asset(
                    'assets/images/icons-category/imagem/${categoryEntity.image}',
                    height: 80,
                    width: 80,
                  ),
                ),
              ),
              SizedBox(
                width: 16.w,
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(categoryEntity.title!,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 36.w,
                          color: AppColorScheme.primaryColor,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w600,
                        )),
                    Text(
                      'Selecione o que você deseja solicitar',
                      maxLines: 2,
                      softWrap: true,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
}
