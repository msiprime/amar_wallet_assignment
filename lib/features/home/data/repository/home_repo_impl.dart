import 'package:amar_wallet_assignment/features/home/data/model/wallet_card_model.dart';
import 'package:amar_wallet_assignment/features/home/data/source/home_datasource.dart';
import 'package:amar_wallet_assignment/features/home/data/source/local/local_home_datasource.dart';
import 'package:amar_wallet_assignment/features/home/domain/entity/wallet_card_entity.dart';
import 'package:amar_wallet_assignment/features/home/domain/repository/home_repository.dart';
import 'package:amar_wallet_assignment/global/error/failure.dart';
import 'package:fpdart/src/either.dart';

class HomeRepoImpl implements HomeRepository {
  final HomeDataSource _homeDataSource;
  final LocalHomeDataSource _localHomeDataSource;

  HomeRepoImpl({
    required HomeDataSource homeDataSource,
    required LocalHomeDataSource localHomeDataSource,
  })  : _homeDataSource = homeDataSource,
        _localHomeDataSource = localHomeDataSource;

  @override
  Future<Either<Failure, List<WalletCardDetailsEntity>>> getCardData() async {
    try {
      final cardData = await _homeDataSource.getCardData();

      List<WalletCardModel> walletCardModel =
          cardData.map((e) => WalletCardModel.fromJson(e)).toList();

      return Right(walletCardModel.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(Failure(message: "Error fetching data", code: "404"));
    }
  }

  @override
  Future<Either<Failure, List<WalletCardDetailsEntity>>> addMyWallet({
    required WalletCardDetailsEntity wallet,
  }) async {
    try {
      final walletCardModel = wallet.toModel();

      final response =
          await _localHomeDataSource.addMyWallets(wallet: walletCardModel);

      return response.fold(
        (l) => Left(l),
        (r) => Right(r.map((e) => e.toEntity()).toList()),
      );
    } catch (e) {
      return Left(Failure(message: "Error adding wallet", code: "404"));
    }
  }

  @override
  Future<Either<Failure, List<WalletCardDetailsEntity>>> getMyWallets() async {
    final walletCards = await _localHomeDataSource.getMyWallets();

    return walletCards.fold(
        (l) => Left(l), (r) => Right(r.map((e) => e.toEntity()).toList()));
  }

  @override
  Future<Either<Failure, WalletCardDetailsEntity>> findWalletData({
    required String barcodeNumber,
  }) async {
    try {
      final response = await getCardData();

      return response.fold(
        (failure) => Left(failure),
        (wallets) {
          try {
            final wallet = wallets.firstWhere(
              (element) => element.barcodeNumber == barcodeNumber,
            );
            return Right(wallet);
          } catch (e) {
            return Left(Failure(
              message: "Wallet with barcode number $barcodeNumber not found",
              code: "404",
            ));
          }
        },
      );
    } catch (e) {
      return Left(Failure(message: "Error finding wallet data", code: "500"));
    }
  }
}
