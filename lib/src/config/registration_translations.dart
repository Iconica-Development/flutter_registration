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
    this.defaultEmailHint = 'iemand@voorbeeld.nl',
    this.defaultEmailEmpty = 'Geef uw e-mailadres op',
    this.defaultEmailValidatorMessage = 'Geef een geldig e-mailadres op',
    this.defaultPasswordTitle = 'Kies een wachtwoord',
    this.defaultPasswordHint = '',
    this.defaultPasswordValidatorMessage = 'Geef een wachtwoord op',
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
