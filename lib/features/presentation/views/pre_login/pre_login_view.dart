import 'package:url_launcher/url_launcher.dart';
import 'package:cdb_mobile/features/presentation/views/login/widget/round_notch_shape.dart';
import 'package:cdb_mobile/features/presentation/views/pre_login/widget/menu_item.dart';
import 'package:cdb_mobile/utils/app_colors.dart';
import 'package:cdb_mobile/utils/app_images.dart';
import 'package:cdb_mobile/utils/app_strings.dart';
import 'package:cdb_mobile/utils/app_styling.dart';
import 'package:cdb_mobile/utils/navigation_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PreLogin {
  final String key;
  final String icon;

  PreLogin(this.key, this.icon);
}

List<PreLogin> preLoginMenuItems = [
  PreLogin('Language', AppImages.icPreLoginLanguage),
  PreLogin('FAQ', AppImages.icPreLoginInfo),
  PreLogin('Contact Us', AppImages.icPreLoginContactUs),
  PreLogin('Rates', AppImages.icPreLoginRates),
  PreLogin('Calculator', AppImages.icPreLoginCalculator),
  PreLogin('Home', AppImages.icPreLoginHome),
];

class PreLoginMenuView extends StatelessWidget {
  bool isFromHome;
  final String _urlRates = 'https://www.cdb.lk/rates/';
  final String _urlCalculators = 'https://www.cdb.lk/calculators/';


  PreLoginMenuView(this.isFromHome);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      top: false,
      minimum: const EdgeInsets.only(bottom: 10),
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
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
                  mainAxisSpacing: 3.5,
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
            decoration: ShapeDecoration(
                color: AppColors.separationLinesColor,
                shape: RoundNotchShape()),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: 31.h,
                child: Center(
                  child: Text(
                    AppString.menu.localize(context),
                    style: AppStyling.normal500Size10.copyWith(
                      color: AppColors.textTitleColor,
                      // fontSize: 12
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
            Align(
              child: Image.asset(AppImages.preLoginMenuBg),
            ),
            Align(
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                primary: false,
                padding: const EdgeInsets.only(left: 5, right: 5),
                itemCount: preLoginMenuItems.length,
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
            Navigator.pushNamed(context, Routes.kLanguageView);
            break;
          case 1:
            Navigator.pushNamed(context, Routes.kFAQView);
            break;
          case 2:
            Navigator.pushNamed(context, Routes.kContactUsView);
            break;
          case 3:
            _launchUrl(_urlRates);
            break;
          case 4:
            _launchUrl(_urlCalculators);
            break;
          case 5:
            Navigator.pushNamedAndRemoveUntil(
                context, Routes.kLoginView, (route) => false);
            break;
        }
      },
      highlightColor: Colors.white,
      hoverColor: Colors.white,
      splashColor: AppColors.accentColor,
      borderRadius: const BorderRadius.all(
        Radius.circular(6),
      ),
      child: PreLoginMenuItem(
        menuItem: preLoginMenuItems[index],
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
