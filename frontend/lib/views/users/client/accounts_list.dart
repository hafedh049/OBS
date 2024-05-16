import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/account_model.dart';
import 'package:frontend/utils/helpers/errored.dart';
import 'package:frontend/utils/helpers/loading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:lottie/lottie.dart';

import '../../../utils/shared.dart';

class AccountsList extends StatefulWidget {
  const AccountsList({super.key});

  @override
  State<AccountsList> createState() => _AccountsListState();
}

class _AccountsListState extends State<AccountsList> {
  final List<AccountModel> _accountsList = <AccountModel>[];

  Future<bool> _loadAccounts() async {
    _accountsList.clear();
    for (final dynamic account in (await Dio().post("$ip/getAllAccounts")).data["data"]) {
      if (account["accountholderid"] == user!.userID) {
        _accountsList.add(AccountModel.fromJson(account));
      }
    }
    return true;
  }

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
              child: FutureBuilder<bool>(
                future: _loadAccounts(),
                builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                  return snapshot.hasError
                      ? Center(child: Errored(error: snapshot.error.toString()))
                      : snapshot.connectionState == ConnectionState.waiting
                          ? const Center(child: Loading())
                          : _accountsList.isEmpty
                              ? Center(child: LottieBuilder.asset("assets/lotties/empty.json", reverse: true))
                              : ListView.separated(
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
                                              child: Text("ACCOUNT ID", style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: whiteColor)),
                                            ),
                                            const SizedBox(width: 10),
                                            Text(_accountsList[index].accountNumber, style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: whiteColor)),
                                          ],
                                        ),
                                        const SizedBox(height: 20),
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              padding: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(color: purpleColor, borderRadius: BorderRadius.circular(5)),
                                              child: Text("OWNER NAME", style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: whiteColor)),
                                            ),
                                            const SizedBox(width: 10),
                                            Text(_accountsList[index].accountHolderName, style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: whiteColor)),
                                          ],
                                        ),
                                        const SizedBox(height: 20),
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              padding: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(color: purpleColor, borderRadius: BorderRadius.circular(5)),
                                              child: Text("BALANCE", style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: whiteColor)),
                                            ),
                                            const SizedBox(width: 10),
                                            Text("${_accountsList[index].balance} DT", style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: whiteColor)),
                                          ],
                                        ),
                                        const SizedBox(height: 20),
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              padding: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(color: purpleColor, borderRadius: BorderRadius.circular(5)),
                                              child: Text("ACCOUNT TYPE", style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: whiteColor)),
                                            ),
                                            const SizedBox(width: 10),
                                            Container(
                                              padding: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(color: _accountsList[index].accountType == "CURRENT" ? greenColor : redColor, borderRadius: BorderRadius.circular(5)),
                                              child: Text(_accountsList[index].accountType, style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: whiteColor)),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 20),
                                  itemCount: _accountsList.length,
                                );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
