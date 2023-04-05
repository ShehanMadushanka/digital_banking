import 'package:cdb_mobile/features/presentation/views/settings/settings_view.dart';
import 'package:cdb_mobile/features/presentation/views/transaction_history/transaction_history.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/navigation_routes.dart';
import '../../widgets/cdb_bottom_app_bar.dart';
import 'home_portfolio_view.dart';
import 'home_wallet_view.dart';
import 'portfolio/home_portfolio_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  final List<Widget> _pageList = [
    const HomeWalletView(),
    const PortfolioView(),
    const TransactionHistoryView(),
    const SettingsView(),
  ];

  void changeIndex(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      top: false,
      minimum: const EdgeInsets.only(bottom: 10),
      child: Scaffold(
        body: _pageList[_selectedIndex],
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: SizedBox(
          height: 48.w,
          width: 48.w,
          child: FloatingActionButton(
            elevation: 0,
            onPressed: () {
              Navigator.pushNamed(context, Routes.kQuickAccessMenu);
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
                      (index) => const CircleAvatar(
                            backgroundColor: AppColors.whiteColor,
                            radius: 4.5,
                          )),
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: CDBBottomAppBar(
          selectedIndex: _selectedIndex,
          onTap: (value) {
            changeIndex(value);
          },
        ),
      ),
    );
  }
}
