// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'dart:collection';

mixin RegistrationRepository {
  Future<String?> register(HashMap values);
}
