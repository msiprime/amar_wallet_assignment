import 'package:amar_wallet_assignment/features/home/domain/entity/wallet_card_entity.dart';
import 'package:amar_wallet_assignment/features/home/domain/repository/home_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository _homeRepository;

  HomeCubit({
    required HomeRepository homeRepository,
  })  : _homeRepository = homeRepository,
        super(HomeState.initial());

  void getCardData() async {
    emit(state.copyWith(status: HomeStatus.loading));
    await _homeRepository.getCardData().then((value) {
      value.fold(
        (l) => emit(state.copyWith(status: HomeStatus.error)),
        (r) => emit(state.copyWith(
          status: HomeStatus.loaded,
          walletCardDetails: r,
        )),
      );
    });
  }

  void getMyWallets() async {
    await _homeRepository.getMyWallets().then((value) {
      value.fold(
        (l) => emit(state.copyWith(status: HomeStatus.error)),
        (r) => emit(state.copyWith(
          status: HomeStatus.loaded,
          walletCardDetails: r,
        )),
      );
    });
  }
}
