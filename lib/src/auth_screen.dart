// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'dart:async';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_registration/flutter_registration.dart';

class AuthScreen extends StatefulWidget {
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
    super.key,
  }) : assert(steps.length > 0, 'At least one step is required');

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

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final _pageController = PageController();
  final _animationDuration = const Duration(milliseconds: 300);
  final _animationCurve = Curves.ease;
  bool _formValid = false;
  final _values = HashMap();

  AppBar get _appBar =>
      widget.customAppBar ??
      AppBar(
        title: Text(widget.appBarTitle),
      );

  void onPrevious() {
    FocusScope.of(context).unfocus();
    _validate(_pageController.page!.toInt() - 1);
    _pageController.previousPage(
      duration: _animationDuration,
      curve: _animationCurve,
    );
  }

  Future<void> onNext(AuthStep step) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();

    FocusScope.of(context).unfocus();

    for (var step in widget.steps) {
      for (var field in step.fields) {
        setState(() {
          _values[field.name] = field.value;
        });
      }
    }

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
    if (widget.isLoading) {
      return const Center(
        child: SizedBox(
          height: 120,
          width: 120,
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      backgroundColor: widget.customBackgroundColor ?? Colors.white,
      appBar: _appBar,
      body: Form(
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
                          Spacer(
                            flex: widget.beforeTitleFlex ?? 3,
                          ),
                          widget.titleWidget!,
                          Spacer(
                            flex: widget.afterTitleFlex ?? 2,
                          ),
                        ],
                      ),
                    ),
                  ],
                  Expanded(
                    flex: widget.formFlex ?? 3,
                    child: Column(
                      children: [
                        for (AuthField field
                            in widget.steps[i].fields.map((field) {
                          if (!_values.containsKey(field.name)) return field;
                          field.value = _values[field.name]!;
                          return field;
                        }))
                          Align(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (field.title != null) ...[
                                  field.title!,
                                ],
                                field.build(context, (v) {
                                  _values[field.name] = v;
                                  _validate(i);
                                }),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 15.0,
                      bottom: 30.0,
                      left: widget.previousButtonBuilder == null &&
                              widget.steps.first != widget.steps[i]
                          ? 30.0
                          : 0.0,
                      right: widget.nextButtonBuilder == null &&
                              widget.previousButtonBuilder == null
                          ? 30.0
                          : 0.0,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment:
                              widget.buttonMainAxisAlignment != null
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
                                ElevatedButton(
                                  onPressed: onPrevious,
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.arrow_back,
                                        size: 18,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 4.0),
                                        child: Text(widget.previousBtnTitle),
                                      ),
                                    ],
                                  ),
                                ),
                            ] else if (widget.previousButtonBuilder?.call(
                                    onPrevious, widget.previousBtnTitle, i) !=
                                null) ...[
                              widget.previousButtonBuilder!
                                  .call(onPrevious, widget.previousBtnTitle, i)!
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
                                ElevatedButton(
                                  onPressed: !_formValid
                                      ? null
                                      : () async {
                                          await onNext(widget.steps[i]);
                                        },
                                  child: Row(
                                    children: [
                                      Text(
                                        widget.steps.last == widget.steps[i]
                                            ? widget.submitBtnTitle
                                            : widget.nextBtnTitle,
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(left: 4.0),
                                        child: Icon(
                                          Icons.arrow_forward,
                                          size: 18,
                                        ),
                                      ),
                                    ],
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
                  )
                ],
              )
          ],
        ),
      ),
    );
  }
}
