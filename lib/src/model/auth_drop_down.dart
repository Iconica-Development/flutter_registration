import 'package:flutter/material.dart';
import 'package:flutter_registration/flutter_registration.dart';

class AuthDropdownField extends AuthField {
  AuthDropdownField({
    required super.name,
    required this.items,
    required this.onChanged,
    this.dropdownDecoration,
    this.padding = const EdgeInsets.all(8.0),
    this.textStyle,
    this.icon = const Icon(Icons.keyboard_arrow_down),
    required super.value,
  }) {
    selectedValue = value ?? items.first;
  }

  final List<String> items;
  final Function(String?) onChanged;
  String? selectedValue;
  final InputDecoration? dropdownDecoration;
  final EdgeInsets padding;
  final TextStyle? textStyle;
  final Icon icon;

  @override
  Widget build() {
    return Padding(
      padding: padding,
      child: DropdownButtonFormField<String>(
        icon: icon,
        style: textStyle,
        value: selectedValue,
        decoration: dropdownDecoration,
        items: items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (newValue) {
          selectedValue = newValue;
          onChanged(newValue);
        },
        validator: (value) {
          if (validators.isNotEmpty) {
            for (var validator in validators) {
              var output = validator(value);
              if (output != null) {
                return output;
              }
            }
          }
          return null;
        },
      ),
    );
  }
}
