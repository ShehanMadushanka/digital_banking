class CustomFieldEntity {
  String customFieldId;
  String customFieldValue;
  String customFieldName;
  String placeholder;
  String userValue;
  CustomFieldDetailsEntity customFieldDetailsEntity;

  CustomFieldEntity(
      {this.customFieldId,
      this.placeholder,
      this.customFieldValue,
      this.userValue,
      this.customFieldName,
      this.customFieldDetailsEntity});
}

class CustomFieldDetailsEntity {
  int id;
  String name;
  String validation;
  String length;
  FieldTypeEntity fieldTypeEntity;

  CustomFieldDetailsEntity(
      {this.id, this.name, this.validation, this.length, this.fieldTypeEntity});
}

class FieldTypeEntity {
  int id;
  String name;

  FieldTypeEntity({this.id, this.name});
}
