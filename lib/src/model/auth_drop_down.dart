import 'package:flutter/material.dart';
import 'package:flutter_registration/flutter_registration.dart';

/// A field for capturing dropdown selections in a Flutter form.
///
/// Extends [AuthField].
class AuthDropdownField extends AuthField {
  /// Constructs an [AuthDropdownField] object.
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

  /// The list of items for the dropdown.
  final List<String> items;

  /// A callback function triggered when the dropdown value changes.
  final Function(String?) onChanged;

  /// The currently selected value in the dropdown.
  String? selectedValue;

  /// The decoration for the dropdown.
  final InputDecoration? dropdownDecoration;

  /// The padding around the dropdown.
  final EdgeInsets padding;

  /// The text style for the dropdown.
  final TextStyle? textStyle;

  /// The icon to be displayed with the dropdown.
  final Icon icon;

  @override
  Widget build(BuildContext context, Function onValueChanged) {
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
          onValueChanged();
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
