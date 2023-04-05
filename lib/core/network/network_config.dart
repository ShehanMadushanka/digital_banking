import 'package:cdb_mobile/flavors/flavor_config.dart';

const kConnectionTimeout = 60 * 1000; //
const kReceiveTimeout = 60 * 1000;

// QA URL
// https://124.43.16.185:50558/qa/gateway/api/v1/splash/

class IPAddress {
  static const String DEV = '124.43.16.185:50558/';
  static const String QA = '124.43.16.185:50558/';
  static const String UAT = 'cdbipay.cdb.lk:50001/';
  static const String LIVE = 'cusapp02.ceylincolife.com/';
}

class ServerProtocol {
  static const String DEV = 'https://';
  static const String QA = 'https://';
  static const String UAT = 'https://';
  static const String LIVE = 'https://';
}

class ContextRoot {
  static const String DEV = 'qa/gateway/api/v1/';
  static const String QA = 'qa/gateway/api/v1/';
  static const String UAT = 'qa/gateway/api/v1/';
  static const String LIVE = 'prod/api/v1/';
}

class NetworkConfig {
  static String getNetworkUrl() {
    String url = _getProtocol() + _getIP() + _getContextRoot();
    return url;
  }

  static String _getContextRoot() {
    if (FlavorConfig.isDevelopment()) {
      return ContextRoot.DEV;
    } else if (FlavorConfig.isQA()) {
      return ContextRoot.QA;
    } else if (FlavorConfig.isUAT()) {
      return ContextRoot.UAT;
    } else {
      return ContextRoot.LIVE;
    }
  }

  static String _getProtocol() {
    if (FlavorConfig.isDevelopment()) {
      return ServerProtocol.DEV;
    } else if (FlavorConfig.isQA()) {
      return ServerProtocol.QA;
    } else if (FlavorConfig.isUAT()) {
      return ServerProtocol.UAT;
    } else {
      return ServerProtocol.LIVE;
    }
  }

  static String _getIP() {
    if (FlavorConfig.isDevelopment()) {
      return IPAddress.DEV;
    } else if (FlavorConfig.isQA()) {
      return IPAddress.QA;
    } else if (FlavorConfig.isUAT()) {
      return IPAddress.UAT;
    } else {
      return IPAddress.LIVE;
    }
  }

  static String getToken() {
    if (FlavorConfig.isDevelopment()) {
      return "yX8e4IujIwuWXGYvposamglY0p5H3pq95iq6zyId";
    } else if (FlavorConfig.isQA()) {
      return "yX8e4IujIwuWXGYvposamglY0p5H3pq95iq6zyId";
    } else if (FlavorConfig.isUAT()) {
      return "yX8e4IujIwuWXGYvposamglY0p5H3pq95iq6zyId";
    } else {
      return "yX8e4IujIwuWXGYvposamglY0p5H3pq95iq6zyId";
    }

    // return ServerProtocol.DEV;
  }
}

class APIResponse {
  static const String RESPONSE_LOGIN_SUCCESS = "dbp-367";
  static const String RESPONSE_BIOMETRIC_LOGIN_SUCCESS = "dbp-359";

  static const String RESPONSE_CHANGE_PASSWORD_SUCCESS = "dbp-350";

  static const String RESPONSE_M_LOGIN_SUCCESS_PASSWORD_RESET = "dbp-353";
  static const String RESPONSE_M_LOGIN_SUCCESS_PASSWORD_EXPIRED = "dbp-354";
  static const String RESPONSE_M_LOGIN_SUCCESS_NEW_DEVICE = "dbp-352";
  static const String RESPONSE_M_LOGIN_SUCCESS_INACTIVE_DEVICE = "dbp-351";

  static const String RESPONSE_B_LOGIN_SUCCESS_PASSWORD_RESET = "dbp-362";
  static const String RESPONSE_B_LOGIN_SUCCESS_PASSWORD_EXPIRED = "dbp-363";
  static const String RESPONSE_B_LOGIN_SUCCESS_NEW_DEVICE = "dbp-361";
  static const String RESPONSE_B_LOGIN_SUCCESS_INACTIVE_DEVICE = "dbp-360";
  static const String RESPONSE_FORGOT_PWD_INVALID_USERNAME = "507";
  static const String RESPONSE_FORGOT_PWD_INVALID_NIC = "502";
  static const String RESPONSE_FORGOT_PWD_INVALID_SEQ_ANS = "826";

  static const String WRONG_CURRENT_PASSWORD_ERROR_MESSAGE = "813";
}
