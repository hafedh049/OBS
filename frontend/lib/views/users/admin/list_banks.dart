import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:frontend/views/auth/sign_in.dart';
import 'package:frontend/models/bank_model.dart';
import 'package:frontend/views/users/admin/add_bank.dart';
import 'package:frontend/views/users/admin/delete_bank.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:lottie/lottie.dart';

import '../../../utils/callbacks.dart';
import '../../../utils/helpers/errored.dart';
import '../../../utils/helpers/loading.dart';
import '../../../utils/shared.dart';
import 'edit_bank.dart';

class BanksList extends StatefulWidget {
  const BanksList({super.key});

  @override
  State<BanksList> createState() => _BanksListState();
}

class _BanksListState extends State<BanksList> {
  final GlobalKey<State> _banksKey = GlobalKey<State>();

  List<BankModel> _banks = <BankModel>[];

  Future<List<BankModel>> _loadBanks() async {
    try {
      final Response response = await Dio().get("$ip/getAllBanks");
      final List<BankModel> banks = <BankModel>[];
      for (final dynamic e in response.data["data"]) {
        banks.add(BankModel.fromJson(e));
      }
      return banks;
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
            Row(
              children: <Widget>[
                Text("Banks List", style: GoogleFonts.itim(fontSize: 22, fontWeight: FontWeight.w500, color: greyColor)),
                const Spacer(),
                AnimatedButton(
                  width: 100,
                  height: 35,
                  text: 'ADD',
                  selectedTextColor: darkColor,
                  animatedOn: AnimatedOn.onHover,
                  animationDuration: 500.ms,
                  isReverse: true,
                  selectedBackgroundColor: redColor,
                  backgroundColor: purpleColor,
                  transitionType: TransitionType.TOP_TO_BOTTOM,
                  textStyle: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: whiteColor),
                  onPress: () => showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      backgroundColor: scaffoldColor,
                      contentPadding: const EdgeInsets.all(16),
                      content: SizedBox(width: MediaQuery.sizeOf(context).width * .7, child: AddBank(banks: _banks, callback: () => _banksKey.currentState!.setState(() {}))),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                AnimatedButton(
                  width: 100,
                  height: 35,
                  text: 'SIGN-OUT',
                  selectedTextColor: darkColor,
                  animatedOn: AnimatedOn.onHover,
                  animationDuration: 500.ms,
                  isReverse: true,
                  selectedBackgroundColor: redColor,
                  backgroundColor: purpleColor,
                  transitionType: TransitionType.TOP_TO_BOTTOM,
                  textStyle: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: whiteColor),
                  onPress: () async {
                    showToast(context, "Have a nice day", redColor);
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context) => const SignIn()), (Route route) => false);
                  },
                ),
              ],
            ),
            Container(width: MediaQuery.sizeOf(context).width, height: .3, color: greyColor, margin: const EdgeInsets.symmetric(vertical: 20)),
            Expanded(
              child: Center(
                child: StatefulBuilder(
                  key: _banksKey,
                  builder: (BuildContext context, void Function(void Function()) setS) {
                    return FutureBuilder<List<BankModel>>(
                      future: _loadBanks(),
                      builder: (BuildContext context, AsyncSnapshot<List<BankModel>> snapshot) {
                        if (snapshot.hasData) {
                          _banks = snapshot.data!;
                          return _banks.isEmpty
                              ? Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    LottieBuilder.asset("assets/lotties/empty.json", reverse: true),
                                    Text("No banks yet.", style: GoogleFonts.itim(fontSize: 18, fontWeight: FontWeight.w500, color: greyColor)),
                                  ],
                                )
                              : ListView.separated(
                                  itemBuilder: (BuildContext context, int index) => InkWell(
                                    splashColor: transparentColor,
                                    hoverColor: transparentColor,
                                    highlightColor: transparentColor,
                                    onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) => EditBank(
                                          bank: _banks[index],
                                          callback: () => _banksKey.currentState!.setState(() {}),
                                        ),
                                      ),
                                    ),
                                    child: Container(
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
                                                  Text(_banks[index].bankID, style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: blueColor)),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              Row(
                                                children: <Widget>[
                                                  Text("Bank name", style: GoogleFonts.itim(fontSize: 18, fontWeight: FontWeight.w500, color: greyColor)),
                                                  const SizedBox(width: 10),
                                                  Text(_banks[index].bankName, style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: blueColor)),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              Row(
                                                children: <Widget>[
                                                  Text("Bank address", style: GoogleFonts.itim(fontSize: 18, fontWeight: FontWeight.w500, color: greyColor)),
                                                  const SizedBox(width: 10),
                                                  Text(_banks[index].bankAddress, style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: greenColor)),
                                                ],
                                              ),
                                            ],
                                          ),
                                          IconButton(
                                            onPressed: () => showDialog(
                                              context: context,
                                              builder: (BuildContext context) => AlertDialog(
                                                backgroundColor: scaffoldColor,
                                                content: SizedBox(
                                                  width: MediaQuery.sizeOf(context).width * .7,
                                                  child: DeleteBank(bankID: _banks[index].bankID, banks: _banks, callback: () => _banksKey.currentState!.setState(() {})),
                                                ),
                                              ),
                                            ),
                                            icon: const Icon(FontAwesome.delete_left_solid, size: 25, color: purpleColor),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 20),
                                  itemCount: _banks.length,
                                );
                        } else if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Loading();
                        }
                        return Errored(error: snapshot.error.toString());
                      },
                    );
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
