import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:toko_app/theme.dart';

class AuthService {
  var auth = FirebaseAuth.instance;

  Future signIn(BuildContext context, String email, String password) async {
    try {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(milliseconds: 1000),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text(
                "Authenticating. Please wait .....",
                textAlign: TextAlign.center,
              ),
            ],
          ),
          backgroundColor: primaryColor,
        ),
      );
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Failed to Login!",
            textAlign: TextAlign.center,
          ),
          backgroundColor: redColor,
        ),
      );
      print(e);
    }
  }

  Future createUser(String email, String pass) async {
    await auth.createUserWithEmailAndPassword(email: email, password: pass);
  }

  Future updatePassword(BuildContext context, String pass) async {
    await auth.currentUser!.updatePassword(pass);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(milliseconds: 1000),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircularProgressIndicator(),
            SizedBox(width: 20),
            Text(
              "Mengubah Password. Mohon Tunggu .....",
              textAlign: TextAlign.center,
            ),
          ],
        ),
        backgroundColor: primaryColor,
      ),
    );
  }

  Future updatePasswordwithEmail(BuildContext context, String email) async {
    await auth.sendPasswordResetEmail(email: email);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(milliseconds: 1000),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircularProgressIndicator(),
            SizedBox(width: 20),
            Text(
              "Mengirimkan. Silahkan Cek Email terkait .....",
              textAlign: TextAlign.center,
            ),
          ],
        ),
        backgroundColor: primaryColor,
      ),
    );
  }

  Future signOut() async {
    await auth.signOut();
  }

  Future deleteAkun() async {
    await auth.currentUser!.delete();
  }
}
