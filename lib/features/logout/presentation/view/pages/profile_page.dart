import 'package:flowers_app/features/logout/presentation/view/widgets/logout_button_widget.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: const Column(
        children: [
          SizedBox(height: 20),
          LogoutButtonWidget(),
        ],
      ),
    );
  }
}
