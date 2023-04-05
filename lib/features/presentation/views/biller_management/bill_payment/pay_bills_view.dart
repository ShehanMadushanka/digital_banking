import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/services/dependency_injection.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../../utils/navigation_routes.dart';
import '../../../../domain/entities/response/biller_category_entity.dart';
import '../../../bloc/base_bloc.dart';
import '../../../bloc/base_event.dart';
import '../../../bloc/base_state.dart';
import '../../../bloc/biller_management/biller_management_bloc.dart';
import '../../../bloc/biller_management/biller_management_event.dart';
import '../../../bloc/biller_management/biller_management_state.dart';
import '../../base_view.dart';
import '../widget/pay_bills_component.dart';

class PayBillsView extends BaseView {
  @override
  _PayBillsViewState createState() => _PayBillsViewState();
}

class _PayBillsViewState extends BaseViewState<PayBillsView> {
  final BillerManagementBloc _bloc = inject<BillerManagementBloc>();
  List<BillerCategoryEntity> payBills = [];

  @override
  void initState() {
    super.initState();
    _bloc.add(GetBillerCategoryListEvent());
  }

  /// Build View
  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
            top: kOnBoardingMarginBetweenFields,
            bottom: kBottomMargin,
            left: kLeftRightMarginOnBoarding,
            right: kLeftRightMarginOnBoarding),
        child: BlocProvider<BillerManagementBloc>(
          create: (_) => _bloc,
          child: BlocBuilder<BillerManagementBloc,
              BaseState<BillerManagementState>>(
            builder: (context, state) {
              if (state is GetBillerCategorySuccessState) {
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: state.billerCategoryList.length,
                  itemBuilder: (_, index) => PayBillsComponent(
                    billerCategoryEntity: state.billerCategoryList[index],
                    onTap: () {
                      Navigator.pushNamed(context, Routes.kBillPayeesView,
                          arguments: state.billerCategoryList[index]);
                    },
                  ),
                );
              } else if (state is GetBillerCategoryListFailedState) {
                return ErrorWidget(state.message.toString());
              }
              return Container();
            },
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
