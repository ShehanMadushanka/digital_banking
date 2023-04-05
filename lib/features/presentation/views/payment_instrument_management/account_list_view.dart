import 'package:cdb_mobile/features/domain/entities/response/account_entity.dart';
import 'package:cdb_mobile/features/presentation/views/payment_instrument_management/widget/account_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/services/dependency_injection.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/app_strings.dart';
import '../../../../utils/enums.dart';
import '../../../../utils/navigation_routes.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../../bloc/biller_management/biller_management_bloc.dart';
import '../../bloc/biller_management/biller_management_state.dart';
import '../../widgets/cdb_default_appbar.dart';
import '../base_view.dart';
import '../common/empty_view.dart';

class AccountListView extends BaseView {
  @override
  _AccountListViewState createState() => _AccountListViewState();
}

class _AccountListViewState extends BaseViewState<AccountListView> {
  final BillerManagementBloc _bloc = inject<BillerManagementBloc>();

  List<AccountEntity> accountList = [];

  @override
  void initState() {
    super.initState();
    initBillerData();
  }

  initBillerData() {
    accountList.clear();
    accountList.addAll([
      AccountEntity(
          nickName: 'CDB Current Account',
          availableBalance: 25000.20,
          isPrimary: true,
          accountNumber: '123123123'),
      AccountEntity(
          nickName: 'CDB Savings Account',
          availableBalance: 100000,
          accountNumber: '123123123'),
      AccountEntity(
          nickName: 'Commercial Account',
          isCDBAccount: false,
          accountNumber: '123123123'),
      AccountEntity(
          nickName: 'NDB Account',
          isCDBAccount: false,
          accountNumber: '123123123'),
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
        create: (_) => _bloc,
        child: BlocListener<BillerManagementBloc,
            BaseState<BillerManagementState>>(
          listener: (context, state) {},
          child: accountList.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.only(
                      top: kOnBoardingMarginBetweenFields,
                      bottom: kBottomMargin,
                      left: kLeftRightMarginOnBoarding,
                      right: kLeftRightMarginOnBoarding),
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: accountList.length,
                    itemBuilder: (_, index) => AccountComponent(
                      accountEntity: accountList[index],
                      onTap: () {
                        Navigator.pushNamed(context, Routes.kAccountDetailView,
                            arguments: accountList[index]);
                      },
                    ),
                  ),
                )
              : Stack(
                  children: [
                    Image.asset(AppImages.preLoginMenuBg),
                    Column(
                      children: [
                        SizedBox(
                          height: 64.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: kBottomMargin),
                          child: SizedBox(
                              height: 350.h,
                              child: const CDBEmptyView(
                                type: EmptyViewType.ACCOUNT,
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return _bloc;
  }
}
