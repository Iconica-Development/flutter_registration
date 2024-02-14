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
    required this.defaultPassword1Title,
    required this.defaultPassword1Label,
    required this.defaultPassword1Hint,
    required this.defaultPassword1ValidatorMessage,
    required this.defaultPassword2Title,
    required this.defaultPassword2Label,
    required this.defaultPassword2Hint,
    required this.defaultPassword2ValidatorMessage,
  });

  const RegistrationTranslations.empty()
      : title = 'Register',
        registerBtn = 'Register',
        previousStepBtn = 'Previous',
        nextStepBtn = 'Next',
        closeBtn = 'Close',
        defaultEmailTitle = 'What is your email?',
        defaultEmailLabel = '',
        defaultEmailHint = 'john.doe@domain.com',
        defaultEmailEmpty = 'Enter your email',
        defaultEmailValidatorMessage = 'Enter a valid email address',
        defaultPassword1Title = 'Enter a password',
        defaultPassword1Label = '',
        defaultPassword1Hint = '',
        defaultPassword1ValidatorMessage = 'Enter a valid password',
        defaultPassword2Title = 'Re-enter password',
        defaultPassword2Label = '',
        defaultPassword2Hint = '',
        defaultPassword2ValidatorMessage = 'Passwords have to be equal';

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
  final String defaultPassword1Title;
  final String defaultPassword1Label;
  final String defaultPassword1Hint;
  final String defaultPassword1ValidatorMessage;
  final String defaultPassword2Title;
  final String defaultPassword2Label;
  final String defaultPassword2Hint;
  final String defaultPassword2ValidatorMessage;

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
    String? defaultPassword1Title,
    String? defaultPassword1Label,
    String? defaultPassword1Hint,
    String? defaultPassword1ValidatorMessage,
    String? defaultPassword2Title,
    String? defaultPassword2Label,
    String? defaultPassword2Hint,
    String? defaultPassword2ValidatorMessage,
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
      defaultPassword1Title:
          defaultPassword1Title ?? this.defaultPassword1Title,
      defaultPassword1Label:
          defaultPassword1Label ?? this.defaultPassword1Label,
      defaultPassword1Hint: defaultPassword1Hint ?? this.defaultPassword1Hint,
      defaultPassword1ValidatorMessage: defaultPassword1ValidatorMessage ??
          this.defaultPassword1ValidatorMessage,
      defaultPassword2Title:
          defaultPassword2Title ?? this.defaultPassword2Title,
      defaultPassword2Label:
          defaultPassword2Label ?? this.defaultPassword2Label,
      defaultPassword2Hint: defaultPassword2Hint ?? this.defaultPassword2Hint,
      defaultPassword2ValidatorMessage: defaultPassword2ValidatorMessage ??
          this.defaultPassword2ValidatorMessage,
    );
  }
}
