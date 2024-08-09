// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_registration/flutter_registration.dart";
import "package:flutter_registration/src/config/example_registration_repository.dart";

/// A set of options for configuring the
/// registration process in a Flutter application.
class RegistrationOptions {
  /// Registration options Constructor
  RegistrationOptions({
    required this.afterRegistration,
    this.registrationRepository,
    this.registrationSteps,
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
    this.beforeRegistration,
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

  /// The steps involved in the registration process.
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
  final Widget Function(
    Future<void> Function()? onPressed,
    String label,
    int step,
    // ignore: avoid_positional_boolean_parameters
    bool enabled,
  )? nextButtonBuilder;

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

  /// This function gets called before the user gets registered.
  final Future<void> Function()? beforeRegistration;

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
    // ignore: avoid_positional_boolean_parameters
    Function(bool mainPass, bool value)? passHideOnChange,
    RegistrationTranslations translations =
        const RegistrationTranslations.empty(),
    Function(String title)? titleBuilder,
    Function(String label)? labelBuilder,
    TextStyle? textStyle,
    TextStyle? hintStyle,
    String? initialEmail,
  }) =>
      [
        AuthStep(
          fields: [
            AuthTextField(
              name: "email",
              textEditingController: emailController,
              value: initialEmail ?? "",
              title: titleBuilder?.call(translations.defaultEmailTitle) ??
                  Padding(
                    padding: const EdgeInsets.only(top: 180),
                    child: Text(
                      translations.defaultEmailTitle,
                    ),
                  ),
              textInputType: TextInputType.emailAddress,
              textFieldDecoration: InputDecoration(
                hintStyle: hintStyle,
                contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                label: labelBuilder?.call(translations.defaultEmailLabel),
                hintText: translations.defaultEmailHint,
                border: const OutlineInputBorder(),
                focusedBorder: const OutlineInputBorder(),
              ),
              textStyle: textStyle,
              padding: const EdgeInsets.symmetric(vertical: 20),
              validators: [
                // ignore: avoid_dynamic_calls
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
              name: "password",
              textEditingController: passController,
              title: titleBuilder?.call(translations.defaultPasswordTitle) ??
                  Padding(
                    padding: const EdgeInsets.only(top: 180),
                    child: Text(
                      translations.defaultPasswordTitle,
                    ),
                  ),
              textFieldDecoration: InputDecoration(
                hintStyle: hintStyle,
                contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                label: labelBuilder?.call(translations.defaultPasswordLabel),
                hintText: translations.defaultPasswordHint,
                border: const OutlineInputBorder(),
                focusedBorder: const OutlineInputBorder(),
              ),
              padding: const EdgeInsets.symmetric(vertical: 20),
              textStyle: textStyle,
              validators: [
                (value) {
                  // ignore: avoid_dynamic_calls
                  if (value == null || value.isEmpty) {
                    return translations.defaultPasswordValidatorMessage;
                  }
                  // ignore: avoid_dynamic_calls
                  if (value.length < 6) {
                    return translations.defaultPasswordToShortValidatorMessage;
                  }
                  return null;
                },
              ],
            ),
          ],
        ),
      ];
}

AppBar _createCustomAppBar(String title) => AppBar(
      iconTheme: const IconThemeData(color: Colors.black, size: 16),
      title: Text(title),
      backgroundColor: Colors.transparent,
    );
