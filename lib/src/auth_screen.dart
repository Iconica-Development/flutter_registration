// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import "dart:async";
import "dart:collection";
import "package:flutter/material.dart";
import "package:flutter_registration/flutter_registration.dart";

/// A widget for handling multi-step authentication processes.
class AuthScreen extends StatefulWidget {
  /// Constructs an [AuthScreen] object.
  ///
  /// [appBarTitle] specifies the title of the app bar.
  ///
  /// [onFinish] is a function called upon
  /// completion of the authentication process.
  ///
  /// [steps] is a list of authentication steps to be completed.
  ///
  /// [submitBtnTitle] specifies the title of the submit button.
  ///
  /// [nextBtnTitle] specifies the title of the next button.
  ///
  /// [previousBtnTitle] specifies the title of the previous button.
  ///
  /// [customAppBar] allows customization of the app bar.
  ///
  /// [buttonMainAxisAlignment] specifies the alignment of the buttons.
  ///
  /// [customBackgroundColor] allows customization of the background color.
  ///
  /// [nextButtonBuilder] allows customization of the next button.
  ///
  /// [previousButtonBuilder] allows customization of the previous button.
  ///
  /// [titleWidget] specifies a custom widget
  /// to be displayed at the top of the screen.
  ///
  /// [loginButton] specifies a custom login button widget.
  ///
  /// [titleFlex] specifies the flex value for the title widget.
  ///
  /// [formFlex] specifies the flex value for the form widget.
  ///
  /// [beforeTitleFlex] specifies the flex value before the title widget.
  ///
  /// [afterTitleFlex] specifies the flex value after the title widget.

  const AuthScreen({
    required this.appBarTitle,
    required this.steps,
    required this.submitBtnTitle,
    required this.nextBtnTitle,
    required this.previousBtnTitle,
    required this.onFinish,
    this.customAppBar,
    this.buttonMainAxisAlignment,
    this.customBackgroundColor,
    this.nextButtonBuilder,
    this.previousButtonBuilder,
    this.titleWidget,
    this.loginButton,
    this.titleFlex,
    this.formFlex,
    this.beforeTitleFlex,
    this.afterTitleFlex,
    this.maxFormWidth,
    super.key,
  }) : assert(steps.length > 0, "At least one step is required");

  /// The title of the app bar.
  final String appBarTitle;

  /// A function called upon completion of the authentication process.
  final Future<void> Function({
    required HashMap<String, dynamic> values,
    required void Function(int? pageToReturn) onError,
  }) onFinish;

  /// The authentication steps to be completed.
  final List<AuthStep> steps;

  /// The title of the submit button.
  final String submitBtnTitle;

  /// The title of the next button.
  final String nextBtnTitle;

  /// The title of the previous button.
  final String previousBtnTitle;

  /// A custom app bar widget.
  final AppBar? customAppBar;

  /// The alignment of the buttons.
  final MainAxisAlignment? buttonMainAxisAlignment;

  /// The background color of the screen.
  final Color? customBackgroundColor;

  /// A custom widget for the button.
  final Widget Function(
    Future<void> Function()? onPressed,
    String label,
    int step,
    // ignore: avoid_positional_boolean_parameters
    bool enabled,
  )? nextButtonBuilder;

  /// A custom widget for the button.
  final Widget? Function(VoidCallback onPressed, String label, int step)?
      previousButtonBuilder;

  /// A custom widget for the title.
  final Widget? titleWidget;

  /// A custom widget for the login button.
  final Widget? loginButton;

  /// The flex value for the title widget.
  final int? titleFlex;

  /// The flex value for the form widget.
  final int? formFlex;

  /// The flex value before the title widget.
  final int? beforeTitleFlex;

  /// The flex value after the title widget.
  final int? afterTitleFlex;

  /// The maximum width of the form.
  final double? maxFormWidth;

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

/// The state for [AuthScreen].
class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final _pageController = PageController();
  final _animationDuration = const Duration(milliseconds: 300);
  final _animationCurve = Curves.ease;
  bool _formValid = false;

  /// Gets the app bar.
  AppBar get _appBar =>
      widget.customAppBar ??
      AppBar(
        backgroundColor: const Color(0xffFAF9F6),
        title: Text(widget.appBarTitle),
      );

  /// Handles previous button press.
  void onPrevious() {
    FocusScope.of(context).unfocus();
    _validate(_pageController.page!.toInt() - 1);
    unawaited(
      _pageController.previousPage(
        duration: _animationDuration,
        curve: _animationCurve,
      ),
    );
  }

  /// Handles next button press.
  Future<void> onNext(AuthStep step) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();

    FocusScope.of(context).unfocus();

    if (widget.steps.last == step) {
      var values = HashMap<String, dynamic>();

      for (var step in widget.steps) {
        for (var field in step.fields) {
          values[field.name] = field.value;
        }
      }

      await widget.onFinish(
        values: values,
        onError: (int? pageToReturn) {
          if (pageToReturn == null) {
            return;
          }
          _pageController.animateToPage(
            pageToReturn,
            duration: _animationDuration,
            curve: _animationCurve,
          );
        },
      );

      return;
    } else {
      _validate(_pageController.page!.toInt() + 1);
      unawaited(
        _pageController.nextPage(
          duration: _animationDuration,
          curve: _animationCurve,
        ),
      );
    }
  }

  /// Validates the current step.
  void _validate(int currentPage) {
    var isStepValid = true;

    // Loop through each field in the current step
    for (var field in widget.steps[currentPage].fields) {
      for (var validator in field.validators) {
        var validationResult = validator(field.value);
        if (validationResult != null) {
          // If any validator returns an error, mark step as invalid and break
          isStepValid = false;
          break;
        }
      }
      if (!isStepValid) {
        break; // No need to check further fields if one is already invalid
      }
    }

    setState(() {
      _formValid = isStepValid;
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: widget.customBackgroundColor ?? const Color(0xffFAF9F6),
      appBar: _appBar,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _pageController,
            children: <Widget>[
              for (var currentStep = 0;
                  currentStep < widget.steps.length;
                  currentStep++)
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (widget.titleWidget != null) ...[
                      Expanded(
                        flex: widget.titleFlex ?? 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              flex: widget.beforeTitleFlex ?? 2,
                              child: Container(),
                            ),
                            widget.titleWidget!,
                            Expanded(
                              flex: widget.afterTitleFlex ?? 2,
                              child: Container(),
                            ),
                          ],
                        ),
                      ),
                    ],
                    Expanded(
                      flex: widget.formFlex ?? 3,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: widget.maxFormWidth ?? 300,
                          ),
                          child: Column(
                            children: [
                              for (AuthField field
                                  in widget.steps[currentStep].fields) ...[
                                if (field.title != null) ...[
                                  wrapWithDefaultStyle(
                                    style: theme.textTheme.headlineLarge!,
                                    widget: field.title!,
                                  ),
                                ],
                                field.build(context, () {
                                  _validate(currentStep);
                                }),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            child: Row(
                              mainAxisAlignment: widget.steps.first !=
                                      widget.steps[currentStep]
                                  ? MainAxisAlignment.spaceBetween
                                  : MainAxisAlignment.end,
                              children: [
                                if (widget.steps.first !=
                                    widget.steps[currentStep]) ...[
                                  widget.previousButtonBuilder?.call(
                                        onPrevious,
                                        widget.previousBtnTitle,
                                        currentStep,
                                      ) ??
                                      _stepButton(
                                        buttonText: widget.previousBtnTitle,
                                        onTap: () async => onPrevious(),
                                      ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                ],
                                widget.nextButtonBuilder?.call(
                                      !_formValid
                                          ? null
                                          : () async {
                                              await onNext(
                                                widget.steps[currentStep],
                                              );
                                            },
                                      widget.steps.last ==
                                              widget.steps[currentStep]
                                          ? widget.submitBtnTitle
                                          : widget.nextBtnTitle,
                                      currentStep,
                                      _formValid,
                                    ) ??
                                    _stepButton(
                                      buttonText: widget.steps.last ==
                                              widget.steps[currentStep]
                                          ? widget.submitBtnTitle
                                          : widget.nextBtnTitle,
                                      onTap: () async {
                                        await onNext(
                                          widget.steps[currentStep],
                                        );
                                      },
                                    ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        if (widget.loginButton != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: widget.loginButton,
                          ),
                      ],
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _stepButton({
    required String buttonText,
    required Future Function()? onTap,
  }) {
    var theme = Theme.of(context);
    return Flexible(
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          constraints: const BoxConstraints(
            maxWidth: 180,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color(
                0xff979797,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Text(
              buttonText,
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  Widget wrapWithDefaultStyle({
    required Widget widget,
    required TextStyle style,
  }) =>
      DefaultTextStyle(style: style, child: widget);
}
