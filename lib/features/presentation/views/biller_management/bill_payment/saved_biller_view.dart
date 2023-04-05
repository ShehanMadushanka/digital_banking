import 'package:cdb_mobile/features/domain/entities/response/biller_entity.dart';
import 'package:cdb_mobile/features/domain/entities/response/saved_biller_entity.dart';
import 'package:cdb_mobile/features/presentation/views/biller_management/widget/biller_component.dart';
import 'package:cdb_mobile/features/presentation/widgets/cdb_text_fields/cdb_post_login_search_text_field.dart';
import 'package:cdb_mobile/utils/app_constants.dart';
import 'package:flutter/material.dart';

class SavedBillerView extends StatefulWidget {
  const SavedBillerView({Key key}) : super(key: key);

  @override
  _SavedBillerViewState createState() => _SavedBillerViewState();
}

class _SavedBillerViewState extends State<SavedBillerView> {
  final List<SavedBillerEntity> _billers = [
    SavedBillerEntity(
      isFavorite: true,
      mobileNumber: '071 123 1234',
      serviceProvider: BillerEntity(
          billerName: 'Mobitel',
          billerImage:
              'https://i2.wp.com/www.mobileworldlive.com/wp-content/uploads/2017/05/Mobitel_logo.png?w=348&ssl=1'),
      nickName: 'Amma Mobitel',
    ),
    SavedBillerEntity(
      isFavorite: true,
      mobileNumber: '071 123 1234',
      serviceProvider: BillerEntity(
          billerName: 'Mobitel',
          billerImage:
              'https://i2.wp.com/www.mobileworldlive.com/wp-content/uploads/2017/05/Mobitel_logo.png?w=348&ssl=1'),
      nickName: 'GF Mobitel',
    ),
    SavedBillerEntity(
      isFavorite: true,
      mobileNumber: '071 123 1234',
      serviceProvider: BillerEntity(
          billerName: 'Mobitel',
          billerImage:
              'https://i2.wp.com/www.mobileworldlive.com/wp-content/uploads/2017/05/Mobitel_logo.png?w=348&ssl=1'),
      nickName: 'Malli Mobitel',
    ),
    SavedBillerEntity(
      isFavorite: true,
      mobileNumber: '071 123 1234',
      serviceProvider: BillerEntity(
          billerName: 'Dialog',
          billerImage:
              'https://www.britishcouncil.lk/sites/default/files/styles/bc-landscape-800x450/public/5.jpg?itok=uuRGKI_k'),
      nickName: 'My Dialog',
    ),
    SavedBillerEntity(
      isFavorite: true,
      mobileNumber: '071 123 1234',
      serviceProvider: BillerEntity(
          billerName: 'Sri Lanka Insurance',
          billerImage:
              'https://lmd.lk/wp-content/uploads/2020/11/SLIC-Logo.png'),
      nickName: 'My Insurance',
    ),
    SavedBillerEntity(
      isFavorite: true,
      mobileNumber: '071 123 1234',
      serviceProvider: BillerEntity(
          billerName: 'People’s Leasing',
          billerImage:
              'https://www.lankabusinessonline.com/wp-content/uploads/2017/12/PEOPLES-LEASING-FINANCE.jpg'),
      nickName: 'My Leasing',
    ),
  ];

  String _searchString = '';
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      setState(() {
        _searchString = _controller.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: kOnBoardingMarginBetweenFields,
          bottom: kBottomMargin,
          left: kLeftRightMarginOnBoarding,
          right: kLeftRightMarginOnBoarding),
      child: Column(
        children: [
          CDBPostLoginSearchTextField(
            hintText: 'Search Biller Nick Name or Biller Category',
            controller: _controller,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 16),
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: _billers.length,
                  itemBuilder: (_, index) => _searchString.isEmpty
                      ? BillerComponent(
                          billerEntity: _billers[index],
                          onTap: () {},
                        )
                      : _billers[index]
                              .nickName
                              .toLowerCase()
                              .contains(_searchString.toLowerCase())
                          ? BillerComponent(
                              billerEntity: _billers[index],
                              onTap: () {},
                            )
                          : const SizedBox.shrink()),
            ),
          ),
        ],
      ),
    );
  }
}
