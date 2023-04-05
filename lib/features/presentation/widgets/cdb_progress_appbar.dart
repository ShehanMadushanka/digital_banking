import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_extensions.dart';
import '../../../utils/app_styling.dart';
import '../../../utils/enums.dart';
import 'appbar_progress_indicator.dart';
import 'cdb_appbar/cdb_appbar.dart';
import 'cdb_stepper/cdb_stepper_view.dart';
import 'cdb_topsheet.dart';

class CDBProgressAppBar extends StatefulWidget implements PreferredSizeWidget {
  final KYCStep step;
  final VoidCallback onTapBack;
  final VoidCallback onEdit;
  final bool showStep;
  final String customAppBarTitle;

  const CDBProgressAppBar(
      {Key key,
      @required this.step,
      this.onTapBack,
      this.showStep = true,
      this.customAppBarTitle,
      this.onEdit})
      : super(key: key);

  @override
  _CDBProgressAppBarState createState() => _CDBProgressAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(showStep ? 70.0 : 50.0);
}

class _CDBProgressAppBarState extends State<CDBProgressAppBar> {
  @override
  Widget build(BuildContext context) {
    return CDBAppbar(
      title: widget.showStep
          ? Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: SvgPicture.asset(
                    widget.step.getStepIcon(),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('STEP  ${widget.step.getStep()} / 5',
                        style: AppStyling.bold700Size10),
                    Text(widget.step.getLabel(context),
                        style: AppStyling.normal600Size16),
                  ],
                ),
              ],
            )
          : Text(
              widget.customAppBarTitle ??
                  ((widget.step == KYCStep.REVIEW || widget.step == KYCStep.TNC)
                      ? widget.step.getLabel(context)
                      : 'Edit ${widget.step.getLabel(context)}'),
              style: AppStyling.normal500Size16.copyWith(color: Colors.white)),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: widget.onTapBack,
      ),
      actions: [
        if (widget.onEdit != null)
          TextButton(
            onPressed: widget.onEdit,
            child: Text(
              'Edit',
              style: AppStyling.normal500Size16.copyWith(
                color: AppColors.whiteColor,
              ),
            ),
          ),
        if (widget.showStep)
          IconButton(
            icon: const Icon(Icons.keyboard_arrow_down_sharp,
                color: Colors.white),
            onPressed: () {
              FocusScope.of(context).unfocus();
              CDBTopSheet.show(
                context: context,
                child: CDBStepperView(currentStep: widget.step),
                direction: TopSheetDirection.TOP,
              );
            },
          )
        else
          const SizedBox.shrink()
      ],
      bottom: AppBarProgressIndicator(
        backgroundColor: Colors.white.withOpacity(0.25),
        progressColor: AppColors.accentColor,
        animation: widget.showStep,
        percent: (widget.showStep ? widget.step.getStep() : 5) / 5,
      ),
    );
  }
}
