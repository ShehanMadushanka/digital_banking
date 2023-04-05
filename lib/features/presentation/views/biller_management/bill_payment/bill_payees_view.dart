import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/services/dependency_injection.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../../utils/app_strings.dart';
import '../../../../../utils/navigation_routes.dart';
import '../../../../domain/entities/response/biller_category_entity.dart';
import '../../../bloc/base_bloc.dart';
import '../../../bloc/base_event.dart';
import '../../../bloc/base_state.dart';
import '../../../bloc/biller_management/biller_management_bloc.dart';
import '../../../bloc/biller_management/biller_management_state.dart';
import '../../../widgets/cdb_default_appbar.dart';
import '../../base_view.dart';
import '../widget/bill_payees_component.dart';

class BIllPayeesView extends BaseView {
  final BillerCategoryEntity biller;

  const BIllPayeesView({this.biller});

  @override
  _BIllPayeesViewState createState() => _BIllPayeesViewState();
}

class _BIllPayeesViewState extends BaseViewState<BIllPayeesView> {
  final BillerManagementBloc _bloc = inject<BillerManagementBloc>();

  /// Build View
  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: CDBMainAppBar(
        appBarTitle: AppString.titleBillPayees.localize(context),
        onTapBack: () {
          Navigator.pop(context);
        },
      ),
      body: BlocProvider(
        create: (_) => _bloc,
        child: BlocListener<BillerManagementBloc,
            BaseState<BillerManagementState>>(
          listener: (context, state) {},
          child: Padding(
            padding: const EdgeInsets.only(
                top: kOnBoardingMarginBetweenFields,
                bottom: kBottomMargin,
                left: kLeftRightMarginOnBoarding,
                right: kLeftRightMarginOnBoarding),
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: widget.biller.billers.length,
              itemBuilder: (_, index) => BillPayeesComponent(
                billerEntity: widget.biller.billers[index],
                onTap: () {
                  Navigator.pushNamed(context, Routes.kBillPaymentView,
                      arguments: widget.biller.billers[index]);
                },
              ),
            ),
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
