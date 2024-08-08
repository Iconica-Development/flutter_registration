// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import "dart:collection";

/// A mixin for a registration repository.
mixin RegistrationRepository {
  /// Registers a user with the given values.
  Future<String?> register(HashMap values);
}
