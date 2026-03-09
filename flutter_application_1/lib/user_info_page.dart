import 'package:flutter/material.dart';

class UserInfoPage extends StatelessWidget {

  final String name;
  final String email;
  final String phone;

  const UserInfoPage({
    super.key,
    required this.name,
    required this.email,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text("User Info")),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text("Name: $name", style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 10),

            Text("Email: $email", style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 10),

            Text("Phone: $phone", style: const TextStyle(fontSize: 20)),

          ],
        ),
      ),
    );
  }
}