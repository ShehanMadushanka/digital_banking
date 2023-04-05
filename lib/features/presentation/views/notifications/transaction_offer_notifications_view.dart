import 'package:cdb_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:cdb_mobile/features/presentation/bloc/base_event.dart';
import 'package:cdb_mobile/features/presentation/bloc/base_state.dart';
import 'package:cdb_mobile/features/presentation/bloc/on_boarding/schedule_verification/schedule_verification_bloc.dart';
import 'package:cdb_mobile/features/presentation/bloc/on_boarding/schedule_verification/schedule_verification_state.dart';
import 'package:cdb_mobile/features/presentation/views/notifications/notification_widget/notification_bottom_app_bar.dart';
import 'package:cdb_mobile/features/presentation/views/notifications/notification_widget/notification_component.dart';
import 'package:cdb_mobile/features/presentation/views/notifications/notification_widget/notification_empty_view.dart';
import 'package:cdb_mobile/features/presentation/widgets/cdb_default_appbar.dart';
import 'package:cdb_mobile/features/presentation/widgets/cdb_drop_down/cdb_drop_down.dart';
import 'package:cdb_mobile/features/presentation/widgets/cdb_item_selector.dart';
import 'package:cdb_mobile/features/presentation/widgets/cdb_scrollview.dart';
import 'package:cdb_mobile/utils/app_colors.dart';
import 'package:cdb_mobile/utils/app_images.dart';
import 'package:cdb_mobile/utils/app_styling.dart';
import 'package:cdb_mobile/utils/navigation_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/services/dependency_injection.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../../utils/app_strings.dart';
import '../base_view.dart';

class NotificationData {
  String title;
  String date;
  String description;
  bool isSelected;
  bool isRead;

  NotificationData({
    this.title,
    this.description,
    this.date,
    this.isSelected = false,
    this.isRead = false,
  });
}

class NotificationsView extends BaseView {
  final bool isEditingEnabled;

  const NotificationsView({Key key, this.isEditingEnabled}) : super(key: key);

  @override
  _AddPaymentInstrumentRootViewState createState() =>
      _AddPaymentInstrumentRootViewState();
}

class _AddPaymentInstrumentRootViewState
    extends BaseViewState<NotificationsView> {
  final ScheduleVerificationBloc _scheduleVerificationBloc =
      inject<ScheduleVerificationBloc>();
  int _selectedIndex = 0;
  List<CDBSelectionItem> selectionItems = [];
  List<NotificationData> transactionNotificationList = [];
  List<NotificationData> offerNotificationList = [];

  bool selected = false;

  ///Veriable
  bool isPaymentSuccess = true;
  String payFromName;
  String payToName;
  String date;
  String referenceNumber;
  String remark;
  String time;

  String value = "All Offers";

  @override
  void initState() {
    super.initState();
    _updateUI();
    selectionItems.addAll([
      CDBSelectionItem(title: 'Transactions', isSelected: true),
      CDBSelectionItem(title: '      Offers      '),
    ]);

    transactionNotificationList.addAll([
      NotificationData(
        title: "Fund Transfer",
        description: "You have transfered LKR.20000 to 2012564255 ",
        date: "13-oct-2021",
      ),
      NotificationData(
        title: "Fund Transfer",
        description: "You have transfered LKR.20000 to 2012564255 ",
        date: "13-oct-2021",
      ),
      NotificationData(
        title: "Fund Transfer",
        description: "You have transfered LKR.20000 to 2012564255 ",
        date: "13-oct-2021",
      ),
      NotificationData(
        title: "Fund Transfer",
        description: "You have transfered LKR.20000 to 2012564255 ",
        date: "13-oct-2021",
      ),
      NotificationData(
        title: "Fund Transfer",
        description: "You have transfered LKR.20000 to 2012564255 ",
        date: "13-oct-2021",
      ),
      NotificationData(
        title: "Fund Transfer",
        description: "You have transfered LKR.20000 to 2012564255 ",
        date: "13-oct-2021",
      ),
      NotificationData(
        title: "Fund Transfer",
        description: "You have transfered LKR.20000 to 2012564255 ",
        date: "13-oct-2021",
      ),
    ]);

    offerNotificationList.addAll([
      NotificationData(
        title: "CDB Credit Card Offer",
        description: "Shop today at cargills and keels and get your...",
        date: "13-oct-2021",
      ),
      NotificationData(
        title: "CDB Credit Card Offer",
        description: "Shop today at cargills and keels and get your...",
        date: "13-oct-2021",
      ),
      NotificationData(
        title: "CDB Credit Card Offer",
        description: "Shop today at cargills and keels and get your...",
        date: "13-oct-2021",
      ),
      NotificationData(
        title: "CDB Credit Card Offer",
        description: "Shop today at cargills and keels and get your...",
        date: "13-oct-2021",
      ),
      NotificationData(
        title: "CDB Credit Card Offer",
        description: "Shop today at cargills and keels and get your...",
        date: "13-oct-2021",
      ),
      NotificationData(
        title: "CDB Credit Card Offer",
        description: "Shop today at cargills and keels and get your...",
        date: "13-oct-2021",
      ),
      NotificationData(
        title: "CDB Credit Card Offer",
        description: "Shop today at cargills and keels and get your...",
        date: "13-oct-2021",
      ),
    ]);
  }

  _updateUI() {
    isPaymentSuccess = true;
    payFromName = 'My CDB';
    payToName = '0712314567';
    date = '11-Oct-2021';
    referenceNumber = '010111123548';
    remark = 'Pay reload for Amma';
    time = '12:10 PM';
  }

  Future<bool> onBackPressed() {
    setState(() {
      backButtonOperation() ?? false;
    });
  }

  backButtonOperation() {
    AppConstants.Notification_selected_view = false;
    transactionNotificationList.forEach((element) {
      element.isSelected = false;
    });
    offerNotificationList.forEach((element) {
      element.isSelected = false;
    });
  }

  TextStyle textStyle1 =
      AppStyling.normal600Size14.copyWith(color: AppColors.primaryColor);
  TextStyle textStyle2 =
      AppStyling.normal600Size14.copyWith(color: AppColors.textDarkColor);
  TextStyle textStyle3 =
      AppStyling.normal600Size14.copyWith(color: AppColors.textDarkColor);
  TextStyle textStyle4 =
      AppStyling.normal600Size14.copyWith(color: AppColors.textDarkColor);

  @override
  Widget buildView(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPressed,
      child: Scaffold(
        
        appBar: CDBMainAppBar(
          appBarTitle: AppString.notificationsTitle.localize(context),
          onTapBack: () {
            Navigator.pop(context);
          },
        ),
        body: BlocProvider(
          create: (_) => _scheduleVerificationBloc,
          child: BlocListener<ScheduleVerificationBloc,
              BaseState<ScheduleVerificationState>>(
            listener: (context, state) {},
            child: Padding(
              padding: const EdgeInsets.only(
                top: kTopMarginOnBoarding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: CDBScrollView(
                      padding: EdgeInsets.zero,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          CDBItemSelector(
                            items: selectionItems,
                            onSelectItem: (index) {
                              print(index);
                              setState(() {
                                _selectedIndex = index;
                              });
                            },
                          ),
                          if (_selectedIndex == 1)
                            CdbDropDown(
                              onTap: () {
                                buildShowModalBottomSheet(context);
                              },
                              labelText: value,
                              suffixIcon: Icon(Icons.keyboard_arrow_down),
                            )
                          else
                            const SizedBox.shrink(),
                          _NotificstionListsViews(),
                        ],
                      ),
                    ),
                  ),
                  if (_selectedIndex == 0)
                    Column(
                      children: [
                        NotificationBottomAppBar(
                            onTapSelectAll: () {
                              if (_selectedIndex == 0) {
                                setState(() {
                                  transactionNotificationList
                                      .forEach((element) {
                                    element.isSelected = true;
                                  });
                                });
                              } else {
                                setState(() {
                                  offerNotificationList.forEach((element) {
                                    element.isSelected = true;
                                  });
                                });
                              }
                            },
                            iconOne: Icons.check_circle,
                            iconNameOne: 'Select All',
                            onTapMarkAsRead: () {
                              if (_selectedIndex == 0) {
                                setState(() {
                                  transactionNotificationList
                                      .forEach((element) {
                                    if (element.isSelected) {
                                      element.isRead = true;
                                    }
                                  });
                                  transactionNotificationList
                                      .forEach((element) {
                                    element.isSelected = false;
                                  });
                                  AppConstants.Notification_selected_view =
                                      false;
                                });
                              } else {
                                setState(() {
                                  offerNotificationList.forEach((element) {
                                    if (element.isSelected) {
                                      element.isRead = true;
                                    }
                                  });
                                  offerNotificationList.forEach((element) {
                                    element.isSelected = false;
                                  });
                                  AppConstants.Notification_selected_view =
                                      false;
                                });
                              }
                            },
                            iconTwo: Icons.check_circle_outline_sharp,
                            iconNameTwo: 'Mark as read',
                            onTapDelete: () {
                              if (_selectedIndex == 0) {
                                setState(() {
                                  transactionNotificationList.removeWhere(
                                      (element) => element.isSelected);
                                  AppConstants.Notification_selected_view =
                                      false;
                                });
                              } else {
                                setState(() {
                                  offerNotificationList.removeWhere(
                                      (element) => element.isSelected);
                                  AppConstants.Notification_selected_view =
                                      false;
                                });
                              }
                            },
                            iconThree: Icons.delete_outline,
                            iconNameThree: 'Delete'),
                      ],
                    )
                  else
                    const SizedBox.shrink(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> buildShowModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      useRootNavigator: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.45),
              child: const Divider(
                thickness: 5,
                color: Colors.black54,
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  value = "All Offers";
                  textStyle1 = AppStyling.normal600Size14
                      .copyWith(color: AppColors.primaryColor);
                  textStyle2 = AppStyling.normal600Size14
                      .copyWith(color: AppColors.textDarkColor);
                  textStyle3 = AppStyling.normal600Size14
                      .copyWith(color: AppColors.textDarkColor);
                  textStyle4 = AppStyling.normal600Size14
                      .copyWith(color: AppColors.textDarkColor);
                });
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16.0, top: 36),
                child: Text("All Offers", style: textStyle1),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Divider(
                thickness: 1,
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  value = "Seasonal Offers";
                  textStyle1 = AppStyling.normal600Size14
                      .copyWith(color: AppColors.textDarkColor);
                  textStyle2 = AppStyling.normal600Size14
                      .copyWith(color: AppColors.primaryColor);
                  textStyle3 = AppStyling.normal600Size14
                      .copyWith(color: AppColors.textDarkColor);
                  textStyle4 = AppStyling.normal600Size14
                      .copyWith(color: AppColors.textDarkColor);
                });
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text("Seasonal Offers", style: textStyle2),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Divider(
                thickness: 1,
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  value = "Credit Card Offers";
                  textStyle1 = AppStyling.normal600Size14
                      .copyWith(color: AppColors.textDarkColor);
                  textStyle2 = AppStyling.normal600Size14
                      .copyWith(color: AppColors.textDarkColor);
                  textStyle3 = AppStyling.normal600Size14
                      .copyWith(color: AppColors.primaryColor);
                  textStyle4 = AppStyling.normal600Size14
                      .copyWith(color: AppColors.textDarkColor);
                });
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text("Credit Card Offers", style: textStyle3),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Divider(
                thickness: 1,
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  textStyle1 = AppStyling.normal600Size14
                      .copyWith(color: AppColors.textDarkColor);
                  textStyle2 = AppStyling.normal600Size14
                      .copyWith(color: AppColors.textDarkColor);
                  textStyle3 = AppStyling.normal600Size14
                      .copyWith(color: AppColors.textDarkColor);
                  textStyle4 = AppStyling.normal600Size14
                      .copyWith(color: AppColors.primaryColor);
                  value = "Other Offers";
                });
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text("Other Offers", style: textStyle4),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _NotificstionListsViews() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: kTopMarginOnBoarding,
        ),
        if (_selectedIndex == 0)
          transactionNotificationList.isNotEmpty
              ? SingleChildScrollView(
                  child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: transactionNotificationList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return NotificationComponent(
                          data: transactionNotificationList[index],
                          imageName: AppImages.newNotificationIcon,
                          readImageName: AppImages.viewedNotificationIcon,
                          onLongPress: () {
                            setState(() {
                              AppConstants.Notification_selected_view = true;
                              transactionNotificationList[index].isSelected =
                                  true;
                            });
                          },
                          onPressed: () {
                            if (AppConstants.Notification_selected_view) {
                              setState(() {
                                if (transactionNotificationList[index]
                                    .isSelected) {
                                  transactionNotificationList[index]
                                      .isSelected = false;
                                } else if (transactionNotificationList[index]
                                        .isSelected ==
                                    false) {
                                  transactionNotificationList[index]
                                      .isSelected = true;
                                }
                              });
                            } else {
                              setState(() {
                                transactionNotificationList[index].isRead =
                                    true;
                              });
                              showCDBDialog(
                                // title:
                                // AppString.titlePayBills.localize(context),
                                body: Center(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 20),
                                        child: Text(
                                          AppString.success.localize(context),
                                          style: AppStyling.normal500Size16
                                              .copyWith(
                                                  color:
                                                      AppColors.textTitleColor),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 24),
                                        child: Text(
                                          AppString.payToMobile
                                              .localize(context),
                                          style: AppStyling.normal600Size16
                                              .copyWith(
                                                  color:
                                                      AppColors.textDarkColor),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Text(
                                          AppString.youHaveSuccessfully
                                              .localize(context),
                                          style: AppStyling.normal600Size14
                                              .copyWith(
                                                  color:
                                                      AppColors.textDarkColor),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 32, right: 32),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 43),
                                          child: Row(
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    AppString.from
                                                        .localize(context),
                                                    style: AppStyling
                                                        .normal600Size14
                                                        .copyWith(
                                                            color: AppColors
                                                                .textTitleColor),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                  Text(
                                                    payFromName,
                                                    style: AppStyling
                                                        .normal500Size16
                                                        .copyWith(
                                                            color: AppColors
                                                                .textDarkColor),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                ],
                                              ),
                                              const Spacer(),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    AppString.to
                                                        .localize(context),
                                                    style: AppStyling
                                                        .normal600Size14
                                                        .copyWith(
                                                            color: AppColors
                                                                .textTitleColor),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                  Text(
                                                    payToName,
                                                    style: AppStyling
                                                        .normal500Size16
                                                        .copyWith(
                                                            color: AppColors
                                                                .textDarkColor),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 32, top: 16),
                                        child: Row(
                                          children: [
                                            Text(
                                              AppString.dateAndTime
                                                  .localize(context),
                                              style: AppStyling.normal600Size14
                                                  .copyWith(
                                                      color: AppColors
                                                          .textTitleColor),
                                            ),
                                            Text(
                                              date,
                                              style: AppStyling.normal500Size16
                                                  .copyWith(
                                                      color: AppColors
                                                          .textDarkColor),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 16,
                                              ),
                                              child: Text(
                                                time,
                                                style: AppStyling
                                                    .normal500Size16
                                                    .copyWith(
                                                        color: AppColors
                                                            .textDarkColor),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 32, top: 16),
                                        child: Row(
                                          children: [
                                            Text(
                                              AppString.remarksNotification
                                                  .localize(context),
                                              style: AppStyling.normal600Size14
                                                  .copyWith(
                                                      color: AppColors
                                                          .textTitleColor),
                                            ),
                                            Text(
                                              remark,
                                              style: AppStyling.normal500Size16
                                                  .copyWith(
                                                      color: AppColors
                                                          .textDarkColor),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 32, top: 16, bottom: 40),
                                        child: Row(
                                          children: [
                                            Text(
                                              AppString
                                                  .referenceNumberNotification
                                                  .localize(context),
                                              style: AppStyling.normal600Size14
                                                  .copyWith(
                                                      color: AppColors
                                                          .textTitleColor),
                                            ),
                                            Text(
                                              referenceNumber,
                                              style: AppStyling.normal500Size16
                                                  .copyWith(
                                                      color: AppColors
                                                          .textDarkColor),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                positiveButtonText:
                                    AppString.ok.localize(context),
                                positiveButtonTap: () {
                                  // Navigator.pushNamedAndRemoveUntil(
                                  //     context, Routes.kLoginView, (route) => false);
                                },
                                negativeButtonText: '',
                                negativeButtonTap: () {},
                                alertImagePath: AppImages.toastSuccessIcon,
                              );
                            }
                          },
                        );
                      }),
                )
              : NotificationEmptyView()
        else
          offerNotificationList.isNotEmpty //Offer Notifications
              ? SingleChildScrollView(
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: offerNotificationList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return NotificationComponent(
                          data: offerNotificationList[index],
                          imageName: AppImages.offerNewNotificationIcon,
                          readImageName: AppImages.offerReadNotificationIcon,
                          onLongPress: () {
                            setState(() {
                              AppConstants.Notification_selected_view = true;
                              offerNotificationList[index].isSelected = true;
                            });
                          },
                          onPressed: () {
                            if (AppConstants.Notification_selected_view) {
                              setState(() {
                                if (offerNotificationList[index].isSelected) {
                                  offerNotificationList[index].isSelected =
                                      false;
                                } else if (offerNotificationList[index]
                                        .isSelected ==
                                    false) {
                                  offerNotificationList[index].isSelected =
                                      true;
                                }
                              });
                            } else {
                              setState(() {
                                offerNotificationList[index].isRead = true;
                              });

                              //Navigate to detail view
                              Navigator.pushNamed(
                                  context, Routes.kOfferAndNotificationView);
                            }
                          },
                        );
                      }),
                )
              : NotificationEmptyView(),
      ],
    );
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return _scheduleVerificationBloc;
  }

  bool validate() {
    return transactionNotificationList
        .where((element) => element.isSelected)
        .isNotEmpty;
  }
}
