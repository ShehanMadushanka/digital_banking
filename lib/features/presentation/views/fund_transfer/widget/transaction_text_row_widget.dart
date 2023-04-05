import 'package:flutter/material.dart';

import '../../../../../utils/app_styling.dart';

class TransactionTextRow extends StatelessWidget {
  final String title;
  final String accName;
  final String accNumber;
  const TransactionTextRow({
    Key key, this.title, this.accName, this.accNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppStyling.normal400Size14,
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children:  [
              Padding(
                padding: const EdgeInsets.only(left: 40.0),
                child: Text(
                  accName,
                  style: AppStyling.normal600Size14,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40.0),
                child: Text(
                  accNumber,
                  style: AppStyling.normal300Size13,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}