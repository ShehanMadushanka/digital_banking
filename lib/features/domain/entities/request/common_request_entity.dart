import '../../../data/models/requests/common_request.dart';

class CommonRequestEntity extends CommonRequest {
  final String messageType;

  const CommonRequestEntity({this.messageType}) : super(messageType: messageType);
}
