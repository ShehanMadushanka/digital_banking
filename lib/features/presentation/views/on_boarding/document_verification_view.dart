import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/services/app_permission.dart';
import '../../../../core/services/dependency_injection.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_extensions.dart';
import '../../../../utils/app_strings.dart';
import '../../../../utils/app_styling.dart';
import '../../../../utils/enums.dart';
import '../../../../utils/model/image_cropper.dart';
import '../../../../utils/navigation_routes.dart';
import '../../../data/models/requests/document_verification_request.dart';
import '../../../data/models/requests/wallet_onboarding_data.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../../bloc/on_boarding/document_verification/document_verification_bloc.dart';
import '../../bloc/on_boarding/document_verification/document_verification_event.dart';
import '../../bloc/on_boarding/document_verification/document_verification_state.dart';
import '../../widgets/cdb_bottomsheet.dart';
import '../../widgets/cdb_buttons/cdb_border_gradient_button.dart';
import '../../widgets/cdb_buttons/cdb_no_border_background_button.dart';
import '../../widgets/cdb_id_capture.dart';
import '../../widgets/cdb_progress_appbar.dart';
import '../../widgets/cdb_radio_button.dart';
import '../../widgets/cdb_scrollview.dart';
import '../../widgets/cdb_toast/cdb_toast.dart';
import '../base_view.dart';
import 'document_edit_view.dart';

class DocumentVerificationView extends BaseView {
  final bool isEditingEnabled;

  const DocumentVerificationView({Key key, this.isEditingEnabled})
      : super(key: key);

  @override
  _DocumentVerificationViewState createState() =>
      _DocumentVerificationViewState();
}

class _DocumentVerificationViewState
    extends BaseViewState<DocumentVerificationView> {
  /// Dependency Injection
  final DocumentVerificationBloc _documentVerificationBloc =
      inject<DocumentVerificationBloc>();

  /// Variables
  String selectedProofType;
  String selectedSelfieImage;
  String selectedFrontIdImage;
  String selectedBackIdImage;
  String selectedBillingImage;
  bool shouldUploadBillingProof = false;
  List<Widget> popUpList = [];

  // Initial Variables
  String initialProofType;
  String initialSelfieImage;
  String initialFrontIdImage;
  String initialBackIdImage;
  String initialBillingImage;

  DocumentVerificationRequest _initialData;

  /// Init State
  @override
  void initState() {
    _documentVerificationBloc.add(GetDocumentVerificationInformationEvent());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    initButtons(context);
    super.didChangeDependencies();
  }

  /// Build View
  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: widget.isEditingEnabled
          ? CDBProgressAppBar(
              step: KYCStep.DOCUMENTVERIFY,
              onTapBack: _handleBackClick,
              showStep: false,
            )
          : CDBProgressAppBar(
              step: KYCStep.DOCUMENTVERIFY,
              onTapBack: _handleBackClick,
            ),
      body: BlocProvider(
        create: (_) => _documentVerificationBloc,
        child: BlocListener<DocumentVerificationBloc,
            BaseState<DocumentVerificationState>>(
          listener: (context, state) {
            if (state is DocumentVerificationInformationFailedState) {
              debugPrint(state.message);
            } else if (state is DocumentVerificationInformationLoadedState) {
              getDataFromDataSource(state.walletOnBoardingData);
            } else if (state
                is DocumentVerificationInformationSubmittedSuccessState) {
              if (state.isBackButtonClick) {
                Navigator.pushReplacementNamed(context, Routes.kRegProgress);
              } else {
                if (widget.isEditingEnabled) {
                  Navigator.pop(context, true);
                } else {
                  Navigator.pushReplacementNamed(context, Routes.kReviewView);
                }
              }
            } else if (state is DocumentVerificationAPIFailedState) {
              ToastUtils.showCustomToast(
                  context, state.message, ToastStatus.fail);
            } else if (state is DocumentVerificationAPISuccessState) {
              _onTap();
            }
          },
          child: WillPopScope(
            onWillPop: () async {
              _handleBackClick();
              return false;
            },
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
                          Text(
                            AppString.selfieImage.localize(context),
                            style: AppStyling.normal400Size14
                                .copyWith(color: AppColors.textTitleColor),
                          ),
                          const SizedBox(
                            height: 19,
                          ),
                          Center(
                            child: IdCapture(
                              key: Key(initialSelfieImage),
                              idType: IDType.SELFIE,
                              image: selectedSelfieImage,
                              onTap: () {
                                if (selectedSelfieImage != null) {
                                  _editData(IDType.SELFIE);
                                } else {
                                  _captureImage(IDType.SELFIE);
                                }
                              },
                              onDelete: () {
                                _deleteImage(IDType.SELFIE);
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 42,
                          ),
                          CdbCustomRadioButton(
                            radioLabel: AppString.dvIdSelectionDescription
                                .localize(context),
                            key:
                                Key(selectedProofType ?? "selectedProfileType"),
                            initialValue: selectedProofType ?? 'nic',
                            radioButtonDataList: List.from([
                              RadioButtonModel(
                                label: AppString.radioNIC.localize(context),
                                value: "nic",
                              ),
                              RadioButtonModel(
                                label: AppString.radioDriving.localize(context),
                                value: "driving",
                              ),
                              RadioButtonModel(
                                label:
                                    AppString.radioPassport.localize(context),
                                value: "passport",
                              ),
                            ]),
                            widgetInMiddle: Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Row(
                                children: [
                                  const Spacer(),
                                  IdCapture(
                                    idType: IDType.ID_FRONT,
                                    image: selectedFrontIdImage,
                                    onTap: () {
                                      if (selectedFrontIdImage != null) {
                                        _editData(IDType.ID_FRONT);
                                      } else {
                                        _captureImage(IDType.ID_FRONT);
                                      }
                                    },
                                    onDelete: () {
                                      _deleteImage(IDType.ID_FRONT);
                                    },
                                  ),
                                  const Spacer(),
                                  if (selectedProofType == 'nic')
                                    IdCapture(
                                      idType: IDType.ID_BACK,
                                      image: selectedBackIdImage,
                                      onTap: () {
                                        if (selectedBackIdImage != null) {
                                          _editData(IDType.ID_BACK);
                                        } else {
                                          _captureImage(IDType.ID_BACK);
                                        }
                                      },
                                      onDelete: () {
                                        _deleteImage(IDType.ID_BACK);
                                      },
                                    )
                                  else
                                    const SizedBox.shrink(),
                                  if (selectedProofType == 'nic')
                                    const Spacer(),
                                ],
                              ),
                            ),
                            onChange: (value) {
                              setState(() {
                                selectedProofType = value;
                              });
                            },
                          ),
                          if (shouldUploadBillingProof)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 25,
                                ),
                                Text(
                                  AppString.dvProofAddress.localize(context),
                                  style: AppStyling.normal400Size14.copyWith(
                                      color: AppColors.textTitleColor),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  AppString.dvAcceptedDoc.localize(context),
                                  style: AppStyling.normal400Size14.copyWith(
                                    color: AppColors.textDarkColor,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(25.0),
                                    child: IdCapture(
                                      key: Key(initialBillingImage),
                                      image: selectedBillingImage,
                                      idType: IDType.BILLING_PROOF,
                                      onTap: () {
                                        if (selectedBillingImage != null) {
                                          _editData(IDType.BILLING_PROOF);
                                        } else {
                                          _captureImage(IDType.BILLING_PROOF);
                                        }
                                      },
                                      onDelete: () {
                                        _deleteImage(IDType.BILLING_PROOF);
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            )
                          else
                            const SizedBox.shrink()
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
                          status: _isValidated()
                              ? ButtonStatus.ENABLE
                              : ButtonStatus.DISABLE,
                          onTap: () {
                            _documentVerificationBloc.add(
                              SendDocumentVerificationInformationEvent(
                                  selfie: selectedSelfieImage,
                                  icFront: selectedFrontIdImage,
                                  icBack: selectedBackIdImage,
                                  billingProof: selectedBillingImage,
                                  proofType: selectedProofType),
                            );
                          },
                          text: widget.isEditingEnabled
                              ? 'Save and Review'
                              : AppString.next.localize(context),
                        ),
                        CDBNoBorderBackgroundButton(
                          onTap: _handleBackClick,
                          text: widget.isEditingEnabled
                              ? 'Go Back to Review'
                              : AppString.completeLater.localize(context),
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
    );
  }

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

  ///SaveImage
  _saveImage(IDType idType, {bool isFromCamera = true}) async {
    final XFile file = await ImagePicker().pickImage(
        source: isFromCamera ? ImageSource.camera : ImageSource.gallery,
        imageQuality: 25,
        maxHeight: 480,
        maxWidth: idType == IDType.SELFIE ? 480 : 640);
    final File cropped =
        await AppImageCropper().getCroppedImage(PickedFile(file.path));
    final output = cropped.path;

    switch (idType) {
      case IDType.SELFIE:
        selectedSelfieImage = output;
        break;
      case IDType.ID_FRONT:
        selectedFrontIdImage = output;
        break;
      case IDType.ID_BACK:
        selectedBackIdImage = output;
        break;
      case IDType.BILLING_PROOF:
        selectedBillingImage = output;
        break;
    }

    setState(() {});
  }

  ///Delete Image
  _deleteImage(IDType idType) {
    switch (idType) {
      case IDType.SELFIE:
        selectedSelfieImage = null;
        break;
      case IDType.ID_FRONT:
        selectedFrontIdImage = null;
        break;
      case IDType.ID_BACK:
        selectedBackIdImage = null;
        break;
      case IDType.BILLING_PROOF:
        selectedBillingImage = null;
        break;
    }

    setState(() {});
  }

  ///Edit Image
  _editData(IDType idType) async {
    String imagePath;
    switch (idType) {
      case IDType.SELFIE:
        imagePath = selectedSelfieImage;
        break;
      case IDType.ID_FRONT:
        imagePath = selectedFrontIdImage;
        break;
      case IDType.ID_BACK:
        imagePath = selectedBackIdImage;
        break;
      case IDType.BILLING_PROOF:
        imagePath = selectedBillingImage;
        break;
    }

    final result = await Navigator.pushNamed(
      context,
      Routes.kDocumentEditView,
      arguments: DocumentEditArguments(imagePath: imagePath, idType: idType),
    );

    if (result != null && result is String) {
      switch (idType) {
        case IDType.SELFIE:
          selectedSelfieImage = result;
          break;
        case IDType.ID_FRONT:
          selectedFrontIdImage = result;
          break;
        case IDType.ID_BACK:
          selectedBackIdImage = result;
          break;
        case IDType.BILLING_PROOF:
          selectedBillingImage = result;
          break;
      }

      setState(() {});
    }
  }

  /// Validate
  bool _isValidated() {
    bool iDValidated = false;
    bool billValidated = true;

    if (selectedProofType != null &&
        selectedProofType != "" &&
        selectedSelfieImage != null &&
        selectedSelfieImage != "" &&
        selectedFrontIdImage != null &&
        selectedFrontIdImage != "") {
      if (selectedProofType != null && selectedProofType == 'nic') {
        if (selectedBackIdImage != null && selectedBackIdImage != '') {
          iDValidated = true;
        } else {
          iDValidated = false;
        }
      } else {
        iDValidated = true;
      }

      if (shouldUploadBillingProof) {
        if (selectedBillingImage != null && selectedBillingImage != "") {
          billValidated = true;
        } else {
          billValidated = false;
        }
      } else {
        billValidated = true;
      }
    } else {
      return false;
    }

    return iDValidated && billValidated;
  }

  /// On Next Tap
  void _onTap() {
    if (_isValidated()) {
      storeDataAndStepperValue(
          isBackButtonClick: false,
          stepName: KYCStep.REVIEW.toString(),
          stepVal: KYCStep.REVIEW.getStep());
    }
  }

  /// Handle Back Click
  void _handleBackClick() {
    if (widget.isEditingEnabled) {
      if (selectedProofType != _initialData.proofType ||
          selectedSelfieImage != _initialData.selfie ||
          selectedFrontIdImage != _initialData.icFront ||
          selectedBackIdImage != _initialData.icBack ||
          selectedBillingImage != _initialData.billingProof) {
        showCDBDialog(
          title: 'Changes will be Lost',
          isTwoButton: true,
          body: Column(
            children: const [
              Text(
                  'We noticed you changed something.\nWant to go back without saving your changes ?'),
            ],
          ),
          negativeButtonText: AppString.cancel.localize(context),
          negativeButtonTap: () {},
          positiveButtonText: 'Yes, Go Back',
          positiveButtonTap: () async {
            Navigator.pop(context, false);
          },
        );
      } else {
        Navigator.pop(context, false);
      }
    } else {
      showCDBDialog(
        title: AppString.leaveRegForm.localize(context),
        isTwoButton: true,
        body: Column(
          children: const [
            Text(
                'Do you want to leave the registration form? \n\nNote: All the data that you entered will be saved. You can continue from where you left at later convenient time.'),
          ],
        ),
        negativeButtonText: AppString.cancel.localize(context),
        negativeButtonTap: () {},
        positiveButtonText: AppString.saveExit.localize(context),
        positiveButtonTap: () {
          storeDataAndStepperValue(
              isBackButtonClick: true,
              stepName: KYCStep.DOCUMENTVERIFY.toString(),
              stepVal: KYCStep.DOCUMENTVERIFY.getStep());
        },
      );
    }
  }

  /// Store data and stepper value
  void storeDataAndStepperValue(
      {bool isBackButtonClick, String stepName, int stepVal}) {
    final DocumentVerificationRequest documentVerificationRequest =
        DocumentVerificationRequest(
            selfie: selectedSelfieImage,
            billingProof: selectedBillingImage,
            icBack: selectedBackIdImage,
            icFront: selectedFrontIdImage,
            proofType: selectedProofType);
    _documentVerificationBloc.add(StoreDocumentVerificationInformationEvent(
        stepName: stepName,
        stepValue: stepVal,
        documentVerificationRequest: documentVerificationRequest,
        isBackButtonClick: isBackButtonClick));
  }

  /// Load Data From Data Source
  void getDataFromDataSource(WalletOnBoardingData walletOnBoardingData) {
    if (walletOnBoardingData != null) {
      if (walletOnBoardingData.walletUserData != null) {
        if (walletOnBoardingData.walletUserData.documentVerificationRequest !=
            null) {
          final DocumentVerificationRequest documentVerificationRequest =
              walletOnBoardingData.walletUserData.documentVerificationRequest;
          _initialData =
              walletOnBoardingData.walletUserData.documentVerificationRequest;
          setState(() {
            selectedProofType = documentVerificationRequest.proofType ?? 'nic';
            selectedSelfieImage = documentVerificationRequest.selfie;
            selectedFrontIdImage = documentVerificationRequest.icFront;
            selectedBackIdImage = documentVerificationRequest.icBack;
            selectedBillingImage = documentVerificationRequest.billingProof;

            initialProofType = documentVerificationRequest.proofType ?? 'nic';
            initialSelfieImage =
                documentVerificationRequest.selfie ?? 'initialSelfieImage';
            initialFrontIdImage =
                documentVerificationRequest.icFront ?? 'initialFrontIdImage';
            initialBackIdImage =
                documentVerificationRequest.icBack ?? 'initialBackIdImage';
            initialBillingImage = documentVerificationRequest.billingProof ??
                'initialBillingImage';

            shouldUploadBillingProof = walletOnBoardingData.walletUserData
                    .customerRegistrationRequest.perAddress[0].equalityWithNic
                    .toString() ==
                'false';
          });
        } else {
          setState(() {
            selectedProofType = 'nic';
            shouldUploadBillingProof = walletOnBoardingData.walletUserData
                    .customerRegistrationRequest.perAddress[0].equalityWithNic
                    .toString() ==
                'false';
          });
        }
      }
    }
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return _documentVerificationBloc;
  }
}
