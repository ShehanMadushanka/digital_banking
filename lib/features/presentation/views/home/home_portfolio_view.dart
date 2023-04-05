import 'package:flutter/material.dart';

class HomePortfolioView extends StatefulWidget {
  const HomePortfolioView({Key key}) : super(key: key);

  @override
  _HomePortfolioViewState createState() => _HomePortfolioViewState();
}

class _HomePortfolioViewState extends State<HomePortfolioView> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text("Portfolio View")
    );
  }
}