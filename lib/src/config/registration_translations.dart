// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

class RegistrationTranslations {
  const RegistrationTranslations({
    this.title = 'Registreren',
    this.registerBtn = 'Registreren',
    this.previousStepBtn = 'Vorige stap',
    this.nextStepBtn = 'Volgende stap',
    this.closeBtn = 'Sluiten',
    this.defaultEmailTitle = 'Wat is je e-mailadres?',
    this.defaultEmailLabel = '',
    this.defaultEmailHint = 'iemand@voorbeeld.nl',
    this.defaultEmailEmpty = 'Geef uw e-mailadres op',
    this.defaultEmailValidatorMessage = 'Geef een geldig e-mailadres op',
    this.defaultPassword1Title = 'Kies een wachtwoord',
    this.defaultPassword1Label = '',
    this.defaultPassword1Hint = '',
    this.defaultPassword1ValidatorMessage = 'Geef een wachtwoord op',
    this.defaultPassword2Label = '',
    this.defaultPassword2Hint = '',
    this.defaultPassword2ValidatorMessage = 'Wachtwoorden moeten gelijk zijn',
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
  final String defaultPassword2Label;
  final String defaultPassword2Hint;
  final String defaultPassword2ValidatorMessage;
}
