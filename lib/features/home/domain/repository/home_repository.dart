import 'package:amar_wallet_assignment/features/home/domain/entity/wallet_card_entity.dart';
import 'package:amar_wallet_assignment/global/error/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class HomeRepository {
  // remote

  Future<Either<Failure, List<WalletCardDetailsEntity>>> getCardData();

  // local repo

  Future<Either<Failure, List<WalletCardDetailsEntity>>> getMyWallets();

  Future<Either<Failure, List<WalletCardDetailsEntity>>> addMyWallet({
    required WalletCardDetailsEntity wallet,
  });

  Future<Either<Failure, WalletCardDetailsEntity>> findWalletData({
    required String barcodeNumber,
  });
}
