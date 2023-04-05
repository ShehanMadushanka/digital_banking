import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/app_strings.dart';
import '../../../../utils/app_styling.dart';
import '../../../../utils/navigation_routes.dart';
import 'widget/quick_access_menu_item.dart';

class QuickAccess {
  final String key;
  final String icon;

  QuickAccess(this.key, this.icon);
}

List<QuickAccess> quickAccessMenuItems = [
  QuickAccess('Card\n Management', AppImages.icManagement),
  QuickAccess('Biller\n Management', AppImages.icBillerManagementQuickAccess),
  QuickAccess('Payees\n Management', AppImages.icPayeesManagement),
  QuickAccess('FAQ', AppImages.icFaqQuickAccess),
  QuickAccess('Manage\n Pay Options', AppImages.icManagePayOptionQuickAccess),
  QuickAccess('Promotion\n & Offers', AppImages.icPromotionAndOffers),
  QuickAccess('Find Us', AppImages.icFindUsQuickAccess),
  QuickAccess('Share', AppImages.icShare),
  QuickAccess('Contact Us', AppImages.icContactUsQuickAccess),
  QuickAccess('Rates', AppImages.icPreLoginRates),
  QuickAccess('Calculator', AppImages.icPreLoginCalculator),
  QuickAccess('Schedules', AppImages.icPostLoginSchedule),
];

class QuickAccessMenuView extends StatelessWidget {
  bool isFromHome;
  final String _urlRates = 'https://www.cdb.lk/rates/';
  final String _urlCalculators = 'https://www.cdb.lk/calculators/';

  QuickAccessMenuView(this.isFromHome);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      top: false,
      minimum: const EdgeInsets.only(bottom: 10),
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        extendBodyBehindAppBar: true,
        floatingActionButton: SizedBox(
          height: 48.w,
          width: 48.w,
          child: FloatingActionButton(
            elevation: 0,
            onPressed: () {
              Navigator.pop(context);
            },
            child: CircleAvatar(
              radius: 48,
              backgroundColor: AppColors.accentColor,
              child: Padding(
                padding: EdgeInsets.all(14.h),
                child: GridView.count(
                  crossAxisCount: 3,
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 3.5,
                  children: List.generate(
                    9,
                        (index) => index % 2 == 0
                        ? const CircleAvatar(
                      backgroundColor: AppColors.whiteColor,
                      radius: 4.5,
                    )
                        : const SizedBox.shrink(),
                  ),
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: 55.h,
          child: Container(
            // decoration: ShapeDecoration(
            //      color: AppColors.separationLinesColor,
            //     shape: RoundNotchShape()),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: 31.h,
                child: Center(
                  child: Text(
                    AppString.close.localize(context),
                    style: AppStyling.normal500Size10.copyWith(
                      color: AppColors.textTitleColor,
                      //fontSize: 12
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              // decoration: BoxDecoration(),
              // child: Image.asset(AppImages.quickAccessMenuBg),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    AppImages.quickAccessMenuBg,
                  ),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            // Align(
            //   child: Image.asset(AppImages.preLoginMenuBg),
            // ),
            Align(
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                primary: false,
                padding: const EdgeInsets.only(left: 5, right: 5),
                itemCount: quickAccessMenuItems.length,
                itemBuilder: _buildMenuItem,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, int index) {
    return InkWell(
      onTap: () {
        switch (index) {
          case 0:
            Navigator.pushNamed(context, Routes.kAccountListView);
            break;
          case 1:
            Navigator.pushNamed(context, Routes.kSavedBillerListView);
            break;
          case 2:
            Navigator.pushNamed(context, Routes.kPayeeManagementListView);
            break;
          case 3:
            Navigator.pushNamed(context, Routes.kFAQView);
            break;
          case 4:
            Navigator.pushNamed(context, Routes.kAccountListView);
            break;
          case 5:
            Navigator.pushNamed(context, Routes.kPromotionsOffersView);
            break;
          case 8:
            Navigator.pushNamed(context, Routes.kContactUsView);
            break;
          case 9:
            _launchUrl(_urlRates);
            break;
          case 10:
            _launchUrl(_urlCalculators);
            break;
          case 11:
            Navigator.pushNamed(context, Routes.kSchedulesView);
            break;
        }
      },
      highlightColor: Colors.white,
      hoverColor: Colors.white,
      splashColor: AppColors.accentColor,
      borderRadius: const BorderRadius.all(
        Radius.circular(6),
      ),
      child: QuickAccessMenuItem(
        menuItem: quickAccessMenuItems[index],
        index: index,
      ),
    );
  }
  Future<void> _launchUrl(url) async {
    if(await canLaunch(url)){
      await launch(url);
    }else {
      throw 'Could not launch $url';
    }
  }
}
