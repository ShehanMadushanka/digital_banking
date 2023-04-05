import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/services/dependency_injection.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_strings.dart';
import '../../../../utils/app_styling.dart';
import '../../../domain/entities/response/select_account_entity.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../../bloc/biller_management/biller_management_bloc.dart';
import '../../widgets/cdb_text_fields/cdb_search_text_field.dart';
import '../base_view.dart';
import 'widget/gold_loan_account_comp.dart';

class SelectAccountViewParam {
  final bool isSerchable;
  final Function selectedAccount;

  SelectAccountViewParam({this.isSerchable, this.selectedAccount});
}

class SelectAccountView extends BaseView {
  SelectAccountViewParam selectAccountViewParam;

  SelectAccountView({this.selectAccountViewParam});

  @override
  State<SelectAccountView> createState() => _SelectAccountState();
}

List<SelectAccountEntity> selectAccount = [
  SelectAccountEntity(
    accountName: "dhanu",
    accountNum: "0111100568215",
    accountType: "CDB Salary Plus",
    accountBalance: 10000000,
  ),
  SelectAccountEntity(
    accountName: "dhanu",
    accountNum: "0111100568215",
    accountType: "CDB Saving ",
    accountBalance: 13000000,
  ),
];

class _SelectAccountState extends BaseViewState<SelectAccountView> {
  final BillerManagementBloc _bloc = inject<BillerManagementBloc>();
  final searchController = TextEditingController();

  String _searchString = '';

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      setState(() {
        _searchString = searchController.text;
      });
    });
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 60.h,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: kLeftRightMarginOnBoarding,
                  right: kLeftRightMarginOnBoarding,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Select Account",
                      // widget.dropDownViewScreenArgs.pageTitle,
                      style: AppStyling.normal500Size20
                          .copyWith(color: AppColors.textDarkColor),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.close),
                    ),
                  ],
                ),
              ),
              if (widget.selectAccountViewParam.isSerchable)
                Column(
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: kLeftRightMarginOnBoarding,
                        right: kLeftRightMarginOnBoarding,
                      ),
                      child: CdbSearchTextField(
                        hintText: AppString.search.localize(context),
                        textEditingController: searchController,
                        onChange: (value) {},
                      ),
                    ),
                  ],
                )
              else
                const SizedBox.shrink(),
              if (selectAccount.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: kBottomMargin,
                      left: kLeftRightMarginOnBoarding,
                      right: kLeftRightMarginOnBoarding),
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: selectAccount.length,
                    itemBuilder: (_, index) => _searchString.isEmpty
                        ? InkWell(
                            onTap: ()=>widget.selectAccountViewParam
                                .selectedAccount(selectAccount[index]),
                            child: GoldLoanAccount(
                              selectAccountEntity: selectAccount[index],
                            ),
                          )
                        : selectAccount[index]
                                .accountType
                                .toLowerCase()
                                .contains(_searchString.toLowerCase())
                            ? InkWell(
                                onTap: ()=> widget.selectAccountViewParam
                                    .selectedAccount(selectAccount[index]),
                                child: GoldLoanAccount(
                                  selectAccountEntity: selectAccount[index],
                                ),
                              )
                            : const SizedBox.shrink(),
                  ),
                )
              else
                const SizedBox.shrink()
            ]),
      ),
    );
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return _bloc;
  }
}
