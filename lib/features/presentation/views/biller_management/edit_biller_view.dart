import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/services/dependency_injection.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_strings.dart';
import '../../../../utils/app_styling.dart';
import '../../../../utils/app_utils.dart';
import '../../../../utils/navigation_routes.dart';
import '../../../domain/entities/response/saved_biller_entity.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../../bloc/biller_management/biller_management_bloc.dart';
import '../../bloc/biller_management/biller_management_state.dart';
import '../../widgets/cdb_buttons/cdb_border_gradient_button.dart';
import '../../widgets/cdb_buttons/cdb_no_border_background_button.dart';
import '../../widgets/cdb_default_appbar.dart';
import '../../widgets/cdb_text_fields/cdb_text_field.dart';
import '../base_view.dart';

class EditBillerView extends BaseView {
  final SavedBillerEntity savedBillerEntity;

  EditBillerView({this.savedBillerEntity});

  @override
  _EditBillerViewState createState() => _EditBillerViewState();
}

class _EditBillerViewState extends BaseViewState<EditBillerView> {
  final BillerManagementBloc _bloc = inject<BillerManagementBloc>();

  String nickName;

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: CDBMainAppBar(
        appBarTitle: AppString.titleBillers.localize(context),
        onTapBack: () {
          Navigator.pop(context);
        },
      ),
      body: BlocProvider(
        create: (_) => _bloc,
        child: BlocListener<BillerManagementBloc,
            BaseState<BillerManagementState>>(
          listener: (context, state) {},
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(
                  left: kLeftRightMarginOnBoarding,
                  right: kLeftRightMarginOnBoarding,
                  top: kTopMarginOnBoarding,
                ),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 25.0),
                              child: Icon(
                                widget.savedBillerEntity.isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: AppColors.textLightColor, width: 0.5),
                              color: AppColors.whiteColor,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 0.2,
                                  blurRadius: 7, // changes position of shadow
                                ),
                              ],
                            ),
                            width: 150,
                            height: 90,
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Image.network(
                                widget.savedBillerEntity.serviceProvider
                                    .billerImage,
                                width: 50.w,
                                height: 50.h,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Expanded(
                child: SingleChildScrollView(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: kLeftRightMarginOnBoarding,
                        right: kLeftRightMarginOnBoarding,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CdbCustomTextField(
                            key: const Key("keyMobileNumber"),
                            labelText: AppString.nickName.localize(context),
                            maxLength: 10,
                            initialValue: widget.savedBillerEntity.nickName,
                            onChange: (value) {
                              setState(() {
                                widget.savedBillerEntity.nickName = value;
                              });
                            },
                          ),
                          const SizedBox(height: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: AppUtils().generateDynamicFields(
                              context,
                              widget.savedBillerEntity.customFieldEntityList ??
                                  List.empty(),
                                fieldType: fieldTypeLableField
                            ),
                          ),
                          Text(
                            AppString.serviceProvider.localize(context),
                            style: AppStyling.normal400Size14
                                .copyWith(color: AppColors.textTitleColor),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              widget
                                  .savedBillerEntity.serviceProvider.billerName,
                              style: AppStyling.normal500Size16
                                  .copyWith(color: AppColors.textLightColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // Spacer(flex: 2,),
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
                        Navigator.pushNamed(
                            context, Routes.kEditBillerConfirmView,
                            arguments: widget.savedBillerEntity);
                      },
                      text: AppString.save.localize(context),
                    ),
                    CDBNoBorderBackgroundButton(
                      onTap: () {
                        Navigator.pushNamed(
                            context, Routes.kSavedBillerListView);
                      },
                      text: AppString.cancel.localize(context),
                    ),
                  ],
                ),
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
