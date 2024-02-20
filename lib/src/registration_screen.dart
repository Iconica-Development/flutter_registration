import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_registration/flutter_registration.dart';
import 'package:flutter_registration/src/auth_screen.dart';

/// A screen for user registration.
class RegistrationScreen extends StatefulWidget {
  /// Constructs a [RegistrationScreen] object.
  ///
  /// [registrationOptions] specifies the registration options.
  const RegistrationScreen({
    required this.registrationOptions,
    Key? key,
  }) : super(key: key);

  /// The registration options.
  final RegistrationOptions registrationOptions;

  @override
  RegistrationScreenState createState() => RegistrationScreenState();
}

/// The state for [RegistrationScreen].
class RegistrationScreenState extends State<RegistrationScreen> {
  bool _isLoading = false;

  /// Registers the user.
  Future<void> _register({
    required HashMap<String, dynamic> values,
    required void Function(int? pageToReturn) onError,
  }) async {
    try {
      setState(() {
        _isLoading = true;
      });

      var registered = await widget.registrationOptions.registrationRepository
          .register(values);

      if (registered == null) {
        widget.registrationOptions.afterRegistration();
      } else {
        var pageToReturn = widget.registrationOptions.onError?.call(registered);

        onError(pageToReturn);
      }
    } catch (e) {
      onError(0);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var translations = widget.registrationOptions.registrationTranslations;

    return AuthScreen(
      steps: widget.registrationOptions.registrationSteps,
      customAppBar: widget.registrationOptions.customAppbarBuilder?.call(
        translations.title,
      ),
      onFinish: _register,
      appBarTitle: translations.title,
      submitBtnTitle: translations.registerBtn,
      nextBtnTitle: translations.nextStepBtn,
      previousBtnTitle: translations.previousStepBtn,
      nextButtonBuilder: widget.registrationOptions.nextButtonBuilder,
      previousButtonBuilder: widget.registrationOptions.previousButtonBuilder,
      buttonMainAxisAlignment:
          widget.registrationOptions.buttonMainAxisAlignment,
      customBackgroundColor: widget.registrationOptions.backgroundColor,
      titleWidget: widget.registrationOptions.titleWidget,
      loginButton: widget.registrationOptions.loginButton,
      isLoading: _isLoading,
    );
  }
}
