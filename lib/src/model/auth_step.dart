// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import "package:flutter_registration/src/model/auth_field.dart";

/// A step in the authentication process.
class AuthStep {
  /// Constructs an [AuthStep] object.
  AuthStep({
    required this.fields,
  });

  /// The fields in the step.
  List<AuthField> fields;
}
