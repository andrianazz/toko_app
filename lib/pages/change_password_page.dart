import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../theme.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  TextEditingController passNew = TextEditingController();
  TextEditingController pass2New = TextEditingController();

  bool _isSecure2 = true;
  bool _isSecure3 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ganti Password'),
        backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          offset: Offset(0, 5),
                          blurRadius: 10,
                        ),
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Perhatian : ",
                        style: primaryText.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Password baru anda harus mengikuti kriteria sebagai berikut:",
                        style: primaryText.copyWith(
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "1. Minimal 8 karakter",
                        style: primaryText.copyWith(
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "2. Harus mengandung huruf kapital dan huruf kecil",
                        style: primaryText.copyWith(
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "3. Harus mengandung angka",
                        style: primaryText.copyWith(
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "4. Berbeda dengan password lama",
                        style: primaryText.copyWith(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        offset: Offset(0, 5),
                        blurRadius: 10,
                      ),
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Text(
                      "Password Baru",
                      style: primaryText.copyWith(fontSize: 16),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: passNew,
                      obscureText: _isSecure2,
                      style: primaryText.copyWith(fontSize: 16),
                      decoration: InputDecoration(
                        filled: true,
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isSecure2 = !_isSecure2;
                              });
                            },
                            icon: Icon(_isSecure2
                                ? Icons.visibility
                                : Icons.visibility_off)),
                        hintText: "Masukkan Password Baru",
                        hintStyle: primaryText.copyWith(
                          fontSize: 16,
                          color: greyColor,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 1, color: greyColor),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text("Konfirmasi Password Baru",
                        style: primaryText.copyWith(fontSize: 16)),
                    SizedBox(height: 10),
                    TextField(
                      controller: pass2New,
                      obscureText: _isSecure3,
                      style: primaryText.copyWith(fontSize: 16),
                      decoration: InputDecoration(
                        filled: true,
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isSecure3 = !_isSecure3;
                              });
                            },
                            icon: Icon(_isSecure3
                                ? Icons.visibility
                                : Icons.visibility_off)),
                        hintText: "Konfirmasi Password Baru",
                        hintStyle: primaryText.copyWith(
                          fontSize: 16,
                          color: greyColor,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 1, color: greyColor),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          if (passNew.text.toString() ==
                              pass2New.text.toString()) {
                            AuthService().updatePassword(
                                context, passNew.text.toString());

                            passNew.clear();
                            pass2New.clear();

                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: Text(
                                  "Ubah Password",
                                  style: primaryText.copyWith(
                                    fontSize: 18,
                                  ),
                                ),
                                content: Text(
                                  'Password telah diubah',
                                  style: primaryText.copyWith(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            );

                            Navigator.pop(context);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "Gagal Password Tidak Sama!",
                                  textAlign: TextAlign.center,
                                ),
                                backgroundColor: redColor,
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            primary: primaryColor,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5)),
                        icon: Icon(Icons.save),
                        label: Text(
                          "UBAH PASSWORD",
                          style: primaryText.copyWith(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
