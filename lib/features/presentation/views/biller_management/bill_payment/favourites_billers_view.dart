import 'package:cdb_mobile/features/domain/entities/response/biller_entity.dart';
import 'package:cdb_mobile/features/domain/entities/response/saved_biller_entity.dart';
import 'package:cdb_mobile/features/presentation/views/biller_management/widget/biller_component.dart';
import 'package:cdb_mobile/utils/app_constants.dart';
import 'package:flutter/material.dart';

class FavouriteBillersView extends StatefulWidget {
  const FavouriteBillersView({Key key}) : super(key: key);

  @override
  _FavouriteBillersViewState createState() => _FavouriteBillersViewState();
}

class _FavouriteBillersViewState extends State<FavouriteBillersView> {
  List<SavedBillerEntity> _billers = [
    SavedBillerEntity(
      isFavorite: true,
      mobileNumber: '071 123 1234',
      serviceProvider: BillerEntity(
          billerName: 'Dialog',
          billerImage:
              'https://www.britishcouncil.lk/sites/default/files/styles/bc-landscape-800x450/public/5.jpg?itok=uuRGKI_k'),
      nickName: 'My Dialog 1',
    ),
    SavedBillerEntity(
      isFavorite: true,
      mobileNumber: '071 123 1234',
      serviceProvider: BillerEntity(
          billerName: 'Dialog',
          billerImage:
              'https://www.britishcouncil.lk/sites/default/files/styles/bc-landscape-800x450/public/5.jpg?itok=uuRGKI_k'),
      nickName: 'My Dialog 1',
    ),
    SavedBillerEntity(
      isFavorite: true,
      mobileNumber: '071 123 1234',
      serviceProvider: BillerEntity(
          billerName: 'Dialog',
          billerImage:
              'https://www.britishcouncil.lk/sites/default/files/styles/bc-landscape-800x450/public/5.jpg?itok=uuRGKI_k'),
      nickName: 'My Dialog 1',
    ),
    SavedBillerEntity(
      isFavorite: true,
      mobileNumber: '071 123 1234',
      serviceProvider: BillerEntity(
          billerName: 'Dialog',
          billerImage:
              'https://www.britishcouncil.lk/sites/default/files/styles/bc-landscape-800x450/public/5.jpg?itok=uuRGKI_k'),
      nickName: 'My Dialog 1',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: kOnBoardingMarginBetweenFields,
          bottom: kBottomMargin,
          left: kLeftRightMarginOnBoarding,
          right: kLeftRightMarginOnBoarding),
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: _billers.length,
        itemBuilder: (_, index) => BillerComponent(
          billerEntity: _billers[index],
          onTap: () {},
        ),
      ),
    );
  }
}
