import 'package:cdb_mobile/features/presentation/views/biller_management/bill_payment/favourites_billers_view.dart';
import 'package:cdb_mobile/features/presentation/views/biller_management/bill_payment/pay_bills_view.dart';
import 'package:cdb_mobile/features/presentation/views/biller_management/bill_payment/saved_biller_view.dart';
import 'package:cdb_mobile/features/presentation/views/biller_management/widget/cdb_biller_bottom_app_bar.dart';
import 'package:cdb_mobile/features/presentation/widgets/cdb_default_appbar.dart';
import 'package:flutter/material.dart';

class BillPaymentMainView extends StatefulWidget {
  const BillPaymentMainView({Key key}) : super(key: key);

  @override
  _BillPaymentMainViewState createState() => _BillPaymentMainViewState();
}

class _BillPaymentMainViewState extends State<BillPaymentMainView> {
  int _selectedIndex = 0;

  final List<Widget> _pageList = [
    PayBillsView(),
    const SavedBillerView(),
    const FavouriteBillersView(),
  ];

  void changeIndex(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  String _getTitle() {
    return _selectedIndex == 0
        ? 'Pay Bills'
        : (_selectedIndex == 1 ? 'Billers' : 'Billers');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CDBMainAppBar(
        appBarTitle: _getTitle(),
        onTapBack: () {
          Navigator.pop(context);
        },
      ),
      body: _pageList[_selectedIndex],
      bottomNavigationBar: CDBBillerBottomAppBar(
        onTapOne: () {
          changeIndex(0);
        },
        iconOne: Icons.category ?? Icons.category_rounded,
        iconNameOne: 'Categories',
        onTapTwo: () {
          changeIndex(1);
        },
        iconTwo: Icons.save,
        iconNameTwo: 'Saved',
        onTapThree: () {
          changeIndex(2);
        },
        iconThree: Icons.favorite_border_outlined,
        iconNameThree: 'Favourites',
      ),
    );
  }
}
