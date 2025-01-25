part of 'home_cubit.dart';

enum HomeStatus { initial, loading, loaded, error }

class HomeState extends Equatable {
  final HomeStatus status;
  final List<WalletCardDetailsEntity> walletCardDetails;

  HomeState._({
    required this.status,
    required this.walletCardDetails,
  });

  factory HomeState.initial() {
    return HomeState._(
      status: HomeStatus.initial,
      walletCardDetails: [],
    );
  }

  HomeState copyWith({
    HomeStatus? status,
    List<WalletCardDetailsEntity>? walletCardDetails,
  }) {
    return HomeState._(
      status: status ?? this.status,
      walletCardDetails: walletCardDetails ?? this.walletCardDetails,
    );
  }

  @override
  List<Object?> get props => [status, walletCardDetails];
}
