import 'package:easy_localization/easy_localization.dart';

abstract interface class EnumValue {
  String get value;
  String get key;
}

enum CompanySize implements EnumValue {
  small('1-20'),
  medium('21-50'),
  big('51-200');

  @override
  final String value;

  @override
  String get key => name;
  const CompanySize(this.value);
}

enum IndustryType implements EnumValue {
  technology('enums.industry.technology'),
  finance('enums.industry.finance'),
  other('enums.industry.other');

  final String _translationKey;

  @override
  String get value => _translationKey.tr();

  @override
  String get key => name;

  const IndustryType(this._translationKey);
}

enum EmployeeRole implements EnumValue {
  trainee('Trainee'),
  junior('Junior'),
  middle('Middle'),
  senior('Senior'),
  lead('Lead'),
  head('Head'),
  cto('CTO');

  @override
  final String value;

  @override
  String get key => name;
  const EmployeeRole(this.value);
}

enum Gender implements EnumValue {
  male('enums.gender.male'),
  female('enums.gender.female'),
  other('enums.gender.other'),
  preferNotToSay('enums.gender.preferNotToSay');

  final String _translationKey;

  @override
  String get value => _translationKey.tr();

  @override
  String get key => name;

  const Gender(this._translationKey);
}
