import 'package:amar_wallet_assignment/features/home/domain/entity/wallet_card_entity.dart';
import 'package:flutter/material.dart';

class WalletCardWidget extends StatelessWidget {
  const WalletCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * 0.30,
      ),
      child: Card(
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(
              'https://i.ibb.co.com/pjBrvhw/burgerking.png',
            ),
          ),
          title: Text('Burger King'),
          subtitle: Text('Fast Food'),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}

class ListOfWalletCard extends StatelessWidget {
  final List<WalletCardDetailsEntity> walletCardDetails;

  const ListOfWalletCard({super.key, required this.walletCardDetails});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context, index) {
      return WalletCardWidget();
    });
  }
}
