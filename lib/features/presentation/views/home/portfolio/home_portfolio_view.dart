import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_images.dart';
import '../../../../../utils/app_strings.dart';
import '../../../../../utils/app_styling.dart';
import '../../../../../utils/navigation_routes.dart';
import '../../../widgets/cdb_bottom_app_bar.dart';
import 'widgets/expansion_body.dart';
import 'widgets/expansion_header.dart';
import 'widgets/more_products_card.dart';

class PortfolioView extends StatefulWidget {
  const PortfolioView({Key key}) : super(key: key);

  @override
  _PortfolioViewState createState() => _PortfolioViewState();
}

class _PortfolioViewState extends State<PortfolioView> {
  List<ExpansionBodyModel> leaseData = [];
  List<ExpansionBodyModel> loanData = [];
  List<ExpansionHeaderModel> portfolioData = [];

  @override
  void initState() {
    super.initState();

    leaseData.addAll([
      ExpansionBodyModel(
        exTitle: 'Salary Max Savings',
        exSubTitle: '8560002121',
        exAmount: '19,000',
        exBalanceText: 'Available Balance',
        onPressed: () {},
      ),
      ExpansionBodyModel(
        exTitle: 'Statement Savings',
        exSubTitle: '8560002121',
        exAmount: '106,000',
        exBalanceText: 'Available Balance',
        onPressed: () {},
      ),
    ]);

    loanData.addAll([
      ExpansionBodyModel(
        exTitle: 'Gold loan',
        exSubTitle: '',
        exAmount: '19,000',
        exBalanceText: 'Available Balance',
        onPressed: () {},
      ),
      ExpansionBodyModel(
        exTitle: 'CDB Home Loan',
        exSubTitle: '8560002121',
        exAmount: '106,000',
        exBalanceText: 'Available Balance',
        onPressed: () {},
      ),
    ]);

    portfolioData.addAll([
      ExpansionHeaderModel(
          portfolioImage: Image.asset(
            AppImages.portAccount,
            fit: BoxFit.scaleDown,
            height: 5.0,
          ),
          portfolioHeader: 'Account',
          portfolioAmount: '125,000',
          portfolioAmountDecs: 'Total Available Balance',
          portfolioBody: '_faqBodyText',
          data: leaseData),
      ExpansionHeaderModel(
          portfolioImage: Image.asset(
            AppImages.portCards,
            fit: BoxFit.scaleDown,
            height: 5.0,
          ),
          portfolioHeader: 'Cards',
          portfolioAmount: '25,000',
          portfolioAmountDecs: 'Total Outstanding Balance',
          portfolioBody: '_faqBodyText',
          data: leaseData),
      ExpansionHeaderModel(
          portfolioImage: Image.asset(
            AppImages.portFixedDeposits,
            fit: BoxFit.scaleDown,
            height: 5.0,
          ),
          portfolioHeader: 'Fixed Deposits',
          portfolioAmount: '25,000',
          portfolioAmountDecs: 'Total Deposit Balance',
          portfolioBody: '_faqBodyText',
          data: leaseData),
      ExpansionHeaderModel(
          portfolioImage: Image.asset(
            AppImages.portLoans,
            fit: BoxFit.scaleDown,
            height: 5.0,
          ),
          portfolioHeader: 'Loans',
          portfolioAmount: '25,000',
          portfolioAmountDecs: 'Total Outstanding Balance',
          portfolioBody: '_faqBodyText',
          data: loanData),
      ExpansionHeaderModel(
          portfolioImage: Image.asset(
            AppImages.portLease,
            fit: BoxFit.scaleDown,
            height: 5.0,
          ),
          portfolioHeader: 'Lease',
          portfolioAmount: '25,000',
          portfolioAmountDecs: 'Total Account Balance',
          portfolioBody: '_faqBodyText',
          data: leaseData),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            AppString.portfolio.localize(context),
            style: AppStyling.normal600Size20
                .copyWith(color: AppColors.textDarkColor),
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      //extendBodyBehindAppBar: true,
      body: Stack(
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
          Column(
            children: [
              Expanded(
                flex: 2,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: portfolioData.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, top: 15.0, bottom: 10.0),
                      child: Stack(
                        children: [
                          Theme(
                            data: ThemeData()
                                .copyWith(dividerColor: Colors.transparent),
                            child: ExpansionTile(
                              title: ExpansionHeader(
                                image: portfolioData[index].portfolioImage,
                                headerText:
                                    portfolioData[index].portfolioHeader,
                                headerAmount:
                                    portfolioData[index].portfolioAmount,
                                headerBalanceText:
                                    portfolioData[index].portfolioAmountDecs,
                              ),
                              collapsedIconColor: AppColors.primaryColor,
                              childrenPadding: const EdgeInsets.fromLTRB(
                                      60.0, 10.0, 20.0, 0.0)
                                  .copyWith(top: 0),
                              children: [
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: portfolioData[index].data.length,
                                  itemBuilder:
                                      (BuildContext context, int indexBody) {
                                    return ExpansionBody(
                                      bodyTitle: portfolioData[index]
                                          .data[indexBody]
                                          .exTitle,
                                      bodySubTitle: portfolioData[index]
                                          .data[indexBody]
                                          .exSubTitle,
                                      bodyAmount: portfolioData[index]
                                          .data[indexBody]
                                          .exAmount,
                                      bodyBalanceText: portfolioData[index]
                                          .data[indexBody]
                                          .exBalanceText,
                                      onPressed: () {
                                        Navigator.pushNamed(context, Routes.kGoldLoanListView);
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.width / 2,
                color: AppColors.greyWhiteColor,
                child: SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(
                            "More About Our Products",
                            style: AppStyling.normal500Size16
                                .copyWith(color: AppColors.grayColor),
                          ),
                        ),
                        SizedBox(height: 15.h),
                        //MoreProductsCards(),
                        Expanded(
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: cdbMoreProducts.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: MoreProductsCards(
                                  productItemName:
                                      cdbMoreProducts[index].productName,
                                  bottomColor: cdbMoreProducts[index].setColor,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
