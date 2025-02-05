import 'package:flutter/material.dart';

import 'package:users/core/utils/textos.dart';
import 'package:users/features/users/presentation/widgets/index.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Textos.mainAppBarTittle,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            spacing: 16,
            children: [
              //Input
              CustomTextField(),
              SizedBox(
                  width: double.infinity,
                  height: 600,
                  child: ListView.builder(
                    itemBuilder: (context, index) => CustomCardUser(
                      name: 'juan Pablo Ballesteros',
                      phone: '3123123123',
                      email: 'u0H4M@example.com',

                      
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
 
class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: Textos.labelText,
      ),
    );
  }
}
