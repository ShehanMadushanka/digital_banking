import 'package:flutter/material.dart';

class DetailsField extends StatelessWidget {
  final String field1;
  final String field2;
  final double bottomPadding;

  const DetailsField({
    Key key,
    @required this.field1,
    @required this.field2,
    @required this.bottomPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            field1,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xff555454),
              fontWeight: FontWeight.w600,
            ),
          ),
          Flexible(
            child: Padding(
              padding: EdgeInsets.only(left: 40.0),
              child: Text(
                field2,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
