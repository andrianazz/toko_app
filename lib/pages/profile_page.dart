import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toko_app/pages/contact_page.dart';
import 'package:toko_app/pages/privacy_page.dart';
import 'package:toko_app/pages/user_profile_page.dart';
import 'package:toko_app/services/auth_service.dart';
import 'package:toko_app/widgets/setting_widget.dart';

import '../theme.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    getPref();
  }

  String imageUrl = '';
  String name = '';

  Future<void> getPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? imageString = pref.getString("imageUrl");
    String? nameString = pref.getString("name");

    setState(() {
      imageUrl = imageString!;
      name = nameString!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: 30),
        Column(
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: greyColor,
                  width: 5,
                ),
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              name,
              style: primaryText.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
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
                    Navigator.pushNamed(context, '/artikel');
                  },
                  name: 'Artikel',
                  icon: 'assets/promo_icon.png'),
              SettingWidget(
                name: 'Bantuan',
                icon: 'assets/help_icon.png',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ContactPage(),
                    ),
                  );
                },
              ),
              SettingWidget(
                name: 'Tentang',
                icon: 'assets/about_icon.png',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PrivacyPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        button(context),
        const SizedBox(height: 30),
      ],
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
