// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_registration/flutter_registration.dart';
import 'package:flutter_registration/src/config/example_registration_repository.dart';

/// A set of options for configuring the registration process in a Flutter application.
class RegistrationOptions {
  RegistrationOptions({
    this.registrationRepository,
    this.registrationSteps,
    required this.afterRegistration,
    this.titleFlex,
    this.formFlex,
    this.beforeTitleFlex,
    this.afterTitleFlex,
    this.registrationTranslations = const RegistrationTranslations.empty(),
    this.onError,
    this.customAppbarBuilder = _createCustomAppBar,
    this.nextButtonBuilder,
    this.previousButtonBuilder,
    this.buttonMainAxisAlignment,
    this.backgroundColor,
    this.titleWidget,
    this.loginButton,
    this.maxFormWidth,
  }) {
    if (registrationSteps == null || registrationSteps!.isEmpty) {
      steps = RegistrationOptions.getDefaultSteps();
    } else {
      steps = registrationSteps!;
    }
    registrationRepository ??= ExampleRegistrationRepository();
  }

  /// Translations for registration-related messages and prompts.
  final RegistrationTranslations registrationTranslations;

  /// The steps involved in the registration process.
  final List<AuthStep>? registrationSteps;

  List<AuthStep> steps = [];

  /// A function that handles errors during registration.
  final int? Function(String error)? onError;

  /// A callback function executed after successful registration.
  final VoidCallback afterRegistration;

  /// The repository responsible for registration.
  RegistrationRepository? registrationRepository;

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
  final Widget? titleWidget;

  /// A custom widget for displaying a login button.
  final Widget? loginButton;

  /// The number of flex units for the title.
  final int? titleFlex;

  /// The number of flex units for the form.
  final int? formFlex;

  /// The number of flex units for the buttons.
  final int? beforeTitleFlex;

  /// The number of flex units for the buttons.
  final int? afterTitleFlex;

  /// The maximum width of the form. Defaults to 300.
  final double? maxFormWidth;

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
    TextEditingController? passController,
    bool passHidden = true,
    Function(bool mainPass, bool value)? passHideOnChange,
    RegistrationTranslations translations =
        const RegistrationTranslations.empty(),
    Function(String title)? titleBuilder,
    Function(String label)? labelBuilder,
    TextStyle? textStyle,
    String? initialEmail,
  }) {
    return [
      AuthStep(
        fields: [
          AuthTextField(
            name: 'email',
            textEditingController: emailController,
            value: initialEmail ?? '',
            title: titleBuilder?.call(translations.defaultEmailTitle) ??
                const Padding(
                  padding: EdgeInsets.only(top: 180),
                  child: Text(
                    'Enter your e-mail',
                    style: TextStyle(
                      color: Color(0xff71C6D1),
                      fontWeight: FontWeight.w800,
                      fontSize: 24,
                    ),
                  ),
                ),
            textFieldDecoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 8),
              label: labelBuilder?.call(translations.defaultEmailLabel),
              hintText: translations.defaultEmailHint,
              border: const OutlineInputBorder(),
            ),
            textStyle: textStyle,
            padding: const EdgeInsets.symmetric(vertical: 20),
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
          ),
        ],
      ),
      AuthStep(
        fields: [
          AuthPassField(
            name: 'password',
            textEditingController: passController,
            title: titleBuilder?.call(translations.defaultPasswordTitle) ??
                Padding(
                  padding: const EdgeInsets.only(top: 180),
                  child: Text(
                    translations.defaultPasswordTitle,
                    style: const TextStyle(
                      color: Color(0xff71C6D1),
                      fontWeight: FontWeight.w800,
                      fontSize: 24,
                    ),
                  ),
                ),
            textFieldDecoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 8),
              label: labelBuilder?.call(translations.defaultPasswordLabel),
              hintText: translations.defaultPasswordHint,
              border: const OutlineInputBorder(),
            ),
            padding: const EdgeInsets.symmetric(vertical: 20),
            textStyle: textStyle,
            validators: [
              (value) => (value == null || value.isEmpty)
                  ? translations.defaultPasswordValidatorMessage
                  : null,
            ],
          ),
        ],
      ),
    ];
  }
}

AppBar _createCustomAppBar(String title) {
  return AppBar(
    title: Text(title),
    backgroundColor: const Color(0xffFAF9F6),
  );
}
