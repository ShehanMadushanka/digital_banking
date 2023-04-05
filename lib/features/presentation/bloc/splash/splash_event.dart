import 'package:cdb_mobile/features/presentation/bloc/base_event.dart';

abstract class SplashEvent extends BaseEvent {}

class SplashRequestEvent extends SplashEvent {
  final String deviceChannel;

  SplashRequestEvent({this.deviceChannel});
}

class GetStepperValueEvent extends SplashEvent {

}

class RequestPushToken extends SplashEvent{

}