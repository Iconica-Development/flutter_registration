[![pub package](https://img.shields.io/pub/v/bottom_alert_dialog.svg)](https://github.com/Iconica-Development) [![Build status](https://github.com/Iconica-Development/flutter_registration)](https://github.com/Iconica-Development/flutter_registration/actions/new) [![style: effective dart](https://img.shields.io/badge/style-effective_dart-40c4ff.svg)](https://github.com/tenhobi/effective_dart) 


Registration plug-in.

## Install

To use this package, add `flutter_registration` as a [dependency in your pubspec.yaml file](https://flutter.dev/docs/development/platform-integration/platform-channels).

## Configure

To configure the registration plug-in use the ```RegistrationScreen``` widget.

```dart
void main() {
  runApp(
    MaterialApp(
      home: RegistrationScreen(
        registrationOptions: RegistrationOptions(
          registrationRepository: ExampleRegistrationRepository(),
          registrationSteps: RegistrationOptions.defaultSteps,
          afterRegistration: () {
            debugPrint('Registered!');
          },
        ),
      ),
    ),
  );
}
```

You are required to provide your own RegistrationRepository, this can be done using the parameter ```registrationRepository``` within the RegistrationsOptions which can be assigned to the RegistrationScreen widget. 

A RegistrationRepository is responsible for sending the provided user details (email address and password for example) to an API.

An example for creating a RegistrationRepository is specificied below:
```dart
class ExampleRegistrationRepository with RegistrationRepository {
  @override
  Future<bool> register(HashMap values) {
    debugPrint('register: $values');
    return Future.value(true);
  }
}
```

## Issues

Please file any issues, bugs or feature request as an issue on our [GitHub](https://github.com/Iconica-Development/flutter_registration) page. Commercial support is available if you need help with integration with your app or services. You can contact us at [support@iconica.nl](mailto:support@iconica.nl).

## Want to contribute

If you would like to contribute to the plugin (e.g. by improving the documentation, solving a bug or adding a cool new feature), please carefully review our [contribution guide](./CONTRIBUTING.md) and send us your [pull request](https://github.com/Iconica-Development/flutter_registration/pulls).

## Author

This flutter_registration for Flutter is developed by [Iconica](https://iconica.nl). You can contact us at <support@iconica.nl>