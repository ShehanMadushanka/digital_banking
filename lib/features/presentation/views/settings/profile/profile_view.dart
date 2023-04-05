import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/services/app_permission.dart';
import '../../../../../core/services/dependency_injection.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../../utils/app_strings.dart';
import '../../../../../utils/app_styling.dart';
import '../../../../../utils/enums.dart';
import '../../../../../utils/model/image_cropper.dart';
import '../../../../../utils/navigation_routes.dart';
import '../../../bloc/base_bloc.dart';
import '../../../bloc/base_event.dart';
import '../../../bloc/base_state.dart';
import '../../../bloc/on_boarding/schedule_verification/schedule_verification_bloc.dart';
import '../../../bloc/on_boarding/schedule_verification/schedule_verification_state.dart';
import '../../../widgets/cdb_bottomsheet.dart';
import '../../../widgets/cdb_buttons/cdb_border_gradient_button.dart';
import '../../../widgets/cdb_default_appbar.dart';
import '../../../widgets/cdb_scrollview.dart';
import '../../base_view.dart';
import '../../on_boarding/document_edit_view.dart';
import 'widget/profile_image_component.dart';

class ProfileView extends BaseView {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends BaseViewState<ProfileView> {
  /// Dependency Injection
  final ScheduleVerificationBloc _scheduleVerificationBloc =
      inject<ScheduleVerificationBloc>();

  List<Widget> popUpList = [];

  /// Variables
  String userName;
  String walletId;
  String selectedSelfieImage;

  ///Initialize Bottom Menu Items
  initButtons(BuildContext context) {
    popUpList.clear();
    popUpList.addAll([
      CDBBorderGradientButton(
        width: double.maxFinite,
        backgroundColor: AppColors.separationLinesColor,
        textColor: AppColors.textDarkColor,
        status: ButtonStatus.DISABLE,
        strokeWidth: 0,
        text: AppString.dvButtonCamera.localize(context),
      ),
      CDBBorderGradientButton(
        width: double.maxFinite,
        backgroundColor: AppColors.separationLinesColor,
        textColor: AppColors.textDarkColor,
        status: ButtonStatus.DISABLE,
        strokeWidth: 0,
        text: AppString.dvButtonUpload.localize(context),
      ),
      CDBBorderGradientButton(
        width: double.maxFinite,
        text: AppString.cancel.localize(context),
      ),
    ]);
  }

  initData() {
    userName = 'Sahan Lakshitha';
    walletId = '0023456';
    selectedSelfieImage =
        'https://cultivatedculture.com/wp-content/uploads/2020/08/LinkedIn-Profile-Picture-Photo-Shoot-Featured-Image-736x414.png';
  }

  @override
  void didChangeDependencies() {
    initButtons(context);
    initData();
    super.didChangeDependencies();
  }

  /// Build View
  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: CDBMainAppBar(
        appBarTitle: AppString.titleProfile.localize(context),
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
                  child: CDBScrollView(
                    padding: EdgeInsets.zero,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: ProfileImageComponent(
                            key: const Key('profileImage'),
                            imageURL: selectedSelfieImage,
                            onTap: () {
                              if (selectedSelfieImage != null) {
                                _editData(IDType.SELFIE);
                              } else {
                                _captureImage(IDType.SELFIE);
                              }
                            },
                          ),
                        ),
                        Center(
                          child: Text(
                            userName,
                            style: AppStyling.normal700Size16
                                .copyWith(color: AppColors.textDarkColor),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppString.walletID.localize(context),
                              style: AppStyling.normal400Size14
                                  .copyWith(color: AppColors.textTitleColor),
                            ),
                            Text(
                              walletId,
                              style: AppStyling.normal500Size16
                                  .copyWith(color: AppColors.textDarkColor),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppString.userName.localize(context),
                              style: AppStyling.normal400Size14
                                  .copyWith(color: AppColors.textTitleColor),
                            ),
                            Text(
                              userName,
                              style: AppStyling.normal500Size16
                                  .copyWith(color: AppColors.textDarkColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///Edit Image
  _editData(IDType idType) async {
    String imagePath = selectedSelfieImage;

    final result = await Navigator.pushNamed(
      context,
      Routes.kDocumentEditView,
      arguments: DocumentEditArguments(
          imagePath: imagePath, idType: IDType.SELFIE, isFromProfileView: true),
    );

    if (result != null && result is String) {
      selectedSelfieImage = result;
      setState(() {});
    }
  }

  ///CaptureImage
  _captureImage(IDType idType) {
    CDBBottomSheet.show(
      context: context,
      children: popUpList,
      onTapItem: (item) {
        final popupItem = item as CDBBorderGradientButton;
        if (popupItem.text == AppString.dvButtonCamera.localize(context)) {
          AppPermissionManager.requestCameraPermission(context, () {
            _saveImage(idType);
          });
        } else if (popupItem.text ==
            AppString.dvButtonUpload.localize(context)) {
          AppPermissionManager.requestGalleryPermission(context, () {
            _saveImage(idType, isFromCamera: false);
          });
        }
      },
    );
  }

  _saveImage(IDType idType, {bool isFromCamera = true}) async {
    final XFile file = await ImagePicker().pickImage(
      source: isFromCamera ? ImageSource.camera : ImageSource.gallery,
      imageQuality: 25,
    );
    final File cropped =
        await AppImageCropper().getCroppedImage(PickedFile(file.path));
    final output = cropped.path;

    selectedSelfieImage = output;

    setState(() {});
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return _scheduleVerificationBloc;
  }
}
