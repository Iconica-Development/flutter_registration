// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'dart:async';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_registration/flutter_registration.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({
    required this.title,
    required this.steps,
    required this.submitBtnTitle,
    required this.nextBtnTitle,
    required this.previousBtnTitle,
    required this.onFinish,
    this.customAppBar,
    this.customBackgroundColor,
    this.nextButtonBuilder,
    this.previousButtonBuilder,
    this.titleWidget,
    this.loginButton,
    super.key,
  }) : assert(steps.length > 0, 'At least one step is required');

  final String title;
  final Future<void> Function({
    required HashMap<String, dynamic> values,
    required void Function(int? pageToReturn) onError,
  }) onFinish;
  final List<AuthStep> steps;
  final String submitBtnTitle;
  final String nextBtnTitle;
  final String previousBtnTitle;
  final AppBar? customAppBar;
  final Color? customBackgroundColor;
  final Widget Function(Future<void> Function(), String)? nextButtonBuilder;
  final Widget? Function(VoidCallback, String)? previousButtonBuilder;
  final Widget? titleWidget;
  final Widget? loginButton;

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final _pageController = PageController();
  final _animationDuration = const Duration(milliseconds: 300);
  final _animationCurve = Curves.ease;

  AppBar get _appBar =>
      widget.customAppBar ??
      AppBar(
        title: Text(widget.title),
      );

  void onPrevious() {
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
      _pageController.nextPage(
        duration: _animationDuration,
        curve: _animationCurve,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var previousButton = widget.previousButtonBuilder?.call(
      onPrevious,
      widget.previousBtnTitle,
    );

    return Scaffold(
      backgroundColor: widget.customBackgroundColor ?? Colors.white,
      appBar: _appBar,
      body: Form(
        key: _formKey,
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: <Widget>[
            for (AuthStep step in widget.steps)
              Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Text(widget.title),
                  if (widget.titleWidget != null) widget.titleWidget!,
                  const SizedBox(height: 40),
                  Flexible(
                    child: ListView(
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 30.0,
                      ),
                      children: [
                        for (AuthField field in step.fields)
                          Align(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (field.title != null) ...[
                                  field.title!,
                                ],
                                field.build(),
                              ],
                            ),
                          )
                      ],
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 15.0,
                      // bottom: 30.0,
                      left: 30.0,
                      right: 30.0,
                    ),
                    child: Row(
                      mainAxisAlignment:
                          (widget.previousButtonBuilder != null &&
                                  previousButton == null)
                              ? MainAxisAlignment.spaceAround
                              : widget.steps.first != step
                                  ? MainAxisAlignment.spaceBetween
                                  : MainAxisAlignment.end,
                      children: [
                        if (widget.steps.first != step)
                          if (widget.previousButtonBuilder == null) ...[
                            ElevatedButton(
                              onPressed: onPrevious,
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.arrow_back,
                                    size: 18,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 4.0),
                                    child: Text(widget.previousBtnTitle),
                                  ),
                                ],
                              ),
                            ),
                          ] else if (previousButton != null) ...[
                            previousButton
                          ],
                        widget.nextButtonBuilder?.call(
                              () async {
                                await onNext(step);
                              },
                              widget.steps.last == step
                                  ? widget.submitBtnTitle
                                  : widget.nextBtnTitle,
                            ) ??
                            ElevatedButton(
                              onPressed: () async {
                                await onNext(step);
                              },
                              child: Row(
                                children: [
                                  Text(
                                    widget.steps.last == step
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
                  ),
                  if (widget.loginButton != null)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: widget.loginButton!,
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
