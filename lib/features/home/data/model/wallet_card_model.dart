import 'package:amar_wallet_assignment/features/home/domain/entity/wallet_card_entity.dart';

class WalletCardModel {
  final String? barcodeNumber;
  final String? storeType;
  final String? storeName;
  final String? cardType;
  final String? imageUrl;

  WalletCardModel({
    this.barcodeNumber,
    this.storeType,
    this.storeName,
    this.cardType,
    this.imageUrl,
  });

  factory WalletCardModel.fromJson(Map<String, dynamic> json) {
    return WalletCardModel(
      barcodeNumber: json['barcodeNumber'] as String?,
      storeType: json['storeType'] as String?,
      storeName: json['storeName'] as String?,
      cardType: json['cardType'] as String?,
      imageUrl: json['imageUrl'] as String?,
    );
  }
}

extension WalletCardModelToEntity on WalletCardModel {
  WalletCardDetailsEntity toEntity() {
    return WalletCardDetailsEntity(
      barcodeNumber: barcodeNumber ?? '',
      storeType: storeType ?? '',
      storeName: storeName ?? '',
      cardType: cardType ?? '',
      imageUrl: imageUrl ?? '',
    );
  }
}
