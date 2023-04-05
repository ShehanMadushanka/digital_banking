import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:geolocator/geolocator.dart';
import 'package:package_info/package_info.dart';
import 'package:wifi/wifi.dart';
//import 'package:cdb_mobile/core/dependancy/wifi/wifi.dart';
import '../core/configurations/app_config.dart';
import '../features/data/datasources/local_data_source.dart';
import 'app_extensions.dart';
import 'model/device_info.dart';

class DeviceData {
  final DeviceInfoPlugin deviceInfo;
  final LocalDataSource sharedData;
  final PackageInfo packageInfo;

  DeviceData({this.deviceInfo, this.sharedData, this.packageInfo});

  Future<DeviceInfoRequest> getDeviceData() async {
    DeviceInfoRequest deviceData;

    if (Platform.isAndroid) {
      deviceData = await _readAndroidBuildData(
          await deviceInfo.androidInfo, await _determinePosition());
    } else if (Platform.isIOS) {
      deviceData = await _readIosDeviceInfo(
          await deviceInfo.iosInfo, await _determinePosition());
    }
    return deviceData;
  }

  Future<DeviceInfoRequest> _readAndroidBuildData(
      AndroidDeviceInfo build, Position position) async {
    final deviceID = await FlutterUdid.consistentUdid;
    final ip = await Wifi.ip;
    final pushID = await sharedData.getPushToken();

    final dd = Dd(
      deviceId: deviceID,
      deviceModel: build.model,
      deviceName: Platform.isAndroid ? build.model : build.product,
      osName:
          Platform.isAndroid ? kDeviceOS.getValue() : build.version.codename,
      osVersion:
          Platform.isAndroid ? build.version.release : build.version.baseOS,
      platform: Platform.isAndroid ? 'Android' : build.androidId,
      latitude: position.latitude.toString(),
      locale: "en_US",
      ip: ip,
      timeZone: "Eastern Standard Time",
      screenResolution:
          '${ScreenUtil().screenWidth.toStringAsFixed(0)}x${ScreenUtil().screenHeight.toStringAsFixed(0)}',
      longitude: position.longitude.toString(),
      pushId: pushID,
    );

    return DeviceInfoRequest(dv: packageInfo.version, dd: dd);
  }

  Future<DeviceInfoRequest> _readIosDeviceInfo(
      IosDeviceInfo data, Position position) async {
    final deviceID = await FlutterUdid.consistentUdid;
    final ip = await Wifi.ip;
    final pushID = await sharedData.getPushToken();

    final dd = Dd(
      deviceId: deviceID,
      deviceModel: data.model,
      deviceName: data.name,
      osName: data.systemName,
      osVersion: data.systemVersion,
      platform: "iOS",
      latitude: position.latitude.toStringAsFixed(2),
      locale: "en_US",
      ip: ip,
      timeZone: "Eastern Standard Time",
      screenResolution:
          '${ScreenUtil().screenWidth}x${ScreenUtil().screenHeight}',
      longitude: position.longitude.toStringAsFixed(2),
      pushId: pushID,
    );

    return DeviceInfoRequest(dv: packageInfo.version, dd: dd);
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Position(latitude: 0.0, longitude: 0.0);
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.deniedForever) {
      return Position(latitude: 0.0, longitude: 0.0);
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return Position(latitude: 0.0, longitude: 0.0);
      }
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }
}
