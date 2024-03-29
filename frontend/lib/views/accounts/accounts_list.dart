import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:uuid/v8.dart';

import '../../utils/shared.dart';

class AccountsList extends StatefulWidget {
  const AccountsList({super.key});

  @override
  State<AccountsList> createState() => _AccountsListState();
}

class _AccountsListState extends State<AccountsList> {
  final List<Map<String, dynamic>> _accountsList = List<Map<String, dynamic>>.generate(
    100,
    (int index) => <String, dynamic>{
      "account_id": const UuidV8().generate(),
      "account_name": "Account ${index + 1}",
      "account_balance": (Random().nextInt(4000) * Random().nextDouble()).toStringAsFixed(2),
      "account_type": const <String>["CURRENT", "SAVINGS"][Random().nextInt(2)],
    },
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(FontAwesome.chevron_left_solid, size: 15, color: whiteColor)),
                Text("Accounts list", style: GoogleFonts.itim(fontSize: 25, fontWeight: FontWeight.w500, color: whiteColor)),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              width: MediaQuery.sizeOf(context).width - 2 * 24,
              height: .5,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: greyColor),
            ),
            Expanded(
              child: ListView.separated(
                itemBuilder: (BuildContext context, int index) => Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: darkColor),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(color: purpleColor, borderRadius: BorderRadius.circular(5)),
                            child: Text("ID", style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: whiteColor)),
                          ),
                          const SizedBox(width: 10),
                          Text(_accountsList[index]["account_id"], style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: whiteColor)),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(color: purpleColor, borderRadius: BorderRadius.circular(5)),
                            child: Text("Account Name", style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: whiteColor)),
                          ),
                          const SizedBox(width: 10),
                          Text(_accountsList[index]["account_name"], style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: whiteColor)),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(color: purpleColor, borderRadius: BorderRadius.circular(5)),
                            child: Text("Account Balance", style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: whiteColor)),
                          ),
                          const SizedBox(width: 10),
                          Text("${_accountsList[index]["account_balance"]} DT", style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: whiteColor)),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(color: purpleColor, borderRadius: BorderRadius.circular(5)),
                            child: Text("Account Type", style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: whiteColor)),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(color: _accountsList[index]["account_type"] == "CURRENT" ? greenColor : redColor, borderRadius: BorderRadius.circular(5)),
                            child: Text(_accountsList[index]["account_type"], style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: whiteColor)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 20),
                itemCount: _accountsList.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
