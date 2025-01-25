import 'package:amar_wallet_assignment/features/home/data/repository/home_repo_impl.dart';
import 'package:amar_wallet_assignment/features/home/data/source/home_datasource_impl.dart';
import 'package:amar_wallet_assignment/features/home/data/source/local/local_home_datasource_impl.dart';
import 'package:amar_wallet_assignment/features/home/presentation/view/barcode_scanner_view/barcode_scanner_view.dart';
import 'package:amar_wallet_assignment/features/home/presentation/view/home_view/cubit/home_cubit.dart';
import 'package:amar_wallet_assignment/features/home/presentation/widget/wallet_card_widget.dart';
import 'package:amar_wallet_assignment/global/extensions/context_extensions.dart';
import 'package:amar_wallet_assignment/global/widgets/app_bar.dart';
import 'package:amar_wallet_assignment/global/widgets/app_carousel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(
        homeRepository: HomeRepoImpl(
          homeDataSource: HomeDataSourceImpl(),
          localHomeDataSource: LocalHomeDataSourceImpl(),
        ),
      )..getMyWallets(),
      child: HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: HomeFloatingActionButton(),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      appBar: HomeAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              return Column(
                children: [
                  const Gap(8),
                  AppCarouselSlider(
                    imageUrls: imageURLs,
                    height: context.height * 0.33,
                  ),
                  const Gap(16),
                  if (state.status == HomeStatus.loading)
                    const CircularProgressIndicator()
                  else if (state.status == HomeStatus.error)
                    const Text('Error fetching data')
                  else if (state.status == HomeStatus.loaded)
                    ListView.separated(
                      separatorBuilder: (context, index) => const Gap(12),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.walletCardDetails.length,
                      itemBuilder: (context, index) {
                        final walletCard = state.walletCardDetails[index];
                        return WalletCardWidget(
                          imageUrl: walletCard.imageUrl,
                          storeName: walletCard.storeName,
                          cardType: walletCard.cardType,
                        );
                      },
                    ),
                  const Gap(16),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class HomeFloatingActionButton extends StatelessWidget {
  const HomeFloatingActionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      label: const Text('Add to wallet'),
      isExtended: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BarcodeScannerScreen(),
          ),
        );
      },
      icon: const Icon(Icons.add),
    );
  }
}

const List<String> imageURLs = [
  'https://i.ibb.co.com/mbcvj7G/bank4.png',
  'https://i.ibb.co.com/L5vM9mt/bank2.png',
  'https://i.ibb.co.com/RBNXbqk/bank3.png',
  'https://i.ibb.co.com/4SzG3fZ/bank1.png',
];
