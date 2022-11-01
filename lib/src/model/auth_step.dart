// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:flutter_registration/src/model/auth_field.dart';

class AuthStep {
  AuthStep({
    required this.fields,
  });

  List<AuthField> fields;
}
