import 'package:flutter/material.dart';
import 'package:frontend/models/account_model.dart';
import 'package:frontend/views/users/agent/list_transactions.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../../utils/helpers/errored.dart';
import '../../../utils/helpers/loading.dart';
import '../../../utils/shared.dart';

class AccountsList extends StatefulWidget {
  const AccountsList({super.key});

  @override
  State<AccountsList> createState() => _AccountsListState();
}

class _AccountsListState extends State<AccountsList> {
  final GlobalKey<State> _accountsKey = GlobalKey<State>();

  List<AccountModel> _accounts = <AccountModel>[];

  Future<List<AccountModel>> _loadBanks() async {
    try {
      return <AccountModel>[];
    } catch (e) {
      return Future.error(e);
    }
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
            Text("Accounts List", style: GoogleFonts.itim(fontSize: 22, fontWeight: FontWeight.w500, color: greyColor)),
            Container(width: MediaQuery.sizeOf(context).width, height: .3, color: greyColor, margin: const EdgeInsets.symmetric(vertical: 20)),
            Expanded(
              child: Center(
                child: FutureBuilder<List<AccountModel>>(
                  future: _loadBanks(),
                  builder: (BuildContext context, AsyncSnapshot<List<AccountModel>> snapshot) {
                    if (snapshot.hasData) {
                      _accounts = snapshot.data!;
                      return StatefulBuilder(
                        key: _accountsKey,
                        builder: (BuildContext context, void Function(void Function()) setS) => _accounts.isEmpty
                            ? Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  LottieBuilder.asset("assets/lotties/empty.json", reverse: true),
                                  Text("No Accounts yet.", style: GoogleFonts.itim(fontSize: 18, fontWeight: FontWeight.w500, color: greyColor)),
                                ],
                              )
                            : ListView.separated(
                                itemBuilder: (BuildContext context, int index) => InkWell(
                                  splashColor: transparentColor,
                                  hoverColor: transparentColor,
                                  highlightColor: transparentColor,
                                  onLongPress: () => Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => TransactionsList(senderID: _accounts[index].accountHolderID))),
                                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => TransactionsList(senderID: _accounts[index].accountHolderID))),
                                  child: Container(
                                    width: 300,
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: darkColor),
                                    child: Stack(
                                      alignment: Alignment.topRight,
                                      children: <Widget>[
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Text("Bank ID", style: GoogleFonts.itim(fontSize: 18, fontWeight: FontWeight.w500, color: greyColor)),
                                                const SizedBox(width: 10),
                                                Text(_accounts[index].accountBankID, style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: blueColor)),
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              children: <Widget>[
                                                Text("Holder ID", style: GoogleFonts.itim(fontSize: 18, fontWeight: FontWeight.w500, color: greyColor)),
                                                const SizedBox(width: 10),
                                                Text(_accounts[index].accountHolderID, style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: blueColor)),
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              children: <Widget>[
                                                Text("Holder name", style: GoogleFonts.itim(fontSize: 18, fontWeight: FontWeight.w500, color: greyColor)),
                                                const SizedBox(width: 10),
                                                Text(_accounts[index].accountHolderName, style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: greenColor)),
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              children: <Widget>[
                                                Text("Account ID", style: GoogleFonts.itim(fontSize: 18, fontWeight: FontWeight.w500, color: greyColor)),
                                                const SizedBox(width: 10),
                                                Text(_accounts[index].accountNumber, style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: greenColor)),
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              children: <Widget>[
                                                Text("Account type", style: GoogleFonts.itim(fontSize: 18, fontWeight: FontWeight.w500, color: greyColor)),
                                                const SizedBox(width: 10),
                                                Text(_accounts[index].accountType, style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: greenColor)),
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              children: <Widget>[
                                                Text("Account balance", style: GoogleFonts.itim(fontSize: 18, fontWeight: FontWeight.w500, color: greyColor)),
                                                const SizedBox(width: 10),
                                                Text(_accounts[index].balance.toStringAsFixed(2), style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: greenColor)),
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              children: <Widget>[
                                                Text("Account state", style: GoogleFonts.itim(fontSize: 18, fontWeight: FontWeight.w500, color: greyColor)),
                                                const SizedBox(width: 10),
                                                Text(_accounts[index].isActive ? "ACTIVE" : "DISABLED", style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: greenColor)),
                                              ],
                                            ),
                                            if (_accounts[index].accountType == "CURRENT") ...<Widget>[
                                              const SizedBox(height: 10),
                                              Row(
                                                children: <Widget>[
                                                  Text("Overdraft limit", style: GoogleFonts.itim(fontSize: 18, fontWeight: FontWeight.w500, color: greyColor)),
                                                  const SizedBox(width: 10),
                                                  Text(_accounts[index].overdraftLimit.toStringAsFixed(2), style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: greenColor)),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              Row(
                                                children: <Widget>[
                                                  Text("Maximum transaction limit", style: GoogleFonts.itim(fontSize: 18, fontWeight: FontWeight.w500, color: greyColor)),
                                                  const SizedBox(width: 10),
                                                  Text(_accounts[index].maxTransLimit.toString(), style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: greenColor)),
                                                ],
                                              ),
                                            ],
                                            if (_accounts[index].accountType == "SAVINGS") ...<Widget>[
                                              const SizedBox(height: 10),
                                              Row(
                                                children: <Widget>[
                                                  Text("Interest rate", style: GoogleFonts.itim(fontSize: 18, fontWeight: FontWeight.w500, color: greyColor)),
                                                  const SizedBox(width: 10),
                                                  Text(_accounts[index].interestRate.toStringAsFixed(2), style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: greenColor)),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              Row(
                                                children: <Widget>[
                                                  Text("Minimum balance", style: GoogleFonts.itim(fontSize: 18, fontWeight: FontWeight.w500, color: greyColor)),
                                                  const SizedBox(width: 10),
                                                  Text(_accounts[index].minimumBalance.toStringAsFixed(2), style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: greenColor)),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              Row(
                                                children: <Widget>[
                                                  Text("Withdrawal limit", style: GoogleFonts.itim(fontSize: 18, fontWeight: FontWeight.w500, color: greyColor)),
                                                  const SizedBox(width: 10),
                                                  Text(_accounts[index].withdrawLimit.toString(), style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: greenColor)),
                                                ],
                                              ),
                                            ],
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 20),
                                itemCount: _accounts.length,
                              ),
                      );
                    } else if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Loading();
                    }
                    return Errored(error: snapshot.error.toString());
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
