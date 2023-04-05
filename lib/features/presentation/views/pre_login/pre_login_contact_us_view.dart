import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/services/dependency_injection.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/app_strings.dart';
import '../../../../utils/app_styling.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../../bloc/pre_login/contact_us/contact_us_bloc.dart';
import '../../bloc/pre_login/contact_us/contact_us_event.dart';
import '../../bloc/pre_login/contact_us/contact_us_state.dart';
import '../../widgets/cdb_default_appbar.dart';
import '../../widgets/cdb_toast/cdb_toast.dart';
import '../base_view.dart';
import 'widget/text_gradient.dart';

class ContactUsView extends BaseView {
  const ContactUsView({Key key}) : super(key: key);

  @override
  State<ContactUsView> createState() => _ContactUsViewState();
}

const String webSite = 'cdbbank.com';
const String emailAddress = 'customercare@cdk.lk';
const String generalNumber = '+94 117 388 388';
const String callNumber = '+94 112 828 312';
const String faxNumber = '+94 117 388 388';

class _ContactUsViewState extends BaseViewState<ContactUsView> {
  String companyName;
  String telNo;
  String email;
  String busAddLine1;
  String busAddLine2;
  String busAddLine3;

  final ContactUsBloc _contactUsBloc = inject<ContactUsBloc>();

  @override
  void initState() {
    _contactUsBloc.add(ContactUsEvent());
    super.initState();
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: CDBMainAppBar(
        appBarTitle: AppString.cUsTitle.localize(context),
        onTapBack: () {
          Navigator.pop(context);
        },
      ),
      body: BlocProvider(
        create: (_) => _contactUsBloc,
        child: BlocListener<ContactUsBloc, BaseState<ContactUsState>>(
          listener: (context, state) {
            if (state is ContactUsSuccessState) {
              setState(() {
                email = state.email;
                telNo = state.telNo;
              });
            } else if (state is ContactUsFailedState) {
              ToastUtils.showCustomToast(
                  context, state.message, ToastStatus.fail);
            }
          },
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                AppImages.contactUsBackground,
                fit: BoxFit.fitWidth,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.asset(
                        AppImages.contactIcon,
                        fit: BoxFit.scaleDown,
                        height: 67,
                        width: MediaQuery.of(context).size.width,
                        color: const Color(0xffD5D5D5),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppString.cUsWelcomeMessage.localize(context),
                          textAlign: TextAlign.center,
                          style: AppStyling.normal600Size20
                              .copyWith(color: AppColors.textLightColor),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Text(
                      AppString.cUsWebEmail.localize(context),
                      textAlign: TextAlign.center,
                      style: AppStyling.normal500Size16
                          .copyWith(color: AppColors.primaryColor),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Image.asset(AppImages.globalIcon,
                            width: 25, height: 25),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () async {
                            _launchWebsiteUrl('https://www.linkedin.com');
                          },
                          child: const TextGradient(
                              textHere: webSite ?? '',
                              textStyle: AppStyling.normal300Size13Underlined),
                        ),
                        const Spacer(flex: 2),
                        Image.asset(AppImages.unionIcon,
                            width: 22.03, height: 17.87),
                        const SizedBox(width: 10),
                        GestureDetector(
                            onTap: () async {
                              _launchEmail(email);
                            },
                          child: const TextGradient(
                              textHere: emailAddress ?? '',
                              textStyle: AppStyling.normal300Size13Underlined),
                        ),
                        const Spacer(flex: 2)
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Divider(
                      color: Color(0xffE7E7E7),
                      thickness: 1.0,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      AppString.cUsFindUsSocialMedia.localize(context),
                      textAlign: TextAlign.center,
                      style: AppStyling.normal500Size16
                          .copyWith(color: AppColors.primaryColor),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            _launchWebsiteUrl('https://www.facebook.com');
                          },
                          child: Image.asset(AppImages.facebookIcon,
                              width: 12.96, height: 22.33),
                        ),
                        const SizedBox(width: 20),
                        GestureDetector(
                          onTap: () async {
                            _launchWebsiteUrl('https://www.twitter.com');
                          },
                          child: Image.asset(AppImages.twitterIcon,
                              width: 24.42, height: 20.19),
                        ),
                        const SizedBox(width: 20),
                        GestureDetector(
                          onTap: () async {
                            _launchWebsiteUrl('https://www.linkedin.com');
                          },
                          child: Image.asset(AppImages.linkedinIcon,
                              width: 22.34, height: 21.29),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Divider(
                      color: Color(0xffE7E7E7),
                      thickness: 1.0,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      AppString.cUsGetInTouch.localize(context),
                      textAlign: TextAlign.center,
                      style: AppStyling.normal500Size16
                          .copyWith(color: AppColors.primaryColor),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppString.cUsGeneralNumber.localize(context),
                              style: AppStyling.normal300Size13
                                  .copyWith(color: AppColors.primaryColor),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              AppString.cUsCenterContact.localize(context),
                              style: AppStyling.normal300Size13
                                  .copyWith(color: AppColors.primaryColor),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              AppString.cUsFaxNumber.localize(context),
                              style: AppStyling.normal300Size13
                                  .copyWith(color: AppColors.primaryColor),
                            ),
                          ],
                        ),
                        const Spacer(flex: 2),
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                _launchCaller(int.parse(
                                  telNo.replaceAll(' ', '').replaceAll('+94', '0'),
                                ));
                              },
                              child: TextGradient(
                                  textHere: telNo ?? '',
                                  textStyle: AppStyling.normal300Size13),
                            ),
                            const SizedBox(height: 10),
                            GestureDetector(
                              onTap: () async {
                                _launchCaller(int.parse(
                                  callNumber.replaceAll(' ', '').replaceAll('+94', '0'),
                                ));
                              },
                              child: const TextGradient(
                                  textHere: callNumber ?? '',
                                  textStyle: AppStyling.normal300Size13),
                            ),
                            const SizedBox(height: 10),
                            GestureDetector(
                              onTap: () async {
                                _launchCaller(int.parse(
                                  faxNumber.replaceAll(' ', '').replaceAll('+94', '0'),
                                ));
                              },
                              child: const TextGradient(
                                  textHere: faxNumber ?? '',
                                  textStyle: AppStyling.normal300Size13),
                            ),
                          ],
                        ),
                        const Spacer(flex: 3),
                      ],
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
    return _contactUsBloc;
  }

  _launchWebsiteUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Cannot direct to $url';
    }
  }

  _launchEmail(String emailId) async {
    var url = 'mailto:${emailId.toString()}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Cannot direct to $url';
    }
  }

  _launchCaller(int number) async {
    var url = 'tel:${number.toString()}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Cannot direct to $url';
    }
  }
}
