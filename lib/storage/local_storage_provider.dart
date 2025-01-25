import 'package:amar_wallet_assignment/features/home/data/model/wallet_card_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LocalStorageProvider {
  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(WalletCardModelAdapter());

    await Hive.openBox<WalletCardModel>('walletCards');
  }
}
