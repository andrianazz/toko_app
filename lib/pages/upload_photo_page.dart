import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toko_app/pages/login_page.dart';

import '../services/auth_service.dart';
import '../theme.dart';

class UploadPhotoPage extends StatefulWidget {
  final String email;
  final String password;

  const UploadPhotoPage({Key? key, required this.email, required this.password})
      : super(key: key);

  @override
  State<UploadPhotoPage> createState() => _UploadPhotoPageState();
}

class _UploadPhotoPageState extends State<UploadPhotoPage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  String oldImage =
      "https://firebasestorage.googleapis.com/v0/b/phr-marketplace.appspot.com/o/no-image.png?alt=media&token=370795d8-34c8-454d-8e7b-6a297e404bb3";
  String? newImage;

  void imageUpload(String name) async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    Reference ref = FirebaseStorage.instance.ref().child(name);

    await ref.putFile(File(image!.path));
    ref.getDownloadURL().then((value) {
      setState(() {
        newImage = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference customers = firestore.collection('customer');

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 30),
            header(),
            const SizedBox(height: 30),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                "Data diri akan terlihat di akun pribadi anda dengan kemanan terbaik kami.",
                style: primaryText.copyWith(
                  fontSize: 13,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Container(
              width: 256,
              height: 256,
              child: Stack(
                children: [
                  ClipRRect(
                    child: Image.network(
                      newImage ?? oldImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 50,
                    right: 20,
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: primaryColor,
                      ),
                      child: IconButton(
                        onPressed: () {
                          imageUpload(widget.email + "-cust");
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        margin: const EdgeInsets.only(bottom: 20, left: 24, right: 24),
        height: 54,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () async {
            customers.doc(widget.email).update({
              'imageUrl': newImage ?? oldImage,
            });

            await AuthService().createUser(widget.email, widget.password);

            Navigator.push(
                context, MaterialPageRoute(builder: (context) => LoginPage()));
          },
          style: ElevatedButton.styleFrom(
            primary: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(
            "Lanjutkan",
            style: primaryText.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
        ),
      ),
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
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 14,
                color: primaryColor,
              ),
            ),
          ),
          const SizedBox(width: 20),
          Text(
            "Upload Photo",
            style: primaryText.copyWith(fontSize: 24),
          ),
        ],
      ),
    );
  }
}
