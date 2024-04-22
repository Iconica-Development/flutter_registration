// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'dart:async';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_registration/flutter_registration.dart';

/// A widget for handling multi-step authentication processes.
class AuthScreen extends StatefulWidget {
  /// Constructs an [AuthScreen] object.
  ///
  /// [appBarTitle] specifies the title of the app bar.
  ///
  /// [onFinish] is a function called upon completion of the authentication process.
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
  /// [titleWidget] specifies a custom widget to be displayed at the top of the screen.
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
  ///
  /// [isLoading] indicates whether the screen is in a loading state.
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
    this.isLoading = false,
    this.maxFormWidth,
    Key? key,
  })  : assert(steps.length > 0, 'At least one step is required'),
        super(key: key);

  final String appBarTitle;
  final Future<void> Function({
    required HashMap<String, dynamic> values,
    required void Function(int? pageToReturn) onError,
  }) onFinish;
  final List<AuthStep> steps;
  final String submitBtnTitle;
  final String nextBtnTitle;
  final String previousBtnTitle;
  final AppBar? customAppBar;
  final MainAxisAlignment? buttonMainAxisAlignment;
  final Color? customBackgroundColor;
  final Widget Function(Future<void> Function()? onPressed, String label,
      int step, bool enabled)? nextButtonBuilder;
  final Widget? Function(VoidCallback onPressed, String label, int step)?
      previousButtonBuilder;
  final Widget? titleWidget;
  final Widget? loginButton;
  final int? titleFlex;
  final int? formFlex;
  final int? beforeTitleFlex;
  final int? afterTitleFlex;
  final bool isLoading;
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
    _pageController.previousPage(
      duration: _animationDuration,
      curve: _animationCurve,
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
        onError: (int? pageToReturn) => _pageController.animateToPage(
          pageToReturn ?? 0,
          duration: _animationDuration,
          curve: _animationCurve,
        ),
      );

      return;
    } else {
      _validate(_pageController.page!.toInt() + 1);
      _pageController.nextPage(
        duration: _animationDuration,
        curve: _animationCurve,
      );
    }
  }

  /// Validates the current step.
  void _validate(int currentPage) {
    bool isStepValid = true;

    // Loop through each field in the current step
    for (var field in widget.steps[currentPage].fields) {
      for (var validator in field.validators) {
        String? validationResult = validator(field.value);
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
    return widget.isLoading
        ? const Center(
            child: SizedBox(
              height: 120,
              width: 120,
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            backgroundColor:
                widget.customBackgroundColor ?? const Color(0xffFAF9F6),
            appBar: _appBar,
            body: SafeArea(
              child: Form(
                key: _formKey,
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _pageController,
                  children: <Widget>[
                    for (var i = 0; i < widget.steps.length; i++)
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
                                        in widget.steps[i].fields) ...[
                                      if (field.title != null) ...[
                                        field.title!,
                                      ],
                                      field.build(context, () {
                                        _validate(i);
                                      })
                                    ]
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: widget
                                            .buttonMainAxisAlignment !=
                                        null
                                    ? widget.buttonMainAxisAlignment!
                                    : (widget.previousButtonBuilder != null &&
                                            widget.previousButtonBuilder?.call(
                                                  onPrevious,
                                                  widget.previousBtnTitle,
                                                  i,
                                                ) ==
                                                null)
                                        ? MainAxisAlignment.start
                                        : widget.steps.first != widget.steps[i]
                                            ? MainAxisAlignment.center
                                            : MainAxisAlignment.end,
                                children: [
                                  if (widget.previousButtonBuilder == null) ...[
                                    if (widget.steps.first != widget.steps[i])
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 16, bottom: 10, right: 8),
                                        child: InkWell(
                                          onTap: onPrevious,
                                          child: Container(
                                            width: 180,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              border: Border.all(
                                                color: const Color(
                                                  0xff979797,
                                                ),
                                              ),
                                            ),
                                            child: Center(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 2.0),
                                                child: Text(
                                                  widget.previousBtnTitle,
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                  ] else if (widget.previousButtonBuilder?.call(
                                          onPrevious,
                                          widget.previousBtnTitle,
                                          i) !=
                                      null) ...[
                                    widget.previousButtonBuilder!.call(
                                        onPrevious, widget.previousBtnTitle, i)!
                                  ],
                                  widget.nextButtonBuilder?.call(
                                        !_formValid
                                            ? null
                                            : () async {
                                                await onNext(widget.steps[i]);
                                              },
                                        widget.steps.last == widget.steps[i]
                                            ? widget.submitBtnTitle
                                            : widget.nextBtnTitle,
                                        i,
                                        _formValid,
                                      ) ??
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 16, bottom: 10, left: 8),
                                        child: InkWell(
                                          onTap: !_formValid
                                              ? null
                                              : () async {
                                                  await onNext(widget.steps[i]);
                                                },
                                          child: Container(
                                            width: 180,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              border: Border.all(
                                                color: const Color(
                                                  0xff979797,
                                                ),
                                              ),
                                            ),
                                            child: Center(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 2.0),
                                                child: Text(
                                                  widget.steps.last ==
                                                          widget.steps[i]
                                                      ? widget.submitBtnTitle
                                                      : widget.nextBtnTitle,
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                ],
                              ),
                              if (widget.loginButton != null)
                                Padding(
                                  padding: const EdgeInsets.only(top: 20.0),
                                  child: widget.loginButton!,
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
}
