import 'package:amar_wallet_assignment/features/home/data/repository/home_repo_impl.dart';
import 'package:amar_wallet_assignment/features/home/data/source/home_datasource_impl.dart';
import 'package:amar_wallet_assignment/features/home/data/source/local/local_home_datasource_impl.dart';
import 'package:amar_wallet_assignment/features/home/presentation/view/barcode_scanner_view/cubit/barcode_cubit.dart';
import 'package:amar_wallet_assignment/features/home/presentation/view/home_view/home_view.dart';
import 'package:amar_wallet_assignment/global/extensions/context_extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WalletFoundScreen extends StatelessWidget {
  final String barcodeNumber;

  const WalletFoundScreen({
    super.key,
    required this.barcodeNumber,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BarcodeCubit(
          homeRepository: HomeRepoImpl(
        homeDataSource: HomeDataSourceImpl(),
        localHomeDataSource: LocalHomeDataSourceImpl(),
      ))
        ..findWalletData(barcodeNumber: barcodeNumber),
      child: WalletFoundView(),
    );
  }
}

class WalletFoundView extends StatelessWidget {
  const WalletFoundView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        actions: [],
      ),
      body: SafeArea(
        child: Center(
          child: BlocConsumer<BarcodeCubit, BarcodeState>(
            listener: (context, state) {
              if (state is WalletAdded) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              }
            },
            builder: (context, state) {
              if (state is WalletFound) {
                return Column(
                  children: [
                    HeaderContent(
                      cardType: state.wallet.cardType,
                      imageUrl: state.wallet.imageUrl,
                      storeName: state.wallet.storeName,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Member ID: ${state.wallet.barcodeNumber}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(child: SizedBox.shrink()),
                    FilledButton.tonal(
                      child: Text(
                        "Add to Amar Wallet",
                        style: TextStyle(
                          color: context.colorScheme.onSurface,
                        ),
                      ),
                      onPressed: () {
                        context.read<BarcodeCubit>().addWalletData(
                              wallet: state.wallet,
                            );
                      },
                    ),
                    const SizedBox(height: 60),
                  ],
                );
              }

              if (state is BarcodeError) {
                return Text(
                  state.message,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }

              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}

class HeaderContent extends StatelessWidget {
  final String cardType;
  final String imageUrl;
  final String storeName;

  const HeaderContent({
    super.key,
    required this.cardType,
    required this.imageUrl,
    required this.storeName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 45,
          backgroundImage: CachedNetworkImageProvider(imageUrl, scale: 0.25),
        ),
        const SizedBox(height: 8),
        Text(
          "${storeName}",
          style: context.textTheme.headlineSmall?.copyWith(
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          "${cardType}",
          style: context.textTheme.titleLarge?.copyWith(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
