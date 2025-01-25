import 'package:amar_wallet_assignment/features/home/data/model/wallet_card_model.dart';
import 'package:amar_wallet_assignment/features/home/data/source/local/local_home_datasource.dart';
import 'package:amar_wallet_assignment/global/error/failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hive/hive.dart';

class LocalHomeDataSourceImpl implements LocalHomeDataSource {
  LocalHomeDataSourceImpl();

  @override
  Future<Either<Failure, List<WalletCardModel>>> getMyWallets() async {
    final box = await Hive.openBox<WalletCardModel>('walletCards');

    try {
      final List<WalletCardModel> walletCards = box.values.toList();

      print("Wallet Cards: $walletCards");
      print("............................................");

      return Right(walletCards);
    } catch (e) {
      return Left(Failure(message: "Error fetching wallets", code: "404"));
    }
  }

  @override
  Future<Either<Failure, List<WalletCardModel>>> addMyWallets(
      {required WalletCardModel wallet}) async {
    try {
      var box = await Hive.openBox<WalletCardModel>('walletCards');

      await box.put(wallet.barcodeNumber, wallet);

      final List<WalletCardModel> walletCards = box.values.toList();

      return Right(walletCards);
    } catch (e) {
      return Left(Failure(message: "Error adding wallet", code: "404"));
    }
  }
}
