import 'package:cdb_mobile/features/presentation/views/payee_management/payee_details_view.dart';
import 'package:cdb_mobile/utils/cdb_icons.dart';
import 'package:cdb_mobile/utils/navigation_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/services/dependency_injection.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/app_strings.dart';
import '../../../../utils/app_styling.dart';
import '../../../domain/entities/response/saved_payee_entity.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../../bloc/biller_management/biller_management_state.dart';
import '../../bloc/payee_management/payee_management_bloc.dart';
import '../../bloc/payee_management/payee_management_event.dart';
import '../../bloc/payee_management/payee_management_state.dart';
import '../../widgets/cdb_default_appbar.dart';
import '../../widgets/cdb_text_fields/cdb_post_login_search_text_field.dart';
import '../base_view.dart';
import '../biller_management/widget/cdb_biller_bottom_app_bar.dart';
import 'widget/saved_payee_component.dart';

class SavedPayeeListView extends BaseView {
  final bool isFromFundTransfer;

  SavedPayeeListView({this.isFromFundTransfer = false});

  @override
  _SavedPayeeListViewState createState() => _SavedPayeeListViewState();
}

class _SavedPayeeListViewState extends BaseViewState<SavedPayeeListView> {
  final PayeeManagementBloc _bloc = inject<PayeeManagementBloc>();
  final searchController = TextEditingController();
  bool isSavedSelected = true;
  bool isDeleteAvailable = false;
  String _searchString = '';
  List<SavedPayeeEntity> savedPayees = [];

  @override
  void initState() {
    super.initState();
    _bloc.add(GetSavedPayeesEvent());
    searchController.addListener(() {
      setState(() {
        _searchString = searchController.text;
      });
    });
  }

  Widget _getItemByFavorite(int index) {
    if (isSavedSelected) {
      return SavedPayeeComponent(
        isDeleteAvailable: isDeleteAvailable,
        savedPayeeEntity: savedPayees[index],
        onTap: () {
          _onTapPayee(savedPayees[index]);
        },
        onLongTap: () {
          _onLongTapPayee(savedPayees[index]);
        },
        onDeleteItem: () {
          _onDeletePayee(savedPayees[index]);
        },
      );
    } else {
      return savedPayees[index].isFavorite
          ? SavedPayeeComponent(
        isDeleteAvailable: isDeleteAvailable,
        savedPayeeEntity: savedPayees[index],
        onTap: () {
          _onTapPayee(savedPayees[index]);
        },
        onLongTap: () {
          _onLongTapPayee(savedPayees[index]);
        },
        onDeleteItem: () {
          _onDeletePayee(savedPayees[index]);
        },
      )
          : const SizedBox.shrink();
    }
  }

  /// Build View
  @override
  Widget buildView(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (isDeleteAvailable) {
          setState(() {
            isDeleteAvailable = false;
            savedPayees.forEach((element) {
              element.isSelected = false;
            });
          });

          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        appBar: CDBMainAppBar(
          appBarTitle: AppString.savedPayeeListTitle.localize(context),
          onTapBack: () {
            if (isDeleteAvailable) {
              setState(() {
                isDeleteAvailable = false;
                savedPayees.forEach((element) {
                  element.isSelected = false;
                });
              });
            } else {
              Navigator.pop(context);
            }
          },
        ),
        body: BlocProvider(
          create: (_) => _bloc,
          child: BlocListener<PayeeManagementBloc,
              BaseState<PayeeManagementState>>(
            listener: (context, state) {
              if (state is GetSavedPayeesSuccessState) {
                setState(() {
                  savedPayees.clear();
                  state.savedPayees
                      .sort((a, b) => a.nickName.compareTo(b.nickName));
                  savedPayees.addAll(state.savedPayees);
                });
              }
              else if (state is GetSavedBillersFailedState) {
                setState(() {
                  savedPayees.clear();
                });
              }
            },
            child: savedPayees.isNotEmpty
                ? Padding(
              padding: const EdgeInsets.only(
                  top: kOnBoardingMarginBetweenFields,
                  bottom: kBottomMargin,
                  left: kLeftRightMarginOnBoarding,
                  right: kLeftRightMarginOnBoarding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CDBPostLoginSearchTextField(
                    shouldShowCancel: false,
                    hintText: AppString.search.localize(context),
                    controller: searchController,
                    searchIconColor: AppColors.textLightColor,
                  ),
                  if (isDeleteAvailable)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 10),
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 15,
                            backgroundColor: AppColors.darkAshColor,
                            child: CircleAvatar(
                              radius: 14,
                              backgroundColor: AppColors.whiteColor,
                              child: Text(
                                savedPayees
                                    .where(
                                        (element) => element.isSelected)
                                    .length
                                    .toString()
                                    .padLeft(2, '0'),
                                style:
                                AppStyling.normal600Size14.copyWith(
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            'Selected',
                            style: AppStyling.bold600Size14
                                .copyWith(color: AppColors.grayColor),
                          )
                        ],
                      ),
                    )
                  else
                    SizedBox(
                      height: 16.h,
                    ),
                  Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: savedPayees.length,
                      shrinkWrap: true,
                      itemBuilder: (_, index) => _searchString.isEmpty
                          ? _getItemByFavorite(index)
                          : savedPayees[index]
                          .nickName
                          .toLowerCase()
                          .contains(_searchString.toLowerCase())
                          ? _getItemByFavorite(index)
                          : const SizedBox.shrink(),
                    ),
                  ),
                ],
              ),
            )
                : Center(
              child: Wrap(
                direction: Axis.vertical,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  SvgPicture.asset(
                    AppImages.icAddPayee,
                    height: 60.h,
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Text(
                    AppString.noPayeeTitle.localize(context),
                    style: AppStyling.normal600Size16
                        .copyWith(color: AppColors.textDarkColor),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  Text(
                    AppString.noPayeeDesc.localize(context),
                    textAlign: TextAlign.center,
                    style: AppStyling.normal300Size13
                        .copyWith(color: AppColors.textTitleColor),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: InkResponse(
          onTap: () async {
            Navigator.pushNamed(context, Routes.kAddPayeeView,arguments: savedPayees[1]);
          },
          child: Container(
            width: 58.w,
            height: 58.h,
            decoration: BoxDecoration(
              gradient: AppColors.fabGradient,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Icon(
              Icons.add,
              color: AppColors.whiteColor,
              size: 32.h,
            ),
          ),
        ),
        bottomNavigationBar: savedPayees.isNotEmpty ? _getBottpnSheet() : null,
      ),
    );
  }

  _onTapPayee(SavedPayeeEntity savedPayeeEntity) {
    if (widget.isFromFundTransfer) {
      Navigator.pop(context, savedPayeeEntity);
    } else {
      if (isDeleteAvailable) {
        if (savedPayees.where((element) => element.isSelected).length == 1 &&
            savedPayeeEntity.isSelected == true) {
          setState(() {
            savedPayeeEntity.isSelected = false;
            isDeleteAvailable = false;
          });
        } else {
          setState(() {
            savedPayeeEntity.isSelected = !savedPayeeEntity.isSelected;
          });
        }
      } else {
        Navigator.of(context).pushNamed(Routes.kPayeeDetailsView,
            arguments: savedPayeeEntity);
      }
    }
  }

  _onLongTapPayee(SavedPayeeEntity savedPayeeEntity) {
    if (!widget.isFromFundTransfer) {
      try {
        HapticFeedback.lightImpact();
      } catch (e) {}
      setState(() {
        isDeleteAvailable = true;
        savedPayeeEntity.isSelected = true;
      });
    }
  }

  _onDeletePayee(SavedPayeeEntity savedPayeeEntity) {
    showCDBDialog(
      title: AppString.titleDeletePayee.localize(context),
      body: Column(
        children: [
          Text(AppString.descriptionDeletePayee.localize(context)),
        ],
      ),
      isTwoButton: true,
      alertImagePath: AppImages.icAlertConfirm,
      positiveButtonText: AppString.buttonYesDelete.localize(context),
      positiveButtonTap: () {},
      negativeButtonText: AppString.cancel.localize(context),
      negativeButtonTap: () {},
    );
  }

  _getBottpnSheet() {
    if (isDeleteAvailable) {
      return CDBBillerBottomAppBar(
        onTapOne: () {
          setState(() {
            savedPayees.forEach((element) {
              element.isSelected = true;
            });
          });
        },
        inkWell: true,
        iconPathOne: AppImages.icSelectAll,
        iconNameOne: 'Select All',
        iconNameTwo: '',
        onTapThree: () {
          showCDBDialog(
            title: AppString.titleDeletePayees.localize(context),
            body: Column(
              children: [
                Text(AppString.descriptionDeletePayees.localize(context)),
              ],
            ),
            isTwoButton: true,
            alertImagePath: AppImages.icAlertConfirm,
            positiveButtonText: AppString.buttonYesDelete.localize(context),
            positiveButtonTap: () {},
            negativeButtonText: AppString.cancel.localize(context),
            negativeButtonTap: () {},
          );
        },
        iconPathThree: AppImages.icTrash,
        iconNameThree: 'Delete',
        iconTwo: null,
      );
    } else {
      return CDBBillerBottomAppBar(
        onTapOne: () {
          setState(() {
            isSavedSelected = true;
          });
        },
        inkWell: true,
        iconOne: isSavedSelected
            ? CDBIcons.ic_save_filled
            : CDBIcons.ic_save_unfilled,
        iconNameOne: 'Saved',
        iconNameTwo: '',
        onTapThree: () {
          setState(() {
            isSavedSelected = false;
          });
        },
        iconThree: isSavedSelected ? Icons.favorite_border : Icons.favorite,
        iconNameThree: 'Favourites',
        iconTwo: null,
      );
    }
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return _bloc;
  }
}
