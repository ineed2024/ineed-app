import 'package:Ineed/app/widgets/inputs/dropdown_button_field.widget.dart';
import 'package:Ineed/domain/entities/dropdown/dropdown_item.dart';
import 'package:flutter/material.dart';

class TextAndDropdownHorizontal extends StatelessWidget {
  final String text;
  final List<DropdownItem> list;
  final bool? dropdownDisable;
  final Function(int?)? onChanged;
  final String? hintDropdown;
  final String? value;
  final bool? padding;

  const TextAndDropdownHorizontal(
      {Key? key,
      required this.text,
      required this.list,
      this.dropdownDisable = false,
      this.hintDropdown,
      this.value,
      this.onChanged,
      this.padding = true})
      : assert(dropdownDisable != null
            ? hintDropdown != null
            : hintDropdown == null || hintDropdown != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding != null
          ? const EdgeInsets.only(
              top: 10.0, bottom: 10.0, left: 16.0, right: 10.0)
          : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(text),
          DropdownButtonFieldWidget(
            contentPadding: false,
            hint: hintDropdown!,
            onChanged: dropdownDisable == null ? null : onChanged,
            list: list,
          ),
        ],
      ),
    );
  }
}
