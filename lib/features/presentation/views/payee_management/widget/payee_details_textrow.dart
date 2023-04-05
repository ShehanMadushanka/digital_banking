import 'package:flutter/material.dart';

class DetailsField extends StatelessWidget {
  final String field1;
  final String field2;

  const DetailsField({
    Key key,
    @required this.field1,
    @required this.field2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 27.0),
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
              padding: const EdgeInsets.only(left: 40.0),
              child: Text(
                field2,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
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
