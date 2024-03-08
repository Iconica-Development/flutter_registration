<!--
SPDX-FileCopyrightText: 2022 Iconica

SPDX-License-Identifier: GPL-3.0-or-later
-->

# 2.0.2

- fix: authfields not showing and not being able to set space between widgets

# 2.0.1

- feat: added circular progress indicator while awaiting registration of user
- feat: added alignment option for buttons

# 2.0.0

- feat(buttons): Added the possiblity to only have a next button by return zero on the previous button builder
- feat: exposed input decoration in AuthTextField
- feat: added title widget and login button builder
- feat(bool): Add a boolean field. Can be used for accepting terms and conditions
- feat(pass): Add dedicated password screen that manages state internally
- fix: Small refactor and brought back the normal alignment for the screens
- fix: Fixed alignment and spacing when opening keyboard
- feat: add auth drop down field
- fix: added step to button builders
- fix: exported auth_pass_field
- feat: added validation to disable next button
- feat(auth-screen): add flexible spacing between fields
- fix(keyboard-focus): add unfocus for onPrevious
- fix: add empty and required constructors for the RegistrationTranslations

# 1.2.0

- feat: Added the ability to have an async register function so you can call it asynchronous.

# 1.1.0

- feat: Added the ability to go to specific page on error

# 1.0.0

- feat: Added an onError function.
- feat: Register function in RegistrationRepository can now return a nullable string. Works like a validator.

# 0.5.0

- feat: add customBackgroundColor to AuthScreen
- fix: fix linter
- fix: fix translations to English

# 0.4.0

- feat: Added the abilty to show and hide the passwords

## 0.3.0

- Added the abilty to set an initial value fot the default email field

## 0.2.0

- Added the abilty to add labels
- The default password step now includes two textfields

## 0.0.2

- Firebase integration
- Registration capabilities

## 0.0.1

- Initial version
