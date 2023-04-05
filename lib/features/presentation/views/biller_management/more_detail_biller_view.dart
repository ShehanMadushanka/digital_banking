import 'package:cdb_mobile/features/presentation/widgets/cdb_toast/cdb_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/services/dependency_injection.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_strings.dart';
import '../../../../utils/app_styling.dart';
import '../../../../utils/app_utils.dart';
import '../../../../utils/cdb_icons.dart';
import '../../../../utils/navigation_routes.dart';
import '../../../domain/entities/response/saved_biller_entity.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../../bloc/biller_management/biller_management_bloc.dart';
import '../../bloc/biller_management/biller_management_event.dart';
import '../../bloc/biller_management/biller_management_state.dart';
import '../../widgets/cdb_default_appbar.dart';
import '../base_view.dart';
import 'widget/cdb_biller_bottom_app_bar.dart';

class MoreDetailOfBillerView extends BaseView {
  final SavedBillerEntity savedBillerEntity;

  MoreDetailOfBillerView({this.savedBillerEntity});

  @override
  _MoreDetailOfBillerViewState createState() => _MoreDetailOfBillerViewState();
}

class _MoreDetailOfBillerViewState
    extends BaseViewState<MoreDetailOfBillerView> {
  final BillerManagementBloc _bloc = inject<BillerManagementBloc>();
  bool isUpdated = false;

  @override
  Widget buildView(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, isUpdated);
        return false;
      },
      child: Scaffold(
        appBar: CDBMainAppBar(
          appBarTitle: AppString.titleBillers.localize(context),
          onTapBack: () {
            Navigator.pop(context, isUpdated);
          },
        ),
        body: BlocProvider<BillerManagementBloc>(
          create: (_) => _bloc,
          child: BlocListener<BillerManagementBloc,
              BaseState<BillerManagementState>>(
            listener: (context, state) {
              if (state is DeleteBillerSuccessState) {
                ToastUtils.showCustomToast(
                    context,
                    AppString.deleteBillerSuccess.localize(context),
                    ToastStatus.success);

                Navigator.pop(
                  context,
                  true,
                );
              } else if (state is FavouriteBillerSuccessState) {
                setState(() {
                  widget.savedBillerEntity.isFavorite = true;
                  isUpdated = true;
                });
              } else if (state is UnFavouriteBillerSuccessState) {
                setState(() {
                  widget.savedBillerEntity.isFavorite = false;
                  isUpdated = true;
                });
              } else if (state is FavouriteBillerFailedState) {
                setState(() {
                  widget.savedBillerEntity.isFavorite = false;
                });
                ToastUtils.showCustomToast(
                    context, state.message, ToastStatus.fail);
              } else if (state is UnFavouriteBillerFailedState) {
                setState(() {
                  widget.savedBillerEntity.isFavorite = true;
                });
                ToastUtils.showCustomToast(
                    context, state.message, ToastStatus.fail);
              } else if (state is DeleteBillerFailedState) {
                ToastUtils.showCustomToast(
                    context, state.message, ToastStatus.fail);
              }
            },
            child: Container(
              color: AppColors.whiteColor,
              child: Container(
                width: double.infinity,
                color: AppColors.whiteColor,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Column(
                      children: [
                        Container(
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
                        const SizedBox(height: 20),
                        Text(
                          widget.savedBillerEntity.nickName,
                          style: AppStyling.normal600Size14
                              .copyWith(color: AppColors.textDarkColor),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    Container(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppString.billerCategory.localize(context),
                                style: AppStyling.normal400Size14
                                    .copyWith(color: AppColors.textTitleColor),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                  widget.savedBillerEntity.billerCategory
                                      .categoryName,
                                  style: AppStyling.normal500Size16
                                      .copyWith(color: AppColors.textDarkColor),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                AppString.serviceProvider.localize(context),
                                style: AppStyling.normal400Size14
                                    .copyWith(color: AppColors.textTitleColor),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                  widget.savedBillerEntity.serviceProvider
                                      .billerName,
                                  style: AppStyling.normal500Size16
                                      .copyWith(color: AppColors.textDarkColor),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: AppUtils().generateDynamicFields(
                                  context,
                                  widget.savedBillerEntity
                                          .customFieldEntityList ??
                                      List.empty(),
                                  fieldType: fieldTypeLableField,
                                  labelTextColor: AppColors.textDarkColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: CDBBillerBottomAppBar(
          onTapOne: () {
            if (widget.savedBillerEntity.isFavorite) {
              _bloc.add(
                  UnFavoriteBillerEvent(billerId: widget.savedBillerEntity.id));
            } else {
              _bloc.add(
                  FavouriteBillerEvent(billerId: widget.savedBillerEntity.id));
            }
          },
          inkWell: true,
          iconOne: widget.savedBillerEntity.isFavorite
              ? Icons.favorite
              : Icons.favorite_border,
          iconNameOne: 'Favourite',
          onTapTwo: () {
            Navigator.pushNamed(context, Routes.kEditBillerView,
                arguments: widget.savedBillerEntity);
          },
          iconTwo: CDBIcons.ic_info_edit,
          iconNameTwo: 'Edit',
          onTapThree: () {
            showCDBDialog(
              isTwoButton: true,
              title: AppString.deleteSaved.localize(context),
              body: Column(
                children: [
                  Text(AppString.deleteBillerDes.localize(context)),
                ],
              ),
              positiveButtonText: AppString.delete.localize(context),
              positiveButtonTap: () {
                _bloc.add(
                    DeleteBillerEvent(billerId: widget.savedBillerEntity.id));
              },
              negativeButtonText: AppString.cancel.localize(context),
              negativeButtonTap: () {
                Navigator.pop(context);
              },
            );
          },
          iconThree: CDBIcons.ic_delete,
          iconNameThree: 'Delete',
        ),
      ),
    );
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return _bloc;
  }
}
