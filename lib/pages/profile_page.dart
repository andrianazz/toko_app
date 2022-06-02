import 'package:flutter/material.dart';
import 'package:toko_app/pages/user_profile_page.dart';
import 'package:toko_app/services/auth_service.dart';
import 'package:toko_app/widgets/setting_widget.dart';

import '../theme.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: 30),
        header(),
        const SizedBox(height: 40),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              SettingWidget(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserProfilePage()));
                  },
                  name: 'Akun',
                  icon: 'assets/profile_icon.png'),
              SettingWidget(
                  onTap: () {
                    Navigator.pushNamed(context, '/promo');
                  },
                  name: 'Promo',
                  icon: 'assets/promo_icon.png'),
              SettingWidget(name: 'Bantuan', icon: 'assets/help_icon.png'),
              SettingWidget(name: 'Tentang', icon: 'assets/about_icon.png'),
            ],
          ),
        ),
        button(context),
        const SizedBox(height: 30),
      ],
    );
  }

  Widget header() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 12,
                  color: primaryColor,
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Text(
            "Pengaturan",
            style: primaryText.copyWith(fontSize: 24),
          ),
        ],
      ),
    );
  }

  Widget button(context) {
    return Container(
      height: 67,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: secondaryRedColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(19),
            )),
        onPressed: () {
          AuthService().signOut();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.exit_to_app,
              color: redColor,
            ),
            const SizedBox(width: 20),
            Text(
              "Logout",
              style: primaryText.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: redColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
