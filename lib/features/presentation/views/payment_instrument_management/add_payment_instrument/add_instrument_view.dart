import 'package:cdb_mobile/features/presentation/widgets/cdb_drop_down/cdb_drop_down.dart';
import 'package:cdb_mobile/features/presentation/widgets/cdb_radio_button.dart';
import 'package:cdb_mobile/features/presentation/widgets/cdb_text_fields/cdb_text_field.dart';
import 'package:cdb_mobile/features/presentation/widgets/cdb_toast/cdb_toast.dart';
import 'package:cdb_mobile/utils/navigation_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/services/dependency_injection.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../../utils/app_strings.dart';
import '../../../../../utils/app_styling.dart';
import '../../../../../utils/enums.dart';
import '../../../bloc/base_bloc.dart';
import '../../../bloc/base_event.dart';
import '../../../bloc/base_state.dart';
import '../../../bloc/on_boarding/schedule_verification/schedule_verification_bloc.dart';
import '../../../bloc/on_boarding/schedule_verification/schedule_verification_state.dart';
import '../../../widgets/cdb_buttons/cdb_border_gradient_button.dart';
import '../../../widgets/cdb_default_appbar.dart';
import '../../../widgets/cdb_item_selector.dart';
import '../../../widgets/cdb_scrollview.dart';
import '../../base_view.dart';
import '../../home/widget/home_account_card.dart';

class PayeeData {
  String title;
  String accountNumber;
  String amount;
  bool isSelected;

  PayeeData(
      {this.title, this.accountNumber, this.amount, this.isSelected = false});
}

class AddPaymentInstrumentView extends BaseView {
  final bool isEditingEnabled;

  const AddPaymentInstrumentView({Key key, this.isEditingEnabled})
      : super(key: key);

  @override
  _AddPaymentInstrumentRootViewState createState() =>
      _AddPaymentInstrumentRootViewState();
}

class _AddPaymentInstrumentRootViewState
    extends BaseViewState<AddPaymentInstrumentView> {
  final ScheduleVerificationBloc _scheduleVerificationBloc =
      inject<ScheduleVerificationBloc>();
  int _selectedIndex = 0;
  List<CDBSelectionItem> selectionItems = [];
  List<PayeeData> cdbAccountList = [];

  @override
  void initState() {
    super.initState();
    selectionItems.addAll([
      CDBSelectionItem(title: 'CDB Bank', isSelected: true),
      CDBSelectionItem(title: 'Other Bank'),
    ]);

    cdbAccountList.addAll([
      PayeeData(
        title: "CDB Savings Account",
        accountNumber: "0102000568215",
        amount: "520,000.00",
      ),
      PayeeData(
        title: "CDB Current Account",
        accountNumber: "0102000568215",
        amount: "520,000.00",
      ),
      PayeeData(
        title: "CDB Salary Plus",
        accountNumber: "0102000568215",
        amount: "520,000.00",
      ),
    ]);
  }

  /// Build View
  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: CDBMainAppBar(
        appBarTitle: AppString.titleAddPaymentInstrumentRoot.localize(context),
        onTapBack: () {
          Navigator.pop(context);
        },
      ),
      body: BlocProvider(
        create: (_) => _scheduleVerificationBloc,
        child: BlocListener<ScheduleVerificationBloc,
            BaseState<ScheduleVerificationState>>(
          listener: (context, state) {},
          child: Padding(
            padding: const EdgeInsets.only(
              top: kTopMarginOnBoarding,
              bottom: kBottomMargin,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: CDBItemSelector(
                          items: selectionItems,
                          onSelectItem: (index) {
                            setState(() {
                              _selectedIndex = index;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height: 50.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          AppString.titleAddNewPaymentOption.localize(context),
                          style: AppStyling.normal700Size16
                              .copyWith(color: AppColors.textDarkColor),
                        ),
                      ),
                      const SizedBox(
                        height: kOnBoardingMarginBetweenFields,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          _selectedIndex == 0
                              ? AppString.decriptionAddNewCDB.localize(context)
                              : AppString.decriptionAddNewOther
                                  .localize(context),
                          style: AppStyling.normal400Size14
                              .copyWith(color: AppColors.textDarkColor),
                        ),
                      ),
                      if (_selectedIndex == 0)
                        _cdbWidget()
                      else
                        _otherBankWidget()
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _cdbWidget() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              const SizedBox(
                height: kTopMarginOnBoarding,
              ),
              CDBScrollView(
                padding: EdgeInsets.zero,
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 4,
                      childAspectRatio: 1.3),
                  itemCount: cdbAccountList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return InkWell(
                      splashColor: Colors.transparent,
                      onTap: () {
                        setState(() {
                          cdbAccountList[index].isSelected =
                              !cdbAccountList[index].isSelected;
                        });
                      },
                      child: HomeAccountCard(
                        isGridView: true,
                        accountNumber: cdbAccountList[index].accountNumber,
                        title: cdbAccountList[index].title,
                        amount: cdbAccountList[index].amount,
                        isSelected: cdbAccountList[index].isSelected,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: kLeftRightMarginOnBoarding,
              right: kLeftRightMarginOnBoarding,
            ),
            child: Column(
              children: [
                CDBBorderGradientButton(
                  width: double.maxFinite,
                  status:
                      validate() ? ButtonStatus.ENABLE : ButtonStatus.DISABLE,
                  onTap: () {
                    ToastUtils.showCustomToast(
                        context,
                        AppString.titleAccountAddSuccess.localize(context),
                        ToastStatus.success);
                    Navigator.pop(context);
                  },
                  text: AppString.next.localize(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _otherBankWidget() {
    return Expanded(
      child: CDBScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: kOnBoardingMarginBetweenFields,
            ),
            CdbDropDown(
              key: Key("bankname"),
              initialValue: '',
              suffixIcon: Icon(Icons.keyboard_arrow_down,
                  color: AppColors.textDarkColor),
              labelText: 'Bank Name',
              onTap: () {},
            ),
            const SizedBox(
              height: kOnBoardingMarginBetweenFields,
            ),
            CdbCustomRadioButton(
              key: Key("acctype"),
              radioLabel: 'Account Type',
              initialValue: '',
              radioButtonDataList: List.from([
                RadioButtonModel(
                  label: 'Savings Account',
                  value: "sv",
                ),
                RadioButtonModel(
                  label: 'Current Account',
                  value: "cv",
                ),
              ]),
              onChange: (value) {},
            ),
            const SizedBox(
              height: kOnBoardingMarginBetweenFields,
            ),
            CdbCustomTextField(
              key: Key("accnumber"),
              labelText: 'Account Number',
              maxLength: 15,
              initialValue: '',
              textInputType: TextInputType.number,
              onChange: (value) {},
            ),
            const SizedBox(
              height: kOnBoardingMarginBetweenFields,
            ),
            CdbCustomTextField(
              key: Key("fullname"),
              labelText: 'Full Name',
              maxLength: 15,
              initialValue: '',
              onChange: (value) {},
            ),
            const SizedBox(
              height: kOnBoardingMarginBetweenFields,
            ),
            CdbCustomTextField(
              key: Key("nic"),
              labelText: 'National Identity Card Number',
              maxLength: 12,
              initialValue: '',
              onChange: (value) {},
            ),
            const SizedBox(
              height: kOnBoardingMarginBetweenFields,
            ),
            CdbCustomTextField(
              key: Key("nickname"),
              labelText: 'Nickname',
              maxLength: 12,
              initialValue: '',
              onChange: (value) {},
            ),
            const SizedBox(
              height: kOnBoardingMarginBetweenFields,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: kLeftRightMarginOnBoarding,
                right: kLeftRightMarginOnBoarding,
              ),
              child: Column(
                children: [
                  CDBBorderGradientButton(
                    width: double.maxFinite,
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, Routes.kTermsAndConditionsView,
                          arguments: Routes.kAddPaymentInstrumentRootView);
                    },
                    text: AppString.continueTxt.localize(context),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  bool validate() {
    return cdbAccountList.where((element) => element.isSelected).isNotEmpty;
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return _scheduleVerificationBloc;
  }
}
