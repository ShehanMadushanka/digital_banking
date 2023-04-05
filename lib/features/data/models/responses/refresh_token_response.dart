// To parse this JSON data, do
//
//     final refreshTokenResponse = refreshTokenResponseFromJson(jsonString);

import 'dart:convert';

RefreshTokenResponse refreshTokenResponseFromJson(String str) => RefreshTokenResponse.fromJson(json.decode(str));

String refreshTokenResponseToJson(RefreshTokenResponse data) => json.encode(data.toJson());

class RefreshTokenResponse {
  RefreshTokenResponse({
    this.accessToken,
    this.tokenType,
    this.refreshToken,
    this.expiresIn,
    this.scope,
    this.jti,
  });

  final String accessToken;
  final String tokenType;
  final String refreshToken;
  final int expiresIn;
  final String scope;
  final String jti;

  factory RefreshTokenResponse.fromJson(Map<String, dynamic> json) => RefreshTokenResponse(
    accessToken: json["access_token"],
    tokenType: json["token_type"],
    refreshToken: json["refresh_token"],
    expiresIn: json["expires_in"],
    scope: json["scope"],
    jti: json["jti"],
  );

  Map<String, dynamic> toJson() => {
    "access_token": accessToken,
    "token_type": tokenType,
    "refresh_token": refreshToken,
    "expires_in": expiresIn,
    "scope": scope,
    "jti": jti,
  };
}
