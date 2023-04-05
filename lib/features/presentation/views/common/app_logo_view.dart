import 'package:flutter/material.dart';

class AppLogoView extends StatelessWidget {
  const AppLogoView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(width: 6),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'CDB Mobile Banking',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700, color: Colors.white),
              ),
              Text(
                'Let’s digitalized',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
