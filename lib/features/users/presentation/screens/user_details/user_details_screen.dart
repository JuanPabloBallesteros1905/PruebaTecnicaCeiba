


import 'package:flutter/material.dart';
import 'package:users/core/utils/textos.dart';
import 'package:users/features/presentation/widgets/custom_card_user.dart';

class UserDetails extends StatelessWidget {
  const UserDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text(Textos.detailsAppBarTittle, style: TextStyle(color: Colors.white),),
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CustomCardUser(
              name: 'juan Pablo Ballesteros',
              phone: '3123123123',
              email: 'u0H4M@example.com',
            )
          ],
        ),
      ),
    );
  }
}