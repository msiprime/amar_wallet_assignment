import 'package:amar_wallet_assignment/features/home/data/model/wallet_card_model.dart';
import 'package:amar_wallet_assignment/global/error/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class LocalHomeDataSource {
  Future<Either<Failure, List<WalletCardModel>>> getMyWallets();

  Future<Either<Failure, List<WalletCardModel>>> addMyWallets({
    required WalletCardModel wallet,
  });
}
