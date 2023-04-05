import 'package:cdb_mobile/error/failures.dart';
import 'package:cdb_mobile/features/data/models/requests/wallet_onboarding_data.dart';
import 'package:cdb_mobile/features/domain/entities/request/wallet_onboarding_data_entity.dart';
import 'package:cdb_mobile/features/domain/repositories/repository.dart';
import 'package:cdb_mobile/features/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class GetWalletOnBoardingData extends UseCase<WalletOnBoardingData, WalletParams> {
  final Repository repository;

  GetWalletOnBoardingData({this.repository});

  @override
  Future<Either<Failure, WalletOnBoardingData>> call(WalletParams params) async {
    return repository.getWalletOnBoardingData();
  }
}

class WalletParams extends Equatable {
  final WalletOnBoardingDataEntity walletOnBoardingDataEntity;

  const WalletParams({@required this.walletOnBoardingDataEntity});

  @override
  List<Object> get props => [walletOnBoardingDataEntity];
}
