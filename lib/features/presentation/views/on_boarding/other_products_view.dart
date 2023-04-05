import 'package:cdb_mobile/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/services/dependency_injection.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_strings.dart';
import '../../../../utils/app_styling.dart';
import '../../../../utils/navigation_routes.dart';
import '../../../data/models/responses/get_other_products_response.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../../bloc/on_boarding/other_products/other_products_bloc.dart';
import '../../bloc/on_boarding/other_products/other_products_event.dart';
import '../../bloc/on_boarding/other_products/other_products_state.dart';
import '../../widgets/cdb_buttons/cdb_border_gradient_button.dart';
import '../../widgets/cdb_buttons/cdb_no_border_background_button.dart';
import '../../widgets/cdb_check_box_view.dart';
import '../../widgets/cdb_header_underline.dart';
import '../../widgets/cdb_scrollview.dart';
import '../../widgets/cdb_toast/cdb_toast.dart';
import '../base_view.dart';

class OtherProductsView extends BaseView {
  const OtherProductsView({Key key}) : super(key: key);

  @override
  _OtherProductsViewState createState() => _OtherProductsViewState();
}

class _OtherProductsViewState extends BaseViewState<OtherProductsView> {
  final OtherProductsBloc _bloc = inject<OtherProductsBloc>();
  List<OtherProductsData> otherProductsData = [];

  @override
  void initState() {
    super.initState();
    _bloc.add(GetOtherProductsEvent());
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => _bloc,
        child: BlocListener<OtherProductsBloc, BaseState<OtherProductsState>>(
          bloc: _bloc,
          listener: (context, state) {
            if (state is GetOtherProductsLoadedState) {
              setState(() {
                otherProductsData.clear();
                otherProductsData.addAll(state.data
                    .where((element) => element.status == 'active')
                    .toList());
              });
            } else if (state is GetOtherProductsFailedState) {
              ToastUtils.showCustomToast(
                  context, state.message, ToastStatus.fail);
            } else if (state is SubmitOtherProductSuccessState) {
              _bloc.add(SaveOtherProductsEvent());
            } else if (state is SubmitOtherProductFailedState) {
              ToastUtils.showCustomToast(
                  context, state.message, ToastStatus.fail);
            } else if (state is SaveOtherProductsSuccessState) {
              _bloc.add(SaveUserEvent());
            } else if (state is SaveUserSuccessState) {
              Navigator.pushReplacementNamed(
                  context, Routes.kSecurityQuestionsView);
            } else if (state is SaveUserFailedState) {
              ToastUtils.showCustomToast(
                  context, state.message, ToastStatus.fail);
            }
          },
          child: Padding(
            padding: EdgeInsets.only(
              top: 68.h,
              bottom: kBottomMargin,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: CDBScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppString.otherProducts.localize(context),
                          style: AppStyling.normal500Size16
                              .copyWith(color: AppColors.textDarkColor),
                        ),
                        const Padding(
                            padding: EdgeInsets.only(top: 2),
                            child: CdbHeaderUnderline()),
                        const SizedBox(
                          height: 13,
                        ),
                        Text(
                          AppString.addMoreProducts.localize(context),
                          style: AppStyling.normal400Size14
                              .copyWith(color: AppColors.textDarkColor),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Column(
                          children: _generateProductUIList(otherProductsData),
                        )
                      ],
                    ),
                  ),
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
                        status: otherProductsData
                                .where((element) => element.isSelected)
                                .isNotEmpty
                            ? ButtonStatus.ENABLE
                            : ButtonStatus.DISABLE,
                        onTap: () {
                          _bloc.add(
                            SubmitOtherProductsEvent(
                                data: otherProductsData
                                    .where((element) => element.isSelected)
                                    .map((e) => e.id)
                                    .toList()),
                          );
                        },
                        text: AppString.next.localize(context),
                      ),
                      CDBNoBorderBackgroundButton(
                        onTap: () {
                          _bloc.add(SaveUserEvent());
                        },
                        text: AppString.skip.localize(context),
                      ),
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

  List<Widget> _generateProductUIList(
      List<OtherProductsData> otherProductsData) {
    final List<Widget> widgets = [];
    otherProductsData.forEach((item) {
      widgets.add(CdbCheckBoxView(
        label: item.description,
        value: item.isSelected,
        onTap: () {
          setState(() {
            item.isSelected = !item.isSelected;
          });
        },
      ));
      widgets.add(
        const SizedBox(
          height: 24,
        ),
      );
    });
    return widgets;
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return _bloc;
  }
}
