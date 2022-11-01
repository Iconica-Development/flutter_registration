// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_registration/src/model/auth_field.dart';
import 'package:flutter_registration/src/model/auth_step.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({
    required this.title,
    required this.steps,
    required this.submitBtnTitle,
    required this.nextBtnTitle,
    required this.previousBtnTitle,
    required this.onFinish,
    this.customAppBar,
    super.key,
  }) : assert(steps.length > 0, 'At least one step is required');

  final String title;
  final Function({
    required HashMap<String, String> values,
    required VoidCallback onError,
  }) onFinish;
  final List<AuthStep> steps;
  final String submitBtnTitle;
  final String nextBtnTitle;
  final String previousBtnTitle;
  final AppBar? customAppBar;

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

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: _appBar,
        body: Form(
          key: _formKey,
          child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _pageController,
            children: <Widget>[
              for (AuthStep step in widget.steps)
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Center(
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
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 24.0,
                                        bottom: 12.0,
                                      ),
                                      child: Text(
                                        field.title,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    field.build(),
                                  ],
                                ),
                              )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 15.0,
                        bottom: 30.0,
                        left: 30.0,
                        right: 30.0,
                      ),
                      child: Row(
                        mainAxisAlignment: widget.steps.first != step
                            ? MainAxisAlignment.spaceBetween
                            : MainAxisAlignment.end,
                        children: [
                          if (widget.steps.first != step)
                            ElevatedButton(
                              onPressed: () => _pageController.previousPage(
                                duration: _animationDuration,
                                curve: _animationCurve,
                              ),
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
                          ElevatedButton(
                            onPressed: () {
                              if (!_formKey.currentState!.validate()) {
                                return;
                              }

                              FocusScope.of(context).unfocus();

                              if (widget.steps.last == step) {
                                var values = HashMap<String, String>();

                                for (var step in widget.steps) {
                                  for (var field in step.fields) {
                                    values[field.name] = field.value;
                                  }
                                }

                                widget.onFinish(
                                  values: values,
                                  onError: () => _pageController.animateToPage(
                                    0,
                                    duration: _animationDuration,
                                    curve: _animationCurve,
                                  ),
                                );

                                return;
                              }

                              _pageController.nextPage(
                                duration: _animationDuration,
                                curve: _animationCurve,
                              );
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
                    )
                  ],
                ),
            ],
          ),
        ),
      );
}
