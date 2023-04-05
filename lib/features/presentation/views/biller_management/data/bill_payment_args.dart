import 'package:cdb_mobile/features/domain/entities/response/biller_category_entity.dart';
import 'package:cdb_mobile/features/domain/entities/response/biller_entity.dart';

class BillPaymentArgs{
  final BillerCategoryEntity billerCategoryEntity;
  final BillerEntity billerEntity;
  final double amount;
  final String remark;

  BillPaymentArgs({this.billerCategoryEntity,this.amount, this.remark, this.billerEntity});
}