// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_registration/flutter_registration.dart';

/// A set of options for configuring the registration process in a Flutter application.
class RegistrationOptions {
  RegistrationOptions({
    required this.registrationRepository,
    required this.registrationSteps,
    required this.afterRegistration,
    this.titleFlex,
    this.formFlex,
    this.beforeTitleFlex,
    this.afterTitleFlex,
    this.registrationTranslations = const RegistrationTranslations.empty(),
    this.onError,
    this.customAppbarBuilder,
    this.nextButtonBuilder,
    this.previousButtonBuilder,
    this.buttonMainAxisAlignment,
    this.backgroundColor,
    this.titleWidget,
    this.loginButton,
  });

  /// Translations for registration-related messages and prompts.
  final RegistrationTranslations registrationTranslations;

  /// The steps involved in the registration process.
  final List<AuthStep> registrationSteps;

  /// A function that handles errors during registration.
  final int? Function(String error)? onError;

  /// A callback function executed after successful registration.
  final VoidCallback afterRegistration;

  /// The repository responsible for registration.
  final RegistrationRepository registrationRepository;

  /// A function for customizing the app bar displayed during registration.
  final AppBar Function(String title)? customAppbarBuilder;

  /// A function for customizing the "Next" button.
  final Widget Function(Future<void> Function()? onPressed, String label,
      int step, bool enabled)? nextButtonBuilder;

  /// A function for customizing the "Previous" button.
  final Widget? Function(VoidCallback onPressed, String label, int step)?
      previousButtonBuilder;

  /// Specifies the alignment of buttons.
  final MainAxisAlignment? buttonMainAxisAlignment;

  /// The background color of the registration screen.
  final Color? backgroundColor;

  /// A custom widget for displaying the registration title.
  Widget? titleWidget;

  /// A custom widget for displaying a login button.
  Widget? loginButton;

  /// The number of flex units for the title.
  final int? titleFlex;

  /// The number of flex units for the form.
  final int? formFlex;

  /// The number of flex units for the buttons.
  final int? beforeTitleFlex;

  /// The number of flex units for the buttons.
  final int? afterTitleFlex;

  /// Generates default registration steps.
  ///
  /// [emailController] controller for email input.
  ///
  /// [pass1Controller] controller for first password input.
  ///
  /// [pass1Hidden] whether the first password field is initially hidden.
  ///
  /// [pass2Controller] controller for second password input.
  ///
  /// [pass2Hidden] whether the second password field is initially hidden.
  ///
  /// [passHideOnChange] function triggered when password visibility changes.
  ///
  /// [translations] translations for default registration messages and prompts.
  ///
  /// [titleBuilder] function for customizing step titles.
  ///
  /// [labelBuilder] function for customizing field labels.
  ///
  /// [textStyle] text style for input fields.
  ///
  /// [initialEmail] initial value for email input.
  static List<AuthStep> getDefaultSteps({
    TextEditingController? emailController,
    TextEditingController? pass1Controller,
    bool pass1Hidden = true,
    TextEditingController? pass2Controller,
    bool pass2Hidden = true,
    Function(bool mainPass, bool value)? passHideOnChange,
    RegistrationTranslations translations =
        const RegistrationTranslations.empty(),
    Function(String title)? titleBuilder,
    Function(String label)? labelBuilder,
    TextStyle? textStyle,
    String? initialEmail,
  }) {
    var password1 = '';

    return [
      AuthStep(
        fields: [
          AuthTextField(
            name: 'email',
            textEditingController: emailController,
            value: initialEmail ?? '',
            title: titleBuilder?.call(translations.defaultEmailTitle) ??
                Padding(
                  padding: const EdgeInsets.only(top: 24.0, bottom: 12.0),
                  child: Text(
                    translations.defaultEmailTitle,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
            textFieldDecoration: InputDecoration(
              label: labelBuilder?.call(translations.defaultEmailLabel),
              hintText: translations.defaultEmailHint,
            ),
            textStyle: textStyle,
            validators: [
              (email) => (email == null || email.isEmpty)
                  ? translations.defaultEmailEmpty
                  : null,
              (email) =>
                  RegExp(r"""(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])""")
                          .hasMatch(email!)
                      ? null
                      : translations.defaultEmailValidatorMessage,
            ],
          )
        ],
      ),
      AuthStep(
        fields: [
          AuthPassField(
            name: 'password1',
            textEditingController: pass1Controller,
            title: titleBuilder?.call(translations.defaultPassword1Title) ??
                Padding(
                  padding: const EdgeInsets.only(top: 24.0, bottom: 12.0),
                  child: Text(
                    translations.defaultPassword1Title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
            textFieldDecoration: InputDecoration(
              label: labelBuilder?.call(translations.defaultPassword1Label),
              hintText: translations.defaultPassword1Hint,
            ),
            textStyle: textStyle,
            validators: [
              (value) => (value == null || value.isEmpty)
                  ? translations.defaultPassword1ValidatorMessage
                  : null,
            ],
            onChange: (value) {
              password1 = value;
            },
          ),
          AuthPassField(
            name: 'password2',
            textEditingController: pass2Controller,
            title: titleBuilder?.call(translations.defaultPassword2Title) ??
                Padding(
                  padding: const EdgeInsets.only(top: 24.0, bottom: 12.0),
                  child: Text(
                    translations.defaultPassword2Title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
            textFieldDecoration: InputDecoration(
              label: labelBuilder?.call(translations.defaultPassword2Label),
              hintText: translations.defaultPassword2Hint,
            ),
            textStyle: textStyle,
            validators: [
              (value) {
                if (pass1Controller != null) {
                  if (value != pass1Controller.value.text) {
                    return translations.defaultPassword2ValidatorMessage;
                  }
                } else {
                  if (value != password1) {
                    return translations.defaultPassword2ValidatorMessage;
                  }
                }
                return null;
              }
            ],
          ),
        ],
      ),
    ];
  }
}
