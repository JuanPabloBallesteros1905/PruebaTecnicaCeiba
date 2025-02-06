import 'package:flutter/material.dart';
import 'package:users/core/utils/colors.dart';

class CustomCardUser extends StatelessWidget {
  final String name;
  final String phone;
  final String email;
  final bool showSeePots;

  final Function onpress;

  const CustomCardUser(
      {super.key,
      required this.name,
      required this.phone,
      required this.email,
      required this.onpress, required this.showSeePots});

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
            
            
           showSeePots ?   Row(
              children: [
                Spacer(),
                TextButton(
                    onPressed: () {
                      onpress();
                    },
                    child: Text(
                      'Ver Publicaciones',
                      style: TextStyle(
                          color: AppColors.mainColor,
                          fontWeight: FontWeight.bold),
                    )),
              ],
            ) : Container()
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
