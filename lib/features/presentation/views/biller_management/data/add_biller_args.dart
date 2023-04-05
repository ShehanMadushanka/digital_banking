import '../../../../domain/entities/response/biller_category_entity.dart';
import '../../../../domain/entities/response/biller_entity.dart';
import '../../../../domain/entities/response/custom_field_entity.dart';

class AddBillerArgs {
  final BillerCategoryEntity billerCategoryEntity;
  final BillerEntity billerEntity;
  final String nickName;
  final List<CustomFieldEntity> customFields;

  AddBillerArgs(
      {this.billerCategoryEntity,
      this.billerEntity,
      this.nickName,
      this.customFields});
}
