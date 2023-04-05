import 'package:cdb_mobile/features/data/models/responses/city_response.dart';
import 'package:cdb_mobile/features/domain/entities/response/custom_field_entity.dart';
import 'package:cdb_mobile/features/presentation/bloc/drop_down/drop_down_event.dart';
import 'package:cdb_mobile/features/presentation/widgets/cdb_drop_down/cdb_drop_down.dart';
import 'package:cdb_mobile/features/presentation/widgets/cdb_drop_down/drop_down_view.dart';
import 'package:cdb_mobile/features/presentation/widgets/cdb_text_fields/cdb_text_field.dart';
import 'package:cdb_mobile/utils/enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_constants.dart';
import 'app_styling.dart';
import 'navigation_routes.dart';

class AppUtils {
  static String convertBase64(String encodeData) {
    return 'data:image/jpeg;base64,$encodeData';
  }

  static KYCStep getKYCEnum(String step) {
    for (final KYCStep candidate in KYCStep.values) {
      if (step == candidate.toString()) {
        return candidate;
      }
    }
    return KYCStep.PERSONALINFO;
  }

  static convert24Hto12(String time) {
    final h = int.parse(time.split(':')[0]);
    final m = int.parse(time.split(':')[1]);
    return '${h > 12 ? _addZeroPadTime(h - 12) : '$h'}:${_addZeroPadTime(m)} ${h > 12 ? 'PM' : 'AM'}';
  }

  static convert12Hto24(String time) {
    final h = int.parse(time.split(':')[0]);
    final m = int.parse(time.split(':')[1].split(' ')[0]);
    final a = time.split(':')[1].split(' ')[1];

    return '${a == 'AM' ? _addZeroPadTime(h) : (h + 12)}:${_addZeroPadTime(m)}:00';
  }

  static String _addZeroPadTime(int value) {
    if (value > 9) {
      return value.toString();
    } else {
      return '0$value';
    }
  }

  List<Widget> generateDynamicFields(
      BuildContext context, List<CustomFieldEntity> customFields,
      {String fieldType, VoidCallback onRefresh, Color labelTextColor}) {
    List<Widget> widgetList = [];
    customFields.forEach(
      (element) {
        fieldType ??= element.customFieldDetailsEntity.fieldTypeEntity.name;
        if (fieldType == fieldTypeTextField) {
          widgetList.add(
            CdbCustomTextField(
              labelText: element.customFieldDetailsEntity.name,
              maxLength: int.parse(element.customFieldDetailsEntity.length),
              initialValue: '',
              /*inputFormatter: [
                if (element.customFieldDetailsEntity.validation != null &&
                    element.customFieldDetailsEntity.validation.isNotEmpty)
                  FilteringTextInputFormatter.allow(RegExp(
                      "r'${element.customFieldDetailsEntity.validation}'")),
              ],*/
              onChange: (value) {
                element.userValue = value;
              },
            ),
          );

          widgetList.add(
            const SizedBox(
              height: kLeftRightMarginOnBoarding,
            ),
          );
        } else if (fieldType == fieldTypeOneLineLabelField) {
          widgetList.add(Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                element.customFieldDetailsEntity.name,
                style: AppStyling.normal600Size14
                    .copyWith(color: AppColors.textTitleColor),
              ),
              Text(
                element.userValue ?? '',
                style: AppStyling.normal500Size16
                    .copyWith(color: AppColors.textDarkColor),
              ),
            ],
          ));

          widgetList.add(
            const SizedBox(
              height: kOnBoardingMarginBetweenFields,
            ),
          );
        } else if (fieldType == fieldTypeLableField) {
          widgetList.add(Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                element.customFieldDetailsEntity.name,
                style: AppStyling.normal400Size14
                    .copyWith(color: AppColors.textTitleColor),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  element.customFieldValue,
                  style: AppStyling.normal500Size16.copyWith(
                      color: labelTextColor ?? AppColors.textLightColor),
                ),
              ),
            ],
          ));
          widgetList.add(
            const SizedBox(
              height: kOnBoardingMarginBetweenFields,
            ),
          );
        } else if (fieldType == fieldTypeDropDown) {
          widgetList.add(
            CdbDropDown(
              initialValue: element.userValue ?? '',
              suffixIcon: const Icon(Icons.keyboard_arrow_down,
                  color: AppColors.textDarkColor),
              labelText: element.customFieldName,
              onTap: () async {
                final result = await Navigator.pushNamed(
                  context,
                  Routes.kDropDownView,
                  arguments: DropDownViewScreenArgs(
                    pageTitle: element.customFieldName,
                    isSearchable: true,
                    dropDownEvent: GetCustomDropDownEvent(
                        dataList: element.customFieldValue != null
                            ? element.customFieldValue.split(',')
                            : []),
                  ),
                ) as CommonDropDownResponse;

                if (result != null) {
                  element.userValue = result.description;
                  if (onRefresh != null) onRefresh();
                }
              },
            ),
          );

          widgetList.add(
            const SizedBox(
              height: kOnBoardingMarginBetweenFields,
            ),
          );
        }
      },
    );

    return widgetList;
  }
}
