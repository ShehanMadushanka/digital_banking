import 'package:cdb_mobile/utils/navigation_routes.dart';
import 'package:flutter/material.dart';

import '../../../../core/services/dependency_injection.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_strings.dart';
import '../../../domain/entities/response/gold_loan_entity.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../../bloc/biller_management/biller_management_bloc.dart';
import '../../widgets/cdb_default_appbar.dart';
import '../base_view.dart';
import 'widget/gold_loan_component.dart';

class GoldLoanListView extends BaseView {
  @override
  _GoldLoanListViewState createState() => _GoldLoanListViewState();
}

class _GoldLoanListViewState extends BaseViewState<GoldLoanListView> {
  final BillerManagementBloc _bloc = inject<BillerManagementBloc>();

  List<GoldLoanEntity> goldLoans = [
    GoldLoanEntity(
        ticketNumber: '001217020632',
        capitalBalance: 50000,
        expireDate: '27-September-2024',
        interestBalance: 1000,
        isActive: true,
        loanPeriodsInMonths: 24,
        maximumAdvanceLimit: 90000,
        outstandingAmount: 52000,
        remainingAdvanceLimit: 100000,
        // isTopUpAvailable: false,
        // nextTopUpDate: '27-September-2024',
        articleDetailList: [
          ArticleDetailItem(title: 'Item 01', description: 'Chain'),
          ArticleDetailItem(title: 'Item 02', description: 'Ring'),
        ]),
    GoldLoanEntity(
        ticketNumber: '001217020633',
        capitalBalance: 50000,
        expireDate: '27-September-2024',
        interestBalance: 1000,
        isActive: false,
        loanPeriodsInMonths: 24,
        maximumAdvanceLimit: 90000,
        outstandingAmount: 100000,
        remainingAdvanceLimit: 0,
        articleDetailList: [
          ArticleDetailItem(title: 'Item 01', description: 'Chain'),
          ArticleDetailItem(title: 'Item 02', description: 'Ring'),
        ]),
  ];

  /// Build View
  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
        appBar: CDBMainAppBar(
          appBarTitle: AppString.titleGoldLoans.localize(context),
          onTapBack: () {
            Navigator.pop(context);
          },
        ),
        body: goldLoans.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.only(
                    top: kOnBoardingMarginBetweenFields,
                    bottom: kBottomMargin,
                    left: kLeftRightMarginOnBoarding,
                    right: kLeftRightMarginOnBoarding),
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: goldLoans.length,
                  itemBuilder: (_, index) => GoldLoanComponent(
                    goldLoanEntity: goldLoans[index],
                    onTap: () async {
                      Navigator.pushNamed(context, Routes.kGoldLoadDetailView,
                          arguments: goldLoans[index]);
                    },
                  ),
                ),
              )
            : const SizedBox.shrink());
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return _bloc;
  }
}
