// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

class AuthException implements Exception {
  AuthException(this.message);
  final String message;

  @override
  String toString() {
    return message;
  }
}
