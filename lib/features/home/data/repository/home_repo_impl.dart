import 'package:amar_wallet_assignment/features/home/data/model/wallet_card_model.dart';
import 'package:amar_wallet_assignment/features/home/data/source/home_datasource.dart';
import 'package:amar_wallet_assignment/features/home/domain/entity/wallet_card_entity.dart';
import 'package:amar_wallet_assignment/features/home/domain/repository/home_repository.dart';
import 'package:amar_wallet_assignment/global/error/failure.dart';
import 'package:fpdart/src/either.dart';

class HomeRepoImpl implements HomeRepository {
  final HomeDataSource _homeDataSource;

  HomeRepoImpl({
    required HomeDataSource homeDataSource,
  }) : _homeDataSource = homeDataSource;

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
}
