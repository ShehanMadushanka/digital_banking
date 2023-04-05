import 'charee_code_entity.dart';
import 'custom_field_entity.dart';

class BillerEntity {
  final int billerId;
  final String billerCode;
  final String billerName;
  final String billerImage;
  final String description;
  final String displayName;
  final String collectionAccount;
  final String status;
  final ChargeCodeEntity chargeCodeEntity;
  final List<CustomFieldEntity> customFieldList;

  BillerEntity(
      {this.billerId,
      this.billerName,
      this.billerImage,
      this.billerCode,
      this.chargeCodeEntity,
      this.status,
      this.customFieldList,
      this.description,
      this.collectionAccount,
      this.displayName});
}
