// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:flutter/material.dart';

class AuthAction {
  AuthAction({
    required this.title,
    required this.onPress,
  });

  final String title;
  final VoidCallback onPress;
}
