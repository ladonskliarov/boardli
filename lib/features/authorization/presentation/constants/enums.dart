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
  technology('Technology'),
  finance('Finance'),
  other('Other');

  @override
  final String value;

  @override
  String get key => name;
  const IndustryType(this.value);
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
  male('Male'),
  female('Female'),
  other('Other'),
  preferNotToSay('Prefer not to say');

  @override
  final String value;

  @override
  String get key => name;
  const Gender(this.value);
}
