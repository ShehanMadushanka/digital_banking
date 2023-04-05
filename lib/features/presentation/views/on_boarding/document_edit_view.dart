import 'dart:io';

import 'package:cdb_mobile/core/services/app_permission.dart';
import 'package:cdb_mobile/features/presentation/bloc/on_boarding/document_verification/document_verification_bloc.dart';
import 'package:cdb_mobile/features/presentation/bloc/on_boarding/document_verification/document_verification_state.dart';
import 'package:cdb_mobile/features/presentation/widgets/cdb_bottomsheet.dart';
import 'package:cdb_mobile/features/presentation/widgets/cdb_buttons/cdb_border_gradient_button.dart';
import 'package:cdb_mobile/utils/app_colors.dart';
import 'package:cdb_mobile/utils/app_strings.dart';
import 'package:cdb_mobile/utils/model/image_cropper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/services/dependency_injection.dart';
import '../../../../utils/enums.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../../widgets/cdb_progress_appbar.dart';
import '../base_view.dart';

class DocumentEditArguments {
  final IDType idType;
  final String imagePath;
  final bool isEditable;
  final bool isFromProfileView;

  DocumentEditArguments({this.idType, this.imagePath, this.isEditable = true, this.isFromProfileView = false});
}

class DocumentEditView extends BaseView {
  final DocumentEditArguments documentEditArguments;

  const DocumentEditView({Key key, this.documentEditArguments}) : super(key: key);

  @override
  _DocumentEditState createState() => _DocumentEditState();
}

class _DocumentEditState extends BaseViewState<DocumentEditView> {
  final _bloc = inject<DocumentVerificationBloc>();

  /// Variables
  String image;
  List<Widget> popUpList = [];

  ///Generate AppBar Title
  String _getAppBarTitle() {
    if(widget.documentEditArguments.isFromProfileView) {
      return AppString.titleProfileImage.localize(context);
    } else {
      switch (widget.documentEditArguments.idType) {
        case IDType.SELFIE:
          return AppString.dvEditSelfieTitle.localize(context);
          break;
        case IDType.ID_FRONT:
          return AppString.dvEditFIDTitle.localize(context);
          break;
        case IDType.ID_BACK:
          return AppString.dvEditBIDTitle.localize(context);
          break;
        case IDType.BILLING_PROOF:
          return AppString.dvEditBillTitle.localize(context);
          break;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    image = widget.documentEditArguments.imagePath;
  }

  ///Initialize Bottom Menu Items
  _initButtons(BuildContext context) {
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

  @override
  void didChangeDependencies() {
    _initButtons(context);
    super.didChangeDependencies();
  }

  @override
  Widget buildView(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, image);
        return false;
      },
      child: Scaffold(
        appBar: CDBProgressAppBar(
          step: KYCStep.DOCUMENTVERIFY,
          showStep: false,
          customAppBarTitle: _getAppBarTitle(),
          onEdit: widget.documentEditArguments.isEditable
              ? () {
                  CDBBottomSheet.show(
                    context: context,
                    children: popUpList,
                    onTapItem: (item) {
                      final popupItem = item as CDBBorderGradientButton;
                      if (popupItem.text == AppString.dvButtonCamera.localize(context)) {
                        AppPermissionManager.requestCameraPermission(context, () {
                          _saveImage();
                        });
                      } else if (popupItem.text == AppString.dvButtonUpload.localize(context)) {
                        AppPermissionManager.requestGalleryPermission(context, () {
                          _saveImage(isFromCamera: false);
                        });
                      }
                    },
                  );
                }
              : null,
          onTapBack: () {
            Navigator.pop(context, image);
          },
        ),
        body: BlocProvider<DocumentVerificationBloc>(
          create: (_) => _bloc,
          child: BlocListener<DocumentVerificationBloc, BaseState<DocumentVerificationState>>(
            bloc: _bloc,
            listener: (_, state) {},
            child: Container(
              height: MediaQuery.of(context).size.height,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(top: 24.0, bottom: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 60,
                    ),
                    Expanded(
                      child: Image.file(
                        File(image),
                        width: double.infinity,
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _saveImage({bool isFromCamera = true}) async {
    final XFile file = await ImagePicker().pickImage(
      source: isFromCamera ? ImageSource.camera : ImageSource.gallery,
      imageQuality: 25,
    );
    final File cropped = await AppImageCropper().getCroppedImage(PickedFile(file.path));
    setState(() {
      image = cropped.path;
    });
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() => _bloc;
}
