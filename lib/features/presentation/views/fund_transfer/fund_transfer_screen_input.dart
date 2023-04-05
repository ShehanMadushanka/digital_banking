import 'package:carousel_slider/carousel_slider.dart';
import 'package:cdb_mobile/core/services/dependency_injection.dart';
import 'package:cdb_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:cdb_mobile/features/presentation/bloc/base_event.dart';
import 'package:cdb_mobile/features/presentation/bloc/base_state.dart';
import 'package:cdb_mobile/features/presentation/bloc/biller_management/biller_management_bloc.dart';
import 'package:cdb_mobile/features/presentation/views/base_view.dart';
import 'package:cdb_mobile/features/presentation/views/biller_management/widget/bill_payment_account_card.dart';
import 'package:cdb_mobile/features/presentation/views/fund_transfer/fund_transfer_saved_payee_schedule.dart';
import 'package:cdb_mobile/features/presentation/views/fund_transfer/save_payee_view.dart';
import 'package:cdb_mobile/features/presentation/views/fund_transfer/unsaved_pay_view.dart';
import 'package:cdb_mobile/features/presentation/widgets/cdb_toggle_switch.dart';
import 'package:cdb_mobile/features/presentation/widgets/cdb_default_appbar.dart';
import 'package:cdb_mobile/utils/app_colors.dart';
import 'package:cdb_mobile/utils/app_strings.dart';
import 'package:cdb_mobile/utils/app_styling.dart';
import 'package:flutter/material.dart';

class FundTransferScreenInput extends BaseView {
  const FundTransferScreenInput({Key key}) : super(key: key);

  @override
  _FundTransferScreenInputState createState() =>
      _FundTransferScreenInputState();
}

class _FundTransferScreenInputState
    extends BaseViewState<FundTransferScreenInput> {
  final BillerManagementBloc _bloc = inject<BillerManagementBloc>();
  final List<String> items = ["a", "b", "c"];
  String item = "left";

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: CDBMainAppBar(
        appBarTitle: AppString.fundTransferScreenInputTitle.localize(context),
        onTapBack: () {
          Navigator.pop(context);
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 24.0),
            child: Text(
              AppString.payFrom.localize(context),
              style: AppStyling.normal400Size14
                  .copyWith(color: AppColors.textTitleColor),
            ),
          ),
          SizedBox(
            height: 180,
            width: MediaQuery.of(context).size.width,
            child: CarouselSlider.builder(
              itemCount: items.length,
              itemBuilder: (
                BuildContext context,
                int itemIndex,
                int pageViewIndex,
              ) =>
                  BillPaymentAccountCard(
                title: "CDB Salary Plus",
                accountNumber: "0102000568215",
                amount: "520,000.00",
                backgroundColor: AppColors.darkGray,
                onTap: () {},
              ),
              options: CarouselOptions(
                viewportFraction: 0.70,
                initialPage: 1,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 24.0),
            child: Text(
              AppString.payTo.localize(context),
              style: AppStyling.normal400Size14
                  .copyWith(color: AppColors.textTitleColor),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: CDBToggleSwitch(
              activeBackgroundColor: AppColors.whiteColor,
              inActiveBackgroundColor: AppColors.whiteDark,
              activeToggleName: "Saved Payee",
              inActiveToggleName: "Unsaved Payee",
              bottomBorderColor: AppColors.primaryColor,
              activeToggleNameStyle: AppStyling.normal600Size14.copyWith(
                color: AppColors.primaryColor,
              ),
              inActiveToggleNameStyle: AppStyling.normal600Size14.copyWith(
                color: AppColors.darkGray,
              ),
              isClicked: (value) {
                setState(() {
                  item = value;
                });
                debugPrint(value);
              },
            ),
          ),
          Expanded(child: item == "left" ?  const FundTransferSavedPayeeSchedule() : const UnsavedPayeeView())
        ],
      ),
    );
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return _bloc;
  }
}
