import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:frontend/views/auth/sign_in.dart';
import 'package:frontend/views/models/bank_model.dart';
import 'package:frontend/views/users/admin/add_bank.dart';
import 'package:frontend/views/users/admin/delete_bank.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:lottie/lottie.dart';

import '../../../utils/callbacks.dart';
import '../../../utils/helpers/errored.dart';
import '../../../utils/helpers/loading.dart';
import '../../../utils/shared.dart';

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
      return <BankModel>[];
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
                  onPress: () => showDialog(context: context, builder: (BuildContext context) => AlertDialog(contentPadding: const EdgeInsets.all(16), content: AddBank(banks: _banks, callback: () => _banksKey.currentState!.setState(() {})))),
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
                    showToast(context, "Au revoire", redColor);
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context) => const SignIn()), (Route route) => false);
                  },
                ),
              ],
            ),
            Container(width: MediaQuery.sizeOf(context).width, height: .3, color: greyColor, margin: const EdgeInsets.symmetric(vertical: 20)),
            Expanded(
              child: Center(
                child: FutureBuilder<List<BankModel>>(
                  future: _loadBanks(),
                  builder: (BuildContext context, AsyncSnapshot<List<BankModel>> snapshot) {
                    if (snapshot.hasData) {
                      _banks = snapshot.data!;
                      return StatefulBuilder(
                        key: _banksKey,
                        builder: (BuildContext context, void Function(void Function()) setS) => _banks.isEmpty
                            ? Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  LottieBuilder.asset("assets/lotties/empty.json"),
                                  Text("Pas de stores.", style: GoogleFonts.itim(fontSize: 18, fontWeight: FontWeight.w500, color: greyColor)),
                                ],
                              )
                            : SingleChildScrollView(
                                child: Wrap(
                                  alignment: WrapAlignment.center,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  runAlignment: WrapAlignment.center,
                                  runSpacing: 20,
                                  spacing: 20,
                                  children: <Widget>[
                                    for (final BankModel item in _banks)
                                      InkWell(
                                        splashColor: transparentColor,
                                        hoverColor: transparentColor,
                                        highlightColor: transparentColor,
                                        onTap: () {},
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
                                                      Text("Bank", style: GoogleFonts.itim(fontSize: 18, fontWeight: FontWeight.w500, color: greyColor)),
                                                      const SizedBox(width: 10),
                                                      Text(item.bankName, style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: blueColor)),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 10),
                                                  Row(
                                                    children: <Widget>[
                                                      Text("Vendeur", style: GoogleFonts.itim(fontSize: 18, fontWeight: FontWeight.w500, color: greyColor)),
                                                      const SizedBox(width: 10),
                                                      Text(item.bankAddress, style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: greenColor)),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              IconButton(
                                                onPressed: () => showDialog(
                                                  context: context,
                                                  builder: (BuildContext context) => AlertDialog(
                                                    content: DeleteBank(bankID: item.bankID, banks: _banks, callback: () => _banksKey.currentState!.setState(() {})),
                                                  ),
                                                ),
                                                icon: const Icon(FontAwesome.delete_left_solid, size: 25, color: purpleColor),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
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
