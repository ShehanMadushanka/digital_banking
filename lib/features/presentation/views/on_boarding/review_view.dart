import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/dependency_injection.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_extensions.dart';
import '../../../../utils/app_strings.dart';
import '../../../../utils/app_styling.dart';
import '../../../../utils/cdb_icons.dart';
import '../../../../utils/enums.dart';
import '../../../../utils/navigation_routes.dart';
import '../../../data/models/requests/wallet_onboarding_data.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../../bloc/on_boarding/review/review_bloc.dart';
import '../../bloc/on_boarding/review/review_event.dart';
import '../../bloc/on_boarding/review/review_state.dart';
import '../../widgets/cdb_buttons/cdb_border_gradient_button.dart';
import '../../widgets/cdb_progress_appbar.dart';
import '../../widgets/cdb_scrollview.dart';
import '../../widgets/cdb_toast/cdb_toast.dart';
import '../base_view.dart';
import '../otp/otp_view.dart';
import 'document_edit_view.dart';

class ReviewView extends BaseView {
  const ReviewView({Key key}) : super(key: key);

  @override
  _ReviewViewState createState() => _ReviewViewState();
}

class _ReviewViewState extends BaseViewState<ReviewView> {
  final _bloc = inject<ReviewBloc>();
  WalletOnBoardingData _walletData;

  @override
  void initState() {
    super.initState();
    _fetchData(initialFetch: true);
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: CDBProgressAppBar(
        step: KYCStep.REVIEW,
        showStep: false,
        onTapBack: () {
          Navigator.pushReplacementNamed(context, Routes.kRegProgress);
        },
      ),
      body: BlocProvider<ReviewBloc>(
        create: (_) => _bloc,
        child: BlocListener<ReviewBloc, BaseState<ReviewState>>(
          bloc: _bloc,
          listener: (_, state) {
            if (state is ReviewInfoLoadedState) {
              log(state.walletOnBoardingData.toJson().toString());
              setState(() {
                _walletData = state.walletOnBoardingData;
              });
            } else if (state is ReviewInfoFailedState) {
              log(state.message);
            } else if (state is SaveReviewInfoSuccessEvent) {
              Navigator.pushReplacementNamed(context, Routes.kOtherProducts);
            }
          },
          child: WillPopScope(
            onWillPop: () async {
              Navigator.pushReplacementNamed(context, Routes.kRegProgress);
              return false;
            },
            child: Container(
              height: MediaQuery.of(context).size.height,
              color: Colors.white,
              child: CDBScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 24.0, bottom: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Please review all information carefully before submitting",
                        style: AppStyling.normal400Size14
                            .copyWith(color: AppColors.textDarkColor),
                      ),
                      const SizedBox(
                        height: 17,
                      ),
                      ReviewInfoView(
                        step: KYCStep.PERSONALINFO,
                        data: _walletData?.walletUserData,
                        refreshData: (value) =>
                            _fetchData(refreshStatus: value),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ReviewInfoView(
                        step: KYCStep.CONTACTINFO,
                        data: _walletData?.walletUserData,
                        refreshData: (value) =>
                            _fetchData(refreshStatus: value),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ReviewInfoView(
                        step: KYCStep.EMPDETAILS,
                        data: _walletData?.walletUserData,
                        refreshData: (value) =>
                            _fetchData(refreshStatus: value),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ReviewInfoView(
                        step: KYCStep.OTHERINFO,
                        data: _walletData?.walletUserData,
                        refreshData: (value) =>
                            _fetchData(refreshStatus: value),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ReviewInfoView(
                        step: KYCStep.DOCUMENTVERIFY,
                        data: _walletData?.walletUserData,
                        refreshData: (value) =>
                            _fetchData(refreshStatus: value),
                      ),
                      CDBBorderGradientButton(
                        width: double.maxFinite,
                        onTap: () async {
                          final _otpResult = await Navigator.pushNamed(
                              context, Routes.kCommonOTPView,
                              arguments: OTPViewArgs(
                                  otpType: kOtpMessageTypeOnBoarding,
                                  requestOTP: true)) as bool;

                          if (_otpResult) {
                            _bloc.add(SaveReviewEvent());
                          }
                        },
                        text: 'Submit',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _fetchData({bool initialFetch = false, bool refreshStatus = false}) {
    _bloc.add(GetReviewInfoEvent());
    if (!initialFetch && refreshStatus) {
      ToastUtils.showCustomToast(
          context, 'Your changes were updated', ToastStatus.success);
    }
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() => _bloc;
}

class ReviewInfoView extends StatelessWidget {
  final KYCStep step;
  final WalletUserData data;
  final Function(bool) refreshData;

  const ReviewInfoView({Key key, this.step, this.data, this.refreshData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              step.getLabel(context),
              style: AppStyling.normal500Size16
                  .copyWith(color: AppColors.primaryColor),
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(CDBIcons.ic_info_edit,
                  color: AppColors.primaryColor),
              onPressed: () => Navigator.pushNamed(
                      context, step.getNavigationRouteName(),
                      arguments: true)
                  .then((value) => refreshData(value)),
            )
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        _getInfoRelatedToTheStep(context)
      ],
    );
  }

  Widget _getInfoRelatedToTheStep(BuildContext context) {
    switch (step) {
      case KYCStep.PERSONALINFO:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DetailItemView(
                title: 'Title',
                value: data?.customerRegistrationRequest?.title ?? ''),
            DetailItemView(
                title: 'Initials',
                value: data?.customerRegistrationRequest?.initials ?? ''),
            DetailItemView(
                title: 'Initials in Full',
                value: data?.customerRegistrationRequest?.initialsInFull ?? ''),
            DetailItemView(
                title: 'Last Name',
                value: data?.customerRegistrationRequest?.lastName ?? ''),
            DetailItemView(
                title: 'Nationality',
                value: data?.customerRegistrationRequest?.nationality ?? ''),
            DetailItemView(
                title: 'Language',
                value: data?.customerRegistrationRequest?.language ?? ''),
            DetailItemView(
                title: 'Religion',
                value: data?.customerRegistrationRequest?.religion ?? ''),
            DetailItemView(
                title: 'National Identity Card No',
                value: data?.customerRegistrationRequest?.nic ?? ''),
            DetailItemView(
                title: 'Gender',
                value:
                    data?.customerRegistrationRequest?.gender?.capitalized() ??
                        ''),
            DetailItemView(
                title: 'Date of Birth',
                value: data?.customerRegistrationRequest?.dateOfBirth ?? ''),
            DetailItemView(
                title: 'Marital Status',
                value: data?.customerRegistrationRequest?.maritalStatus
                        ?.capitalized() ??
                    ''),
            DetailItemView(
                title: 'Mother’s Maiden Name',
                value:
                    data?.customerRegistrationRequest?.mothersMaidenName ?? ''),
          ],
        );
      case KYCStep.CONTACTINFO:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DetailItemView(
                title: 'Mobile Number',
                value: data?.customerRegistrationRequest?.mobileNo ?? ''),
            DetailItemView(
                title: 'Email Address',
                value: data?.customerRegistrationRequest?.email ?? ''),
            DetailItemView(
                title: 'Permanent Address',
                value: data?.customerRegistrationRequest?.perAddress != null
                    ? '${data?.customerRegistrationRequest?.perAddress[0]?.addressLine1 ?? ''}\n${data?.customerRegistrationRequest?.perAddress[0]?.addressLine2 ?? ''}\n${data?.customerRegistrationRequest?.perAddress[0]?.addressLine3 ?? ''}'
                    : ''),
            DetailItemView(
                title: 'City',
                value: data?.customerRegistrationRequest?.perAddress != null
                    ? data?.customerRegistrationRequest?.perAddress[0]
                            ?.cityUiValue ??
                        ''
                    : ''),
            DetailItemView(
                title:
                    'Is above address same as National Identity Card address?',
                value: data?.customerRegistrationRequest?.perAddress != null
                    ? data?.customerRegistrationRequest?.perAddress[0]
                            .equalityWithNic
                        ? 'Yes'
                        : 'No'
                    : ''),
          ],
        );
      case KYCStep.EMPDETAILS:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DetailItemView(
                title: 'Employment Type',
                value: data?.empDetailRequest?.empType ?? ''),
            DetailItemView(
                title: 'Employer Name',
                value: data?.empDetailRequest?.nameOfEmp ?? ''),
            DetailItemView(
                title: 'Employer Address',
                value:
                    '${data?.empDetailRequest?.addressOfEmp?.addressLine1 ?? ''}\n${data?.empDetailRequest?.addressOfEmp?.addressLine2 ?? ''}\n${data?.empDetailRequest?.addressOfEmp?.addressLine3 ?? ''}'),
            DetailItemView(
                title: 'Employment Field',
                value: data?.empDetailRequest?.filedOfEmp ?? ''),
            DetailItemView(
                title: 'Designation',
                value: data?.empDetailRequest?.designationUiValue ?? ''),
            DetailItemView(
                title: 'Annual Income',
                value: 'LKR ${data?.empDetailRequest?.annualIncome ?? ''}'),
          ],
        );
      case KYCStep.OTHERINFO:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DetailItemView(
                title: 'Are you a politically expose person?',
                value: (data?.empDetailRequest?.isPoliticallyExposed
                                ?.capitalized() ??
                            '') ==
                        "False"
                    ? AppString.no.localize(context)
                    : AppString.yes.localize(context)),
            DetailItemView(
                title: 'Purpose of account opening',
                value: data?.empDetailRequest?.purposeOfAcc ?? ''),
            DetailItemView(
                title: 'Are you a tax payer in USA ?',
                value: (data?.empDetailRequest?.isTaxPayerUs?.capitalized() ??
                            '') ==
                        "False"
                    ? AppString.no.localize(context)
                    : AppString.yes.localize(context)),
            DetailItemView(
                title: 'Source of Funds',
                value: data?.empDetailRequest?.sourceOfIncome ?? ''),
            DetailItemView(
                title: 'Expected Transaction Mode',
                value: data?.empDetailRequest?.expectedTransactionMode ?? ''),
            DetailItemView(
                title: 'Anticipated Deposits per Month',
                value:
                    'LKR ${data?.empDetailRequest?.anticipatedDepositPerMonth ?? ''}'),
            DetailItemView(
                title: 'Marketing Reference Code',
                value: data?.empDetailRequest?.marketingRefCode ?? ''),
          ],
        );
      case KYCStep.DOCUMENTVERIFY:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DetailImageItemView(
              title: 'Selfie image of your self',
              value: [
                ImageItem(
                  imagePath: data?.documentVerificationRequest?.selfie,
                  type: IDType.SELFIE,
                ),
              ],
            ),
            _getIDProof(),
            if (data?.documentVerificationRequest?.billingProof != null)
              DetailImageItemView(
                title: 'Billing Proof',
                value: [
                  ImageItem(
                    imagePath: data?.documentVerificationRequest?.billingProof,
                    type: IDType.BILLING_PROOF,
                  ),
                ],
              )
            else
              const SizedBox.shrink(),
          ],
        );
      case KYCStep.SCHEDULEVERIFY:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // children: [
          /*DetailItemView(
                title: 'Time',
                value: data?.scheduleVerificationRequest?.timeSlot ?? ''),
            DetailItemView(
                title: 'Date',
                value: data?.scheduleVerificationRequest?.date ?? ''),
            DetailItemView(
                title: 'Language',
                value: data?.scheduleVerificationRequest?.language ?? ''),*/
          // ],
        );
      case KYCStep.REVIEW:

      case KYCStep.TNC:

      default:
        return const SizedBox.shrink();
    }
  }

  Widget _getIDProof() {
    if (data?.documentVerificationRequest?.proofType == 'nic') {
      return DetailImageItemView(
        title: 'National Identity Card',
        value: [
          ImageItem(
            imagePath: data?.documentVerificationRequest?.icFront,
            type: IDType.ID_FRONT,
          ),
          const SizedBox(
            height: 3,
          ),
          ImageItem(
            imagePath: data?.documentVerificationRequest?.icBack,
            type: IDType.ID_BACK,
          ),
        ],
      );
    } else if (data?.documentVerificationRequest?.proofType == 'passport') {
      return DetailImageItemView(
        title: 'Passport',
        value: [
          ImageItem(
            imagePath: data?.documentVerificationRequest?.icFront,
            type: IDType.ID_FRONT,
          ),
        ],
      );
    } else if (data?.documentVerificationRequest?.proofType == 'driving') {
      return DetailImageItemView(
        title: 'Driving Licence',
        value: [
          ImageItem(
            imagePath: data?.documentVerificationRequest?.icFront,
            type: IDType.ID_FRONT,
          ),
        ],
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}

class ImageItem extends StatelessWidget {
  final String imagePath;
  final IDType type;

  const ImageItem({Key key, this.imagePath, this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(TextSpan(
      style:
          AppStyling.normal500Size14.copyWith(color: AppColors.textDarkColor),
      children: <TextSpan>[
        TextSpan(text: _cropPathString(imagePath)),
        TextSpan(
          text: 'View',
          style: AppStyling.normal500Size14.copyWith(
              color: AppColors.primaryColor,
              decoration: TextDecoration.underline),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              _navigate(context);
            },
        ),
      ],
    ));
  }

  String _cropPathString(String path) {
    if (Platform.isAndroid) {
      return '${imagePath != null ? imagePath.split('/').last : ''}   ';
    } else {
      return '${imagePath != null ? imagePath.split('/')[9].split('-').last : ''}   ';
    }
  }

  void _navigate(BuildContext context) {
    Navigator.pushNamed(
      context,
      Routes.kDocumentEditView,
      arguments: DocumentEditArguments(
          imagePath: imagePath, idType: type, isEditable: false),
    );
  }
}

class DetailImageItemView extends StatelessWidget {
  final String title;
  final List<Widget> value;

  const DetailImageItemView(
      {Key key, @required this.title, @required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title ?? '',
          style: AppStyling.normal400Size14
              .copyWith(color: AppColors.textTitleColor),
        ),
        const SizedBox(
          height: 6,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 8,
          ),
          child: Column(
            children: value,
          ),
        ),
        const SizedBox(
          height: 25,
        ),
      ],
    );
  }
}

class DetailItemView extends StatelessWidget {
  final String title;
  final String value;

  const DetailItemView({Key key, @required this.title, @required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title ?? '',
          style: AppStyling.normal400Size14
              .copyWith(color: AppColors.textTitleColor),
        ),
        const SizedBox(
          height: 6,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 8,
          ),
          child: Text(
            value ?? '',
            style: AppStyling.normal500Size16
                .copyWith(color: AppColors.textDarkColor),
          ),
        ),
        const SizedBox(
          height: 25,
        ),
      ],
    );
  }
}
