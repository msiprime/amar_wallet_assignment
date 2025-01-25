import 'package:amar_wallet_assignment/features/home/domain/entity/wallet_card_entity.dart';
import 'package:hive/hive.dart';

class WalletCardModel extends HiveObject {
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

class WalletCardModelAdapter extends TypeAdapter<WalletCardModel> {
  @override
  final int typeId = 0;

  @override
  WalletCardModel read(BinaryReader reader) {
    return WalletCardModel(
      barcodeNumber: reader.readString(),
      storeType: reader.readString(),
      storeName: reader.readString(),
      cardType: reader.readString(),
      imageUrl: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, WalletCardModel obj) {
    writer.writeString(obj.barcodeNumber ?? '');
    writer.writeString(obj.storeType ?? '');
    writer.writeString(obj.storeName ?? '');
    writer.writeString(obj.cardType ?? '');
    writer.writeString(obj.imageUrl ?? '');
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

extension WalletCardEntityToModel on WalletCardDetailsEntity {
  WalletCardModel toModel() {
    return WalletCardModel(
      barcodeNumber: barcodeNumber,
      storeType: storeType,
      cardType: cardType,
      imageUrl: imageUrl,
      storeName: storeName,
    );
  }
}
