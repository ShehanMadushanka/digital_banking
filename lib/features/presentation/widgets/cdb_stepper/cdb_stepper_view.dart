import 'package:cdb_mobile/utils/app_colors.dart';
import 'package:cdb_mobile/utils/app_extensions.dart';
import 'package:cdb_mobile/utils/app_images.dart';
import 'package:cdb_mobile/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CDBStepperView extends StatelessWidget {
  final KYCStep currentStep;

  const CDBStepperView({Key key, this.currentStep}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Flexible(
            child: RawScrollbar(
              thumbColor: AppColors.accentColor,
              radius: const Radius.circular(10.0),
              thickness: 6,
              child: ListView(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: CDBStepper(currentStep: currentStep),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: [
              const Divider(
                color: AppColors.separationLinesColor,
                thickness: 1,
              ),
              const SizedBox(
                height: 20,
              ),
              Image.asset(AppImages.cdbIPayLogo, width: 142, height: 48),
              const SizedBox(
                height: 18,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Container(
                  width: 48,
                  height: 4,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: AppColors.dividerColor,
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

class CDBStepper extends StatelessWidget {
  final KYCStep currentStep;
  final StepperState state;

  const CDBStepper({Key key, this.currentStep, this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildStepper(),
      ),
    );
  }

  List<Widget> _buildStepper() {
    switch (currentStep) {
      case KYCStep.PERSONALINFO:
        return [
          const Step(
              currentStep: KYCStep.PERSONALINFO, state: StepperState.PENDING),
          const Step(
              currentStep: KYCStep.CONTACTINFO, state: StepperState.INACTIVE),
          const Step(
              currentStep: KYCStep.EMPDETAILS, state: StepperState.INACTIVE),
          const Step(
              currentStep: KYCStep.OTHERINFO, state: StepperState.INACTIVE),
          const Step(
              currentStep: KYCStep.DOCUMENTVERIFY,
              state: StepperState.INACTIVE),
        ];
      case KYCStep.CONTACTINFO:
        return [
          const Step(
              currentStep: KYCStep.PERSONALINFO, state: StepperState.COMPLETED),
          const Step(
              currentStep: KYCStep.CONTACTINFO, state: StepperState.PENDING),
          const Step(
              currentStep: KYCStep.EMPDETAILS, state: StepperState.INACTIVE),
          const Step(
              currentStep: KYCStep.OTHERINFO, state: StepperState.INACTIVE),
          const Step(
              currentStep: KYCStep.DOCUMENTVERIFY,
              state: StepperState.INACTIVE),
        ];
      case KYCStep.EMPDETAILS:
        return [
          const Step(
              currentStep: KYCStep.PERSONALINFO, state: StepperState.COMPLETED),
          const Step(
              currentStep: KYCStep.CONTACTINFO, state: StepperState.COMPLETED),
          const Step(
              currentStep: KYCStep.EMPDETAILS, state: StepperState.PENDING),
          const Step(
              currentStep: KYCStep.OTHERINFO, state: StepperState.INACTIVE),
          const Step(
              currentStep: KYCStep.DOCUMENTVERIFY,
              state: StepperState.INACTIVE),
        ];
      case KYCStep.OTHERINFO:
        return [
          const Step(
              currentStep: KYCStep.PERSONALINFO, state: StepperState.COMPLETED),
          const Step(
              currentStep: KYCStep.CONTACTINFO, state: StepperState.COMPLETED),
          const Step(
              currentStep: KYCStep.EMPDETAILS, state: StepperState.COMPLETED),
          const Step(
              currentStep: KYCStep.OTHERINFO, state: StepperState.PENDING),
          const Step(
              currentStep: KYCStep.DOCUMENTVERIFY,
              state: StepperState.INACTIVE),
        ];
      case KYCStep.DOCUMENTVERIFY:
        return [
          const Step(
              currentStep: KYCStep.PERSONALINFO, state: StepperState.COMPLETED),
          const Step(
              currentStep: KYCStep.CONTACTINFO, state: StepperState.COMPLETED),
          const Step(
              currentStep: KYCStep.EMPDETAILS, state: StepperState.COMPLETED),
          const Step(
              currentStep: KYCStep.OTHERINFO, state: StepperState.COMPLETED),
          const Step(
              currentStep: KYCStep.DOCUMENTVERIFY, state: StepperState.PENDING),
        ];
      default:
        return [
          const Step(
              currentStep: KYCStep.PERSONALINFO, state: StepperState.PENDING),
          const Step(
              currentStep: KYCStep.CONTACTINFO, state: StepperState.INACTIVE),
          const Step(
              currentStep: KYCStep.EMPDETAILS, state: StepperState.INACTIVE),
          const Step(
              currentStep: KYCStep.OTHERINFO, state: StepperState.INACTIVE),
          const Step(
              currentStep: KYCStep.DOCUMENTVERIFY,
              state: StepperState.INACTIVE),
          const Step(
              currentStep: KYCStep.SCHEDULEVERIFY, state: StepperState.INACTIVE)
        ];
    }
  }
}

class CompleteState extends StatelessWidget {
  const CompleteState({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: AppColors.greenGradient,
      ),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Positioned(
            top: -25,
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
            ),
          ),
          const Icon(Icons.done_rounded, color: Colors.white),
        ],
      ),
    );
  }
}

class PendingState extends StatelessWidget {
  final String icon;

  const PendingState({Key key, @required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: AppColors.blueGradient,
        border: Border.all(color: AppColors.accentColor),
        boxShadow: [
          BoxShadow(
            color: AppColors.accentColor.withOpacity(0.5),
            blurRadius: 8.0,
            offset: const Offset(
              0.0,
              2.0,
            ),
          ),
          BoxShadow(
            color: AppColors.accentColor.withOpacity(0.5),
            blurRadius: 8.0,
            offset: const Offset(
              0.0,
              -2.0,
            ),
          ),
        ],
      ),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Positioned(
            top: -25,
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
            ),
          ),
          SvgPicture.asset(icon, color: Colors.white, fit: BoxFit.scaleDown),
        ],
      ),
    );
  }
}

class InactiveState extends StatelessWidget {
  final String icon;

  const InactiveState({Key key, @required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: const BoxDecoration(
          shape: BoxShape.circle, color: AppColors.lightAshColor),
      child: SvgPicture.asset(icon,
          color: AppColors.darkAshColor, fit: BoxFit.scaleDown),
    );
  }
}

class Step extends StatelessWidget {
  final KYCStep currentStep;
  final StepperState state;

  const Step({Key key, this.currentStep, this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            _getState(),
            if (currentStep == KYCStep.DOCUMENTVERIFY)
              const SizedBox.shrink()
            else
              Padding(
                padding: const EdgeInsets.all(5),
                child: Container(
                  height: 25,
                  width: 4,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: state == StepperState.COMPLETED
                        ? AppColors.successGreenColor
                        : AppColors.lightAshColor,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(
          width: 24,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Text('STEP  ${currentStep.getStep()}',
                style: TextStyle(
                    color: state == StepperState.INACTIVE
                        ? AppColors.textLightColor
                        : (state == StepperState.COMPLETED
                            ? AppColors.successGreenColor
                            : AppColors.accentColor),
                    fontWeight: FontWeight.w700,
                    fontSize: 10)),
            const SizedBox(
              height: 2,
            ),
            Text(currentStep.getLabel(context),
                style: TextStyle(
                    color: state == StepperState.INACTIVE
                        ? AppColors.textLightColor
                        : AppColors.textDarkColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 16)),
          ],
        ),
      ],
    );
  }

  Widget _getState() {
    switch (state) {
      case StepperState.COMPLETED:
        return const CompleteState();
      case StepperState.PENDING:
        return PendingState(icon: currentStep.getStepperIcon());
      case StepperState.INACTIVE:
        return InactiveState(icon: currentStep.getStepperIcon());
      default:
        return InactiveState(icon: currentStep.getStepperIcon());
    }
  }
}
