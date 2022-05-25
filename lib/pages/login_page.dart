import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:toko_app/pages/main_page.dart';
import 'package:toko_app/services/auth_service.dart';
import 'package:toko_app/theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  bool _isSecure = true;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Something went Wrong"));
          } else if (snapshot.hasData) {
            return MainPage();
          } else {
            return Scaffold(
              body: Stack(
                children: [
                  background(),
                  content(),
                ],
              ),
            );
          }
        });
  }

  Widget background() {
    return SizedBox.expand(
      child: Image.asset(
        "assets/bg_splash2.png",
        fit: BoxFit.cover,
      ),
    );
  }

  Widget content() {
    return SafeArea(
      child: ListView(
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_rounded,
                    color: Colors.white,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 50),
                      child: Text(
                        "Masuk",
                        style: primaryText.copyWith(
                          fontSize: 34,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      width: 160,
                      height: 250,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/login_illustration.png'),
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  "Email",
                  style: primaryText.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    focusColor: const Color(0xfff2f2f2),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    hintText: "Masukkan Email...",
                    fillColor: const Color(0xfff2f2f2),
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  "Passsword",
                  style: primaryText.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                TextField(
                  controller: passwordController,
                  obscureText: _isSecure,
                  decoration: InputDecoration(
                    filled: true,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _isSecure = !_isSecure;
                        });
                      },
                      icon: Icon(
                        _isSecure ? Icons.visibility : Icons.visibility_off,
                        color: greyColor,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    focusColor: const Color(0xfff2f2f2),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    hintText: "Masukkan Password...",
                    fillColor: const Color(0xfff2f2f2),
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: Text(
                    'Lupa Password?',
                    style: primaryText.copyWith(
                      fontSize: 10,
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  height: 54,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      isCostumer(emailController.text.toString());
                    },
                    style: ElevatedButton.styleFrom(
                      primary: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      "Masuk",
                      style: primaryText.copyWith(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 54,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      primary: blueColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/google_icon.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Text(
                          "Masuk ke Google",
                          style: primaryText.copyWith(
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                      child: Text(
                        "Tidak ada akun? DAFTAR",
                        style: primaryText.copyWith(
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  isCostumer(String email) {
    CollectionReference customers = firestore.collection('customer');
    customers.doc(email).get().then((snapshot) {
      if (snapshot.exists) {
        return AuthService().signIn(
          context,
          emailController.text.trim(),
          passwordController.text.trim(),
        );
      } else {
        return ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Failed to Login!",
              textAlign: TextAlign.center,
            ),
            backgroundColor: redColor,
          ),
        );
      }
    });
  }
}
