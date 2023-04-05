import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../utils/app_constants.dart';
import '../../../../utils/app_strings.dart';
import '../../../../utils/navigation_routes.dart';
import '../../../domain/entities/response/payee_management_entity.dart';
import '../../widgets/cdb_default_appbar.dart';
import '../base_view.dart';
import 'widget/payee_management_component.dart';

class PayeeManagementListView extends BaseView {
  @override
  State<PayeeManagementListView> createState() =>
      _PayeeManagementListViewState();
}

class _PayeeManagementListViewState extends State<PayeeManagementListView> {
  List<PayeeManagementEntity> payeeManagement = [
    PayeeManagementEntity(payeeManagementTitle: 'Fund Transfer Payees'),
    PayeeManagementEntity(payeeManagementTitle: 'iTransfer Payees'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CDBMainAppBar(
          appBarTitle: AppString.payeeManagement.localize(context),
          onTapBack: () {
            Navigator.pop(context);
          },
        ),
        body: payeeManagement.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.only(
                    top: kOnBoardingMarginBetweenFields,
                    bottom: kBottomMargin,
                    left: kLeftRightMarginOnBoarding,
                    right: kLeftRightMarginOnBoarding),
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: payeeManagement.length,
                  itemBuilder: (_, index) => PayeeManagementComponent(
                      payeeManagementEntity: payeeManagement[index],
                      onTap: () {
                        Navigator.pushNamed(context, Routes.kSavedPayeeListView,
                            arguments: false);
                      }),
                ),
              )
            : const SizedBox.shrink());
  }
}
