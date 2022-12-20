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
    this.defaultEmailHint = 'john.doe@domain.com',
    this.defaultEmailEmpty = 'Enter your email',
    this.defaultEmailValidatorMessage = 'Enter a valid email address',
    this.defaultPasswordTitle = 'Enter a password',
    this.defaultPasswordHint = '',
    this.defaultPasswordValidatorMessage = 'Enter a valid password',
  });

  final String title;
  final String registerBtn;
  final String previousStepBtn;
  final String nextStepBtn;
  final String closeBtn;
  final String defaultEmailTitle;
  final String defaultEmailHint;
  final String defaultEmailEmpty;
  final String defaultEmailValidatorMessage;
  final String defaultPasswordTitle;
  final String defaultPasswordHint;
  final String defaultPasswordValidatorMessage;
}
