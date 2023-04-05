import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/app_strings.dart';
import '../../../../utils/app_styling.dart';
import '../../widgets/cdb_default_appbar.dart';
import 'widget/text_gradient.dart';

class FAQModel {
  int faqId;
  String faqBody;
  String faqHeader;
  bool isExpanded;

  FAQModel({
    this.faqId,
    this.faqBody,
    this.faqHeader,
    this.isExpanded = false,
  });
}

const String _faqBodyText =
    'a) Mobile Banking\n\nUsing your credit card/ debit card number and PIN number Using your existing CDB internet banking credentials Walking in to the nearest CDB branch.\n\n'
    'b) Dial Banking\n\nYou need to visit the CDB branch to fill out a registration form.\nAfter registration you can access the service by dialing #0000# the dial pad.\n\nWalking in to the nearest CDB branch.';

// List<FAQModel> generateItems(int numberOfItems) {
//   return List<FAQModel>.generate(numberOfItems, (int index) {
//     return FAQModel(
//       faqId: index,
//       faqHeader: 'How do I register for the service?',
//       faqBody: _faqBodyText,
//     );
//   });
// }

List<FAQModel> faqData = <FAQModel>[
  FAQModel(
    faqHeader: 'How do I register for the service?',
    faqBody: _faqBodyText,
  ),
  FAQModel(
    faqHeader: 'On what device can I use the services?',
    faqBody: _faqBodyText,
  ),
  FAQModel(
    faqHeader: 'What function can I perform?',
    faqBody: _faqBodyText,
  )
];

class FAQView extends StatefulWidget {
  const FAQView({Key key}) : super(key: key);

  @override
  _FAQViewState createState() => _FAQViewState();
}

class _FAQViewState extends State<FAQView> {
  //final List<FAQModel> _faqData = generateItems(3); //include number of items in the list

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CDBMainAppBar(
        appBarTitle: AppString.faqTitle.localize(context),
        onTapBack: () {
          Navigator.pop(context);
        },
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: faqData.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    ExpansionPanelList(
                      animationDuration: const Duration(milliseconds: 1000),
                      dividerColor: AppColors.lightAshColor,
                      elevation: 0,
                      children: [
                        ExpansionPanel(
                          canTapOnHeader: true,
                          backgroundColor: faqData[index].isExpanded == true
                              ? AppColors.lightBlueColor
                              : AppColors.whiteColor,
                          body: Container(
                            padding: const EdgeInsets.only(
                                    left: 20.0, right: 15.0, bottom: 20.0)
                                .copyWith(top: 0.0),
                            child: Text(
                              faqData[index].faqBody,
                              style: AppStyling.light300Size13
                                  .copyWith(color: AppColors.textDarkColor),
                            ),
                          ),
                          headerBuilder:
                              (BuildContext context, bool isExpanded) {
                            return Container(
                              padding: const EdgeInsets.only(
                                  left: 20.0,
                                  right: 15.0,
                                  top: 15.0,
                                  bottom: 15.0),
                              child: Text(
                                faqData[index].faqHeader,
                                style: AppStyling.normal500Size16
                                    .copyWith(color: AppColors.primaryColor),
                              ),
                            );
                          },
                          isExpanded: faqData[index].isExpanded,
                        ),
                      ],
                      expansionCallback: (int item, bool status) {
                        setState(() {
                          faqData[index].isExpanded =
                              !faqData[index].isExpanded;
                        });
                      },
                    ),
                    SizedBox(
                      height: 0.6,
                      width: double.infinity,
                      child: Container(
                        color: AppColors.lightAshColor,
                      ),
                    ),
                  ],
                );
              },
            ),
            Container(
              padding: const EdgeInsets.all(20.0),
              child: GestureDetector(
                onTap: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextGradient(
                        textHere: AppString.moreDetails.localize(context),
                        textStyle: AppStyling.normal400Size14),
                    const SizedBox(
                      width: 6.0,
                    ),
                    Image.asset(AppImages.icForwardArrow,
                        width: 14, height: 14),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
