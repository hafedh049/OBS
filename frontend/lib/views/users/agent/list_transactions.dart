import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:lottie/lottie.dart';

import '../../../models/transaction_model.dart';
import '../../../utils/helpers/errored.dart';
import '../../../utils/helpers/loading.dart';
import '../../../utils/shared.dart';

class TransactionsList extends StatefulWidget {
  const TransactionsList({super.key, required this.senderID});
  final String senderID;
  @override
  State<TransactionsList> createState() => _TransactionsListState();
}

class _TransactionsListState extends State<TransactionsList> {
  final GlobalKey<State> _transactionsKey = GlobalKey<State>();

  List<TransactionModel> _transactions = <TransactionModel>[];

  Future<List<TransactionModel>> _loadBanks() async {
    try {
      return <TransactionModel>[];
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
            Text("Transactions List", style: GoogleFonts.itim(fontSize: 22, fontWeight: FontWeight.w500, color: greyColor)),
            Container(width: MediaQuery.sizeOf(context).width, height: .3, color: greyColor, margin: const EdgeInsets.symmetric(vertical: 20)),
            Expanded(
              child: Center(
                child: FutureBuilder<List<TransactionModel>>(
                  future: _loadBanks(),
                  builder: (BuildContext context, AsyncSnapshot<List<TransactionModel>> snapshot) {
                    if (snapshot.hasData) {
                      _transactions = snapshot.data!;
                      return StatefulBuilder(
                        key: _transactionsKey,
                        builder: (BuildContext context, void Function(void Function()) setS) => _transactions.isEmpty
                            ? Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  LottieBuilder.asset("assets/lotties/empty.json", reverse: true),
                                  Text("No Transactions for this account.", style: GoogleFonts.itim(fontSize: 18, fontWeight: FontWeight.w500, color: greyColor)),
                                ],
                              )
                            : ListView.separated(
                                itemBuilder: (BuildContext context, int index) => InkWell(
                                  splashColor: transparentColor,
                                  hoverColor: transparentColor,
                                  highlightColor: transparentColor,
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) => AlertDialog(
                                        backgroundColor: scaffoldColor,
                                        content: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Text("Confirm transaction ?", style: GoogleFonts.itim(fontSize: 18, fontWeight: FontWeight.w500, color: greyColor)),
                                            const SizedBox(height: 20),
                                            Row(
                                              children: <Widget>[
                                                TextButton(
                                                  onPressed: () {},
                                                  style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(greenColor)),
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: <Widget>[
                                                      const Icon(FontAwesome.square_check_solid, color: darkColor, size: 20)
                                                          .animate(
                                                            onComplete: (AnimationController controller) => controller.repeat(reverse: true),
                                                          )
                                                          .shake(duration: 1.seconds),
                                                      const SizedBox(width: 10),
                                                      Text("CONFIRM", style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: darkColor)),
                                                    ],
                                                  ),
                                                ),
                                                const Spacer(),
                                                TextButton(
                                                  onPressed: () => Navigator.pop(context),
                                                  style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(redColor)),
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: <Widget>[
                                                      const Icon(FontAwesome.backward_fast_solid, color: darkColor, size: 20)
                                                          .animate(
                                                            onComplete: (AnimationController controller) => controller.repeat(reverse: true),
                                                          )
                                                          .shake(duration: 1.seconds),
                                                      const SizedBox(width: 10),
                                                      Text("CANCEL", style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: darkColor)),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
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
                                                Text("Transaction ID", style: GoogleFonts.itim(fontSize: 18, fontWeight: FontWeight.w500, color: greyColor)),
                                                const SizedBox(width: 10),
                                                Text(_transactions[index].transactionID, style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: blueColor)),
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              children: <Widget>[
                                                Text("Sender ID", style: GoogleFonts.itim(fontSize: 18, fontWeight: FontWeight.w500, color: greyColor)),
                                                const SizedBox(width: 10),
                                                Text(_transactions[index].senderID, style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: blueColor)),
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              children: <Widget>[
                                                Text("Receiver ID", style: GoogleFonts.itim(fontSize: 18, fontWeight: FontWeight.w500, color: greyColor)),
                                                const SizedBox(width: 10),
                                                Text(_transactions[index].receiverID, style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: greenColor)),
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              children: <Widget>[
                                                Text("Amount", style: GoogleFonts.itim(fontSize: 18, fontWeight: FontWeight.w500, color: greyColor)),
                                                const SizedBox(width: 10),
                                                Text(_transactions[index].amount.toStringAsFixed(2), style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: greenColor)),
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              children: <Widget>[
                                                Text("Timestamp", style: GoogleFonts.itim(fontSize: 18, fontWeight: FontWeight.w500, color: greyColor)),
                                                const SizedBox(width: 10),
                                                Text(formatDate(_transactions[index].timestamp, const <String>[dd, "/", MM, "/", yyyy, " - ", HH, ":", nn, " ", am]).toUpperCase(), style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: greenColor)),
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              children: <Widget>[
                                                Text("Transaction state", style: GoogleFonts.itim(fontSize: 18, fontWeight: FontWeight.w500, color: greyColor)),
                                                const SizedBox(width: 10),
                                                Text(_transactions[index].transactionState, style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: greenColor)),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 20),
                                itemCount: _transactions.length,
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
