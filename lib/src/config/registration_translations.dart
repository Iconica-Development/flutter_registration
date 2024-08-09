// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

/// Holds all the translations for the standard elements
/// on the registration screen.
class RegistrationTranslations {
  /// Constructs a [RegistrationTranslations] object.
  const RegistrationTranslations({
    required this.title,
    required this.registerBtn,
    required this.previousStepBtn,
    required this.nextStepBtn,
    required this.closeBtn,
    required this.defaultEmailTitle,
    required this.defaultEmailLabel,
    required this.defaultEmailHint,
    required this.defaultEmailEmpty,
    required this.defaultEmailValidatorMessage,
    required this.defaultPasswordTitle,
    required this.defaultPasswordLabel,
    required this.defaultPasswordHint,
    required this.defaultPasswordValidatorMessage,
    required this.defaultPasswordToShortValidatorMessage,
  });

  /// Constructs a [RegistrationTranslations] object with empty strings.
  const RegistrationTranslations.empty()
      : title = "",
        registerBtn = "Register",
        previousStepBtn = "Previous",
        nextStepBtn = "Next",
        closeBtn = "Close",
        defaultEmailTitle = "enter your email address",
        defaultEmailLabel = "",
        defaultEmailHint = "Email address",
        defaultEmailEmpty = "Please enter your email address.",
        defaultEmailValidatorMessage = "Please enter a valid email address.",
        defaultPasswordTitle = "choose a password",
        defaultPasswordLabel = "",
        defaultPasswordHint = "Password",
        defaultPasswordValidatorMessage = "Enter a valid password",
        defaultPasswordToShortValidatorMessage =
            "Password needs to be at least 6 characters long";

  /// The title of the registration screen.
  final String title;

  /// The text for the registration button.
  final String registerBtn;

  /// The text for the previous step button.
  final String previousStepBtn;

  /// The text for the next step button.
  final String nextStepBtn;

  /// The text for the close button.
  final String closeBtn;

  /// The title for the default email field.
  final String defaultEmailTitle;

  /// The label for the default email field.
  final String defaultEmailLabel;

  /// The hint for the default email field.
  final String defaultEmailHint;

  /// The message for an empty default email field.
  final String defaultEmailEmpty;

  /// The message for an invalid default email field.
  final String defaultEmailValidatorMessage;

  /// The title for the default password field.
  final String defaultPasswordTitle;

  /// The label for the default password field.
  final String defaultPasswordLabel;

  /// The hint for the default password field.
  final String defaultPasswordHint;

  /// The message for an invalid default password field.
  final String defaultPasswordValidatorMessage;

  /// The message for a default password that is too short.
  final String defaultPasswordToShortValidatorMessage;

  /// create a copywith
  RegistrationTranslations copyWith({
    String? title,
    String? registerBtn,
    String? previousStepBtn,
    String? nextStepBtn,
    String? closeBtn,
    String? defaultEmailTitle,
    String? defaultEmailLabel,
    String? defaultEmailHint,
    String? defaultEmailEmpty,
    String? defaultEmailValidatorMessage,
    String? defaultPasswordTitle,
    String? defaultPasswordLabel,
    String? defaultPasswordHint,
    String? defaultPasswordValidatorMessage,
    String? defaultPasswordToShortValidatorMessage,
  }) =>
      RegistrationTranslations(
        title: title ?? this.title,
        registerBtn: registerBtn ?? this.registerBtn,
        previousStepBtn: previousStepBtn ?? this.previousStepBtn,
        nextStepBtn: nextStepBtn ?? this.nextStepBtn,
        closeBtn: closeBtn ?? this.closeBtn,
        defaultEmailTitle: defaultEmailTitle ?? this.defaultEmailTitle,
        defaultEmailLabel: defaultEmailLabel ?? this.defaultEmailLabel,
        defaultEmailHint: defaultEmailHint ?? this.defaultEmailHint,
        defaultEmailEmpty: defaultEmailEmpty ?? this.defaultEmailEmpty,
        defaultEmailValidatorMessage:
            defaultEmailValidatorMessage ?? this.defaultEmailValidatorMessage,
        defaultPasswordTitle: defaultPasswordTitle ?? this.defaultPasswordTitle,
        defaultPasswordLabel: defaultPasswordLabel ?? this.defaultPasswordLabel,
        defaultPasswordHint: defaultPasswordHint ?? this.defaultPasswordHint,
        defaultPasswordValidatorMessage: defaultPasswordValidatorMessage ??
            this.defaultPasswordValidatorMessage,
        defaultPasswordToShortValidatorMessage:
            defaultPasswordToShortValidatorMessage ??
                this.defaultPasswordToShortValidatorMessage,
      );
}
