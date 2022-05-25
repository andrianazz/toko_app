import 'package:flutter/material.dart';
import 'package:toko_app/models/history_model.dart';
import 'package:toko_app/pages/detail_history_page.dart';
import 'package:toko_app/widgets/history_widget.dart';

import '../theme.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

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
            "Riwayat",
            style: primaryText.copyWith(fontSize: 24),
          ),
        ],
      ),
    );
  }

  Widget content(context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: mockHistory
            .map((history) => Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: HistoryWidget(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const DetailHistoryPage()));
                    },
                    history: history,
                  ),
                ))
            .toList(),
      ),
    );
  }
}
