import 'package:cdb_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:cdb_mobile/features/presentation/bloc/base_event.dart';
import 'package:cdb_mobile/features/presentation/bloc/base_state.dart';
import 'package:cdb_mobile/features/presentation/bloc/on_boarding/other_products/other_products_bloc.dart';
import 'package:cdb_mobile/features/presentation/views/on_boarding/review_view.dart';
import 'package:cdb_mobile/features/presentation/widgets/cdb_buttons/cdb_border_gradient_button.dart';
import 'package:cdb_mobile/features/presentation/widgets/cdb_buttons/cdb_no_border_background_button.dart';
import 'package:cdb_mobile/features/presentation/widgets/cdb_default_appbar.dart';
import 'package:cdb_mobile/features/presentation/widgets/cdb_scrollview.dart';
import 'package:cdb_mobile/features/presentation/widgets/cdb_text_fields/cdb_text_field.dart';
import 'package:cdb_mobile/utils/app_colors.dart';
import 'package:cdb_mobile/utils/app_constants.dart';
import 'package:cdb_mobile/utils/app_images.dart';
import 'package:cdb_mobile/utils/app_strings.dart';
import 'package:cdb_mobile/utils/app_styling.dart';
import 'package:flutter/material.dart';

import '../base_view.dart';

class SaveBillerView extends BaseView {
  const SaveBillerView({Key key}) : super(key: key);

  @override
  _SaveBillerViewState createState() => _SaveBillerViewState();
}

class _SaveBillerViewState extends BaseViewState<SaveBillerView> {
  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: const CDBMainAppBar(
        appBarTitle: 'Save Biller',
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return CDBScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: constraints.maxWidth,
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const DetailItemView(
                        title: 'Biller Category',
                        value: 'Telecommunication',
                      ),
                      const DetailItemView(
                        title: 'Service Provider',
                        value: 'Mobitel',
                      ),
                      const DetailItemView(
                        title: 'Mobile Number',
                        value: '071 123 1234',
                      ),
                      CdbCustomTextField(
                        suffixIcon: Container(
                          transform: Matrix4.translationValues(0.0, 0.0, .0),
                          child: IconButton(
                            splashRadius: 18,
                            padding: EdgeInsets.zero,
                            icon: const Icon(
                              Icons.info_outline_rounded,
                              size: 18,
                            ),
                            color: AppColors.textDarkColor,
                            onPressed: () {},
                          ),
                        ),
                        labelText: 'Biller Nickname',
                        onChange: (value) {},
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: kLeftRightMarginOnBoarding,
                          right: kLeftRightMarginOnBoarding,
                        ),
                        child: Column(
                          children: [
                            CDBBorderGradientButton(
                              width: double.maxFinite,
                              onTap: () {
                                showCDBDialog(
                                  title: 'Success',
                                  body: Column(
                                    children: [
                                      Text(
                                        'Your biller details are saved successfully.',
                                        style: AppStyling.light300Size13
                                            .copyWith(
                                                color: AppColors.textDarkColor),
                                      ),
                                    ],
                                  ),
                                  negativeButtonText: 'Home',
                                  negativeButtonTap: () {
                                    Navigator.pop(context);
                                  },
                                  isTwoButton: true,
                                  positiveButtonText: 'Pay Another Bill',
                                  alertImagePath: AppImages.toastSuccessIcon,
                                  positiveButtonTap: () {},
                                );
                              },
                              text: AppString.save.localize(context),
                            ),
                            CDBNoBorderBackgroundButton(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              text: 'Cancel',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return OtherProductsBloc();
  }
}
