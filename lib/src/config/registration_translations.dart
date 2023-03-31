// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

class RegistrationTranslations {
  const RegistrationTranslations({
    this.title = 'Register',
    this.registerBtn = 'Register',
    this.previousStepBtn = 'Previous',
    this.nextStepBtn = 'Next',
    this.closeBtn = 'Close',
    this.defaultEmailTitle = 'What is your email?',
    this.defaultEmailLabel = '',
    this.defaultEmailHint = 'john.doe@domain.com',
    this.defaultEmailEmpty = 'Enter your email',
    this.defaultEmailValidatorMessage = 'Enter a valid email address',
    this.defaultPassword1Title = 'Enter a password',
    this.defaultPassword1Label = '',
    this.defaultPassword1Hint = '',
    this.defaultPassword1ValidatorMessage = 'Enter a valid password',
    this.defaultPassword2Title = 'Re-enter password',
    this.defaultPassword2Label = '',
    this.defaultPassword2Hint = '',
    this.defaultPassword2ValidatorMessage = 'Passwords have to be equal',
  });

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
}
