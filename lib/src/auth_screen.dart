import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_registration/src/model/auth_field.dart';
import 'package:flutter_registration/src/model/auth_step.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({
    required this.title,
    required this.steps,
    required this.submitBtnTitle,
    required this.onFinish,
    super.key,
  }) : assert(steps.length > 0, 'At least one step is required');

  final String title;
  final Function(HashMap<String, String>) onFinish;
  final List<AuthStep> steps;
  final String submitBtnTitle;

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final _pageController = PageController();
  final _animationDuration = const Duration(milliseconds: 300);
  final _animationCurve = Curves.ease;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text(widget.title),
      ),
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
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 30.0,
                    ),
                    child: Column(
                      children: [
                        for (AuthField field in step.fields)
                          Column(
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
                          )
                      ],
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
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
                                const Padding(
                                  padding: EdgeInsets.only(left: 4.0),
                                  child: Text('Vorige stap'),
                                ),
                              ],
                            ),
                          ),
                        ElevatedButton(
                          onPressed: () {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }

                            if (widget.steps.last == step) {
                              var values = HashMap<String, String>();

                              for (var step in widget.steps) {
                                for (var field in step.fields) {
                                  values[field.name] = field.value;
                                }
                              }

                              widget.onFinish(values);
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
                                    : 'Volgende stap',
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
}
