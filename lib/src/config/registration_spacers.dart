class RegistrationSpacerConfig {
  const RegistrationSpacerConfig({
    this.beforeTitleSpacer,
    this.afterTitleSpacer,
    this.afterFormSpacer,
    this.formFlex = 1,
  });
  final int? beforeTitleSpacer;
  final int? afterTitleSpacer;
  final int? afterFormSpacer;
  final int? formFlex;
}
