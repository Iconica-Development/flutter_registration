import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_registration/src/model/auth_action.dart';
import 'package:flutter_registration/src/model/auth_field.dart';
import 'package:flutter_registration/src/model/auth_step.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({
    required this.title,
    required this.steps,
    required this.submitBtnTitle,
    required this.onFinish,
    this.actions,
    super.key,
  }) : assert(steps.length > 0, 'At least one step is required');

  final String title;
  final Function(HashMap<String, String>) onFinish;
  final List<AuthStep> steps;
  final String submitBtnTitle;
  final List<AuthAction>? actions;

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  int _index = 0;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Form(
        key: _formKey,
        child: Column(
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
                  Column(
                    children: [
                      for (AuthField field in widget.steps[_index].fields)
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
                  )
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                    ),
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }
                      if (widget.steps.length > _index + 1) {
                        setState(() {
                          _index++;
                        });
                      } else {
                        var values = HashMap<String, String>();

                        for (var step in widget.steps) {
                          for (var field in step.fields) {
                            values[field.name] = field.value;
                          }
                        }

                        widget.onFinish(values);
                      }
                    },
                    child: Text(
                      widget.steps.length > _index + 1
                          ? 'Volgende stap'
                          : widget.submitBtnTitle,
                    ),
                  ),
                  for (AuthAction action in widget.actions ?? [])
                    TextButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(40),
                      ),
                      onPressed: action.onPress,
                      child: Text(action.title),
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
