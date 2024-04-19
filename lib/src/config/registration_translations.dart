// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

/// Holds all the translations for the standard elements on the registration screen.
class RegistrationTranslations {
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
  });

  const RegistrationTranslations.empty()
      : title = '',
        registerBtn = 'Register',
        previousStepBtn = 'Previous',
        nextStepBtn = 'Next',
        closeBtn = 'Close',
        defaultEmailTitle = 'What is your email?',
        defaultEmailLabel = '',
        defaultEmailHint = 'Email address',
        defaultEmailEmpty = 'Please enter your email address.',
        defaultEmailValidatorMessage = 'Please enter a valid email address.',
        defaultPasswordTitle = 'Choose a password',
        defaultPasswordLabel = 'password',
        defaultPasswordHint = '',
        defaultPasswordValidatorMessage = 'Enter a valid password';

  final String title;
  final String registerBtn;
  final String previousStepBtn;
  final String nextStepBtn;
  final String closeBtn;
  final String defaultEmailTitle;
  final String defaultEmailLabel;
  final String defaultEmailHint;
  final String defaultEmailEmpty;
  final String defaultEmailValidatorMessage;
  final String defaultPasswordTitle;
  final String defaultPasswordLabel;
  final String defaultPasswordHint;
  final String defaultPasswordValidatorMessage;

  // create a copywith
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
  }) {
    return RegistrationTranslations(
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
    );
  }
}
