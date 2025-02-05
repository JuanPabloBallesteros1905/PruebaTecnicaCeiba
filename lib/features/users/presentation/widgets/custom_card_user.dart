

import 'package:flutter/material.dart';
import 'package:users/core/utils/colors.dart';

class CustomCardUser extends StatelessWidget {

  final String name;
  final String phone;
  final String email;
  


  const CustomCardUser({super.key, required this.name, required this.phone, required this.email});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(
                  color: AppColors.mainColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            CustomRow(
              icon: Icons.phone,
              text: phone,
            ),
            CustomRow(
              icon: Icons.mail,
              text: email,
            ),
            Row(
              children: [
                Spacer(),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'userDetails');
                    },
                    child: Text(
                      'Ver Publicaciones',
                      style: TextStyle(
                          color: AppColors.mainColor,
                          fontWeight: FontWeight.bold),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}


class CustomRow extends StatelessWidget {
  final IconData icon;
  final String text;
  const CustomRow({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 6,
      children: [Icon(color: AppColors.mainColor, icon), Text(text)],
    );
  }
}
