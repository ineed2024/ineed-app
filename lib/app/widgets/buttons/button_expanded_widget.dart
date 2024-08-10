import 'package:flutter/material.dart';

import '../../styles/app_color_scheme.dart';

class ButtonExpandedWidget extends StatelessWidget {
  const ButtonExpandedWidget({
    super.key,
    required this.descricao,
    this.funcao,
    this.corTexto,
  });

  final String descricao;
  final void Function()? funcao;
  final bool? corTexto;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColorScheme.primaryColor,
              padding: const EdgeInsets.all(12),
            ),
            onPressed: funcao,
            child: Text(
              descricao,
            ),
          ),
        ),
      ],
    );
  }
}
