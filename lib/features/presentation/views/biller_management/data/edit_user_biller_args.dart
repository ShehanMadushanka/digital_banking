import 'package:cdb_mobile/features/domain/entities/response/biller_category_entity.dart';
import 'package:cdb_mobile/features/domain/entities/response/biller_entity.dart';
import 'package:cdb_mobile/features/domain/entities/response/custom_field_entity.dart';

class EditUserBillerArgs {
  final BillerCategoryEntity billerCategoryEntity;
  final BillerEntity billerEntity;
  final String nickName;
  final List<CustomFieldEntity> customFields;

  EditUserBillerArgs(
      {this.billerCategoryEntity,
        this.billerEntity,
        this.nickName,
        this.customFields});
}
