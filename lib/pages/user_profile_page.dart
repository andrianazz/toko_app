import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:toko_app/pages/change_password_page.dart';
import 'package:toko_app/services/auth_service.dart';
import 'package:uuid/uuid.dart';

import '../theme.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  bool isSecure = true;

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController kelController = TextEditingController();
  TextEditingController kecController = TextEditingController();
  TextEditingController kotaController = TextEditingController();
  TextEditingController provController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getAll();
  }

  String oldImage =
      'https://firebasestorage.googleapis.com/v0/b/phr-marketplace.appspot.com/o/no-image.png?alt=media&token=370795d8-34c8-454d-8e7b-6a297e404bb3';
  String? newImage;

  Future<void> getAll() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? name = pref.getString('name');
    String? alamat = pref.getString('alamat');
    String? kecamatan = pref.getString('kecamatan');
    String? kelurahan = pref.getString('kelurahan');
    String? kota = pref.getString('kota');
    String? provinsi = pref.getString('provinsi');
    String? email = pref.getString('email');
    String? phone = pref.getString('phone');
    String? image = pref.getString("imageUrl");

    setState(() {
      nameController.text = name!;
      phoneController.text = phone!;
      alamatController.text = alamat!;
      kelController.text = kelurahan!;
      kecController.text = kecamatan!;
      kotaController.text = kota!;
      provController.text = provinsi!;
      emailController.text = email!;
      newImage = image!;
    });
  }

  void imageUpload(String name) async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    var postUri = Uri.parse("https://galerilamriau.com/api/image");
    var headers = {
      "Authorization":
          "Bearer 2wNAfr1QBPn2Qckv55u5b4GN2jrgfnC8Y7cZO04yNpXciQHrj9NaWQhs1FSMo0Jd",
      "Content-Type": "multipart/form-data",
      "Accept": "application/json",
    };

    http.MultipartRequest request = new http.MultipartRequest("POST", postUri);
    request.headers.addAll(headers);
    http.MultipartFile multipartFile =
        await http.MultipartFile.fromPath('image', image!.path);
    request.files.add(multipartFile);
    http.StreamedResponse response = await request.send();

    print(response.statusCode);
    var responseData = await response.stream.toBytes();
    var result = String.fromCharCodes(responseData);
    var res = result.substring(12, result.length - 2).replaceAll(r"\", "");

    setState(() {
      newImage = res;
      print(newImage);
    });
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference costumers = firestore.collection('customer');
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: primaryColor,
      ),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 150,
                    height: 150,
                    margin: EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      border: Border.all(color: greyColor, width: 4),
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(newImage ?? oldImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      imageUpload(emailController.text.toString());

                      setState(() {});
                    },
                    child: Text("Change Image"),
                  ),
                ),
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
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 10),
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
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 10),
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
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 10),
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
                            "Kota / Kabupaten",
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
                const SizedBox(height: 10),
                Container(
                  height: 54,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ChangePasswordPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: secondaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: primaryColor, width: 2),
                      ),
                    ),
                    child: Text(
                      "Ubah Password",
                      style: primaryText.copyWith(
                        fontWeight: FontWeight.w700,
                        color: primaryColor,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  height: 54,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();

                      costumers.doc(emailController.text.toString()).update({
                        'name': nameController.text.toString(),
                        'phone': phoneController.text.toString(),
                        'asal': {
                          'alamat': alamatController.text.toString(),
                          'kecamatan': kecController.text.toString(),
                          'kelurahan': kelController.text.toString(),
                          'kota': kotaController.text.toString(),
                          'provinsi': provController.text.toString(),
                        },
                        'imageUrl': newImage ?? oldImage,
                      });

                      preferences.setString(
                          'name', nameController.text.toString());
                      preferences.setString(
                          'alamat', alamatController.text.toString());
                      preferences.setString(
                          'kecamatan', kecController.text.toString());
                      preferences.setString(
                          'kelurahan', kelController.text.toString());
                      preferences.setString(
                          'kota', kotaController.text.toString());
                      preferences.setString(
                          'provinsi', provController.text.toString());
                      preferences.setString(
                          'phone', phoneController.text.toString());
                      preferences.setString('imageUrl', newImage ?? oldImage);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: Duration(milliseconds: 1000),
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              CircularProgressIndicator(),
                              SizedBox(width: 20),
                              Text(
                                "Merubah Data. Silahkan Tunggu .....",
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          backgroundColor: primaryColor,
                        ),
                      );

                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      "Ubah Data Profil",
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
          )
        ],
      ),
    );
  }
}
