import 'package:cdb_mobile/features/presentation/widgets/cdb_automation_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/services/dependency_injection.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/app_strings.dart';
import '../../../../utils/enums.dart';
import '../../../../utils/navigation_routes.dart';
import '../../../data/models/responses/get_biller_list_response.dart';
import '../../../domain/entities/response/biller_category_entity.dart';
import '../../../domain/entities/response/biller_entity.dart';
import '../../../domain/entities/response/charee_code_entity.dart';
import '../../../domain/entities/response/custom_field_entity.dart';
import '../../../domain/entities/response/saved_biller_entity.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../../bloc/biller_management/biller_management_bloc.dart';
import '../../bloc/biller_management/biller_management_event.dart';
import '../../bloc/biller_management/biller_management_state.dart';
import '../../widgets/cdb_default_appbar.dart';
import '../base_view.dart';
import '../common/empty_view.dart';
import 'widget/saved_biller_component.dart';

class SavedBillerListView extends BaseView {
  @override
  _SavedBillerListViewState createState() => _SavedBillerListViewState();
}

class _SavedBillerListViewState extends BaseViewState<SavedBillerListView> {
  final BillerManagementBloc _bloc = inject<BillerManagementBloc>();

  List<SavedBillerEntity> savedBillers = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      savedBillers.clear();
    });
    _bloc.add(GetSavedBillersEvent());
  }

  initBillerData(List<BillerList> billerList) {
    savedBillers.addAll(
      billerList
          .map(
            (e) => SavedBillerEntity(
                id: e.id,
                nickName: e.nickName,
                userId: e.userId,
                referenceNumber: e.referenceNumber,
                billerCategory: BillerCategoryEntity(
                    categoryName: e.categoryName,
                    categoryCode: e.categoryCode,
                    categoryId: e.categoryId),
                serviceProvider: BillerEntity(
                    billerId: e.serviceProviderId,
                    billerName: e.serviceProviderName,
                    billerCode: e.serviceProviderCode,
                    billerImage: e.imageUrl),
                chargeCodeEntity: ChargeCodeEntity(
                    chargeAmount: e.chargeCode.chargeAmount,
                    chargeCode: e.chargeCode.chargeCode),
                isFavorite: e.isFavourite,
                customFieldEntityList: e.customFieldList
                    .map(
                      (item) => CustomFieldEntity(
                          customFieldId: item.customFieldId.toString(),
                          customFieldName: item.customFieldName,
                          customFieldValue: item.customFieldValue,
                          customFieldDetailsEntity: CustomFieldDetailsEntity(
                              id: item.customFieldDetails.id,
                              length: item.customFieldDetails.length,
                              name: item.customFieldDetails.name,
                              validation: item.customFieldDetails.validation,
                              fieldTypeEntity: FieldTypeEntity(
                                id: item.customFieldDetails.fieldType.id,
                                name: item.customFieldDetails.fieldType.name,
                              ))),
                    )
                    .toList()),
          )
          .toList(),
    );
  }

  /// Build View
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
          listener: (context, state) {
            if (state is GetSavedBillersSuccessState) {
              setState(() {
                savedBillers.clear();
                state.response.billerList.forEach((element) {
                  element.sortId = element.isFavourite ? 0 : 1;
                });
                state.response.billerList
                    .sort((a, b) => a.sortId.compareTo(b.sortId));
                initBillerData(state.response.billerList);
              });
            } else if (state is GetSavedBillersFailedState) {
              setState(() {
                savedBillers.clear();
              });
            }
          },
          child: savedBillers.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.only(
                      top: kOnBoardingMarginBetweenFields,
                      bottom: kBottomMargin,
                      left: kLeftRightMarginOnBoarding,
                      right: kLeftRightMarginOnBoarding),
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: savedBillers.length,
                    itemBuilder: (_, index) => Container(
                      margin: const EdgeInsets.only(bottom: 8), // There i add this.
                      child: Automator(
                        tag: savedBillers[index].nickName,
                        onTap: () async {
                          await Navigator.pushNamed(
                                  context, Routes.kMoreDetailOfBillerView,
                                  arguments: savedBillers[index])
                              .then((value) {
                            if (value != null && value) {
                              _bloc.add(GetSavedBillersEvent());
                            }
                          });
                        },
                        child: SavedBillerComponent(
                          savedBillerEntity: savedBillers[index],
                          onTap: () async {},
                        ),
                      ),
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
                                type: EmptyViewType.BILLER_LIST,
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
        ),
      ),
      floatingActionButton: InkResponse(
        radius: 30,
        onTap: () async {
          await Navigator.pushNamed(context, Routes.kAddBillerView)
              .then((value) {
            _bloc.add(GetSavedBillersEvent());
          });
        },
        child: CircleAvatar(
          radius: 30,
          backgroundColor: AppColors.textDarkColor,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 29,
            child: SvgPicture.asset(AppImages.icFabAdd),
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
