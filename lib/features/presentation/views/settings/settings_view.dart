import 'package:cdb_mobile/utils/navigation_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/app_styling.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key key}) : super(key: key);

  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.dark,
      child: Stack(
        children: [
          Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Align(
              alignment: Alignment.centerRight,
              child: Image.asset(
                AppImages.backgroundWalledRightCircle,
                height: 500.h,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.white.withOpacity(0.9),
          ),
          Padding(
            padding: const EdgeInsets.all(17.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Container(
                            width: 52,
                            height: 52,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Image.network(
                                'https://cdn3.iconfinder.com/data/icons/avatars-round-flat/33/man5-512.png'),
                          ),
                        ),
                        SizedBox(
                          width: 10.h,
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Shehan Madushanka',
                              style: AppStyling.normal700Size16
                                  .copyWith(color: AppColors.textDarkColor),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Last Login',
                              style: AppStyling.normal300Size12
                                  .copyWith(color: AppColors.textDarkColor),
                            ),
                            Text(
                              '22-Nov-2021   03:45PM',
                              style: AppStyling.normal300Size12
                                  .copyWith(color: AppColors.textDarkColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Logout',
                        style: AppStyling.normal500Size12.copyWith(
                          color: AppColors.primaryColor,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView(
                      children: [
                        Text(
                          'Profile Settings',
                          style: AppStyling.normal600Size14.copyWith(
                            color: AppColors.textDarkColor,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const SettingListItem(
                          title: 'Edit Profile',
                        ),
                        SettingListItem(
                          title: 'Change Password',
                          onTap: () {
                            Navigator.pushNamed(
                                context, Routes.kSettingsChangePasswordView);
                          },
                        ),
                        Text(
                          'App Settings',
                          style: AppStyling.normal600Size14.copyWith(
                            color: AppColors.textDarkColor,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const SettingListItem(
                          title: 'Biometrics',
                        ),
                        SettingListItem(
                          title: 'Language',
                          onTap: () {
                            Navigator.pushNamed(
                                context, Routes.kSettingsLanguageSelectionView);
                          },
                        ),
                        const SettingListItem(
                          title: 'Transaction Limits',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SettingListItem extends StatelessWidget {
  final VoidCallback onTap;
  final String title;

  const SettingListItem({Key key, this.onTap, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: AppStyling.normal400Size14.copyWith(
                      color: AppColors.textDarkColor,
                    ),
                  ),
                ),
                const Expanded(
                  child: Icon(
                    Icons.chevron_right_rounded,
                    color: AppColors.primaryColor,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
