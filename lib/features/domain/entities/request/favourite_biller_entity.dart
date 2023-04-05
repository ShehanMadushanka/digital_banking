import 'package:cdb_mobile/features/data/models/requests/favourite_biller_request.dart';


class FavouriteBillerEntity extends FavouriteBillerRequest {
  final String messageType;
  final int billerId;

  FavouriteBillerEntity({this.messageType, this.billerId})
      : super(
          messageType: messageType,
          billerId: billerId,
        );
}
