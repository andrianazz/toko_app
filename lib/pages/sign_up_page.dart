import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:toko_app/pages/upload_photo_page.dart';
import 'package:uuid/uuid.dart';

import '../theme.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  int custLength = 0;

  @override
  void initState() {
    super.initState();
    getLength();
  }

  getLength() {
    firestore
        .collection('customer')
        .get()
        .then((snapshot) => custLength = snapshot.docs.length);
  }

  bool isSecure = true;
  bool isSecure2 = true;

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController kelController = TextEditingController();
  TextEditingController kecController = TextEditingController();
  TextEditingController kotaController = TextEditingController();
  TextEditingController provController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController pass1Controller = TextEditingController();
  TextEditingController pass2Controller = TextEditingController();
  String oldImage =
      'https://firebasestorage.googleapis.com/v0/b/phr-marketplace.appspot.com/o/no-image.png?alt=media&token=370795d8-34c8-454d-8e7b-6a297e404bb3';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(height: 30),
          header(),
          const SizedBox(height: 30),
          content(),
        ],
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
            "Daftar Akun",
            style: primaryText.copyWith(fontSize: 24),
          ),
        ],
      ),
    );
  }

  Widget content() {
    CollectionReference customers = firestore.collection('customer');

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Data diri akan terlihat di akun pribadi anda dengan kemanan terbaik kami.",
            style: primaryText.copyWith(
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 30),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Nama Lengkap",
                style: primaryText.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: cartColor,
                    ),
                  ),
                  fillColor: Colors.white,
                  hintText: 'Masukkan Nama....',
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "No Telp",
                style: primaryText.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: cartColor,
                    ),
                  ),
                  fillColor: Colors.white,
                  hintText: 'Masukkan Nomor Telepon...',
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Alamat",
                style: primaryText.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: alamatController,
                decoration: InputDecoration(
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: cartColor,
                    ),
                  ),
                  fillColor: Colors.white,
                  hintText: 'Masukkan Alamat...',
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Kelurahan",
                      style: primaryText.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: kelController,
                      decoration: InputDecoration(
                        filled: true,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: cartColor,
                          ),
                        ),
                        fillColor: Colors.white,
                        hintText: 'Kelurahan...',
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(width: 10),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Kecamatan",
                      style: primaryText.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: kecController,
                      decoration: InputDecoration(
                        filled: true,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: cartColor,
                          ),
                        ),
                        fillColor: Colors.white,
                        hintText: 'Kecamatan...',
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Kota",
                      style: primaryText.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: kotaController,
                      decoration: InputDecoration(
                        filled: true,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: cartColor,
                          ),
                        ),
                        fillColor: Colors.white,
                        hintText: 'Kota...',
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(width: 10),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Provinsi",
                      style: primaryText.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: provController,
                      decoration: InputDecoration(
                        filled: true,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: cartColor,
                          ),
                        ),
                        fillColor: Colors.white,
                        hintText: 'Provinsi...',
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Email",
                style: primaryText.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: cartColor,
                    ),
                  ),
                  fillColor: Colors.white,
                  hintText: 'Masukkan Email...',
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Password",
                style: primaryText.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: pass1Controller,
                obscureText: isSecure,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isSecure = !isSecure;
                      });
                    },
                    icon: Icon(
                      isSecure ? Icons.visibility : Icons.visibility_off,
                      color: greyColor,
                    ),
                  ),
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: cartColor,
                    ),
                  ),
                  fillColor: Colors.white,
                  hintText: 'Masukkan Password...',
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Konfirmasi Password",
                style: primaryText.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: pass2Controller,
                obscureText: isSecure2,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isSecure2 = !isSecure2;
                      });
                    },
                    icon: Icon(
                      isSecure2 ? Icons.visibility : Icons.visibility_off,
                      color: greyColor,
                    ),
                  ),
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: cartColor,
                    ),
                  ),
                  fillColor: Colors.white,
                  hintText: 'Masukkan Konfirmasi Password...',
                ),
              )
            ],
          ),
          const SizedBox(height: 30),
          Container(
            height: 54,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                customers.doc(emailController.text).get().then((snapshot) {
                  if (snapshot.exists) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Email sudah tersedia!",
                          textAlign: TextAlign.center,
                        ),
                        backgroundColor: redColor,
                      ),
                    );
                  } else {
                    if (pass1Controller.text == pass2Controller.text) {
                      String email = emailController.text;
                      String pass = pass1Controller.text;

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UploadPhotoPage(
                            email: email,
                            password: pass,
                          ),
                        ),
                      );

                      customers.doc(emailController.text).set({
                        'id': Uuid().v5(Uuid.NAMESPACE_URL,
                            emailController.text.toString()),
                        'name': nameController.text,
                        'phone': phoneController.text,
                        'asal': {
                          'alamat': alamatController.text,
                          'kelurahan': kelController.text,
                          'kecamatan': kecController.text,
                          'kota': kotaController.text,
                          'provinsi': provController.text,
                        },
                        'email': emailController.text,
                        'status': 'aktif',
                        'imageUrl': oldImage,
                      });

                      clear();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Password tidak sama",
                            textAlign: TextAlign.center,
                          ),
                          backgroundColor: redColor,
                        ),
                      );
                    }
                  }
                });
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
          const SizedBox(height: 50),
        ],
      ),
    );
  }

  void clear() {
    nameController.text = '';
    phoneController.text = '';
    alamatController.text = '';
    kelController.text = '';
    kecController.text = '';
    kotaController.text = '';
    provController.text = '';
    emailController.text = '';
    pass1Controller.text = '';
    pass2Controller.text = '';
  }
}
