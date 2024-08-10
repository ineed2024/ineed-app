import 'package:flutter/material.dart';

import '../../styles/app_color_scheme.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({Key? key, this.descricao}) : super(key: key);
  final String? descricao;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.subtitles_off,
          size: 60,
          color: Colors.grey,
        ),
        const SizedBox(
          height: 30,
        ),
        Text(
          descricao!,
          style: const TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}
