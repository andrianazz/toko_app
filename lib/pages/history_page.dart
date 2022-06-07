import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toko_app/models/history_model.dart';
import 'package:toko_app/models/transaction_model.dart';
import 'package:toko_app/pages/detail_history_page.dart';
import 'package:toko_app/widgets/history_widget.dart';

import '../providers/userApp_provider.dart';
import '../theme.dart';

class HistoryPage extends StatefulWidget {
  HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    getId();
  }

  String idCostumer = '';

  Future<void> getId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String id = pref.getString("id") ?? '';

    setState(() {
      idCostumer = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: 30),
        header(),
        const SizedBox(height: 50),
        content(context),
      ],
    );
  }

  Widget header() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Text(
            "Riwayat",
            style: primaryText.copyWith(fontSize: 24),
          ),
        ],
      ),
    );
  }

  Widget content(context) {
    CollectionReference transactions = firestore.collection('transactions');
    UserAppProvider userProvider = Provider.of<UserAppProvider>(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: StreamBuilder<QuerySnapshot>(
          stream: transactions
              .where('id_costumer', isEqualTo: idCostumer)
              .orderBy("id", descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: snapshot.data!.docs.map((e) {
                  TransactionModel trans = TransactionModel.fromJson(
                      e.data() as Map<String, dynamic>);
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: HistoryWidget(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailHistoryPage(
                                      transaction: trans,
                                    )));
                      },
                      transaction: trans,
                    ),
                  );
                }).toList(),
              );
            } else {
              return Column(
                children: [Text("No Data")],
              );
            }
          }),
    );
  }
}
