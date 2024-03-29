import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:frontend/utils/helpers/screen_container.dart';
import 'package:frontend/utils/shared.dart';
import 'package:frontend/views/accounts/accounts_list.dart';
import 'package:frontend/views/accounts/add_account.dart';
import 'package:frontend/views/accounts/disposit_account.dart';
import 'package:frontend/views/accounts/withdraw_account.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Map<String, dynamic>> _screens = <Map<String, dynamic>>[
    <String, dynamic>{
      "title": "ADD ACCOUNT",
      "widget": const AddAccount(),
    },
    <String, dynamic>{
      "title": "DIPOSIT TO ACCOUNT",
      "widget": const Disposit2Account(),
    },
    <String, dynamic>{
      "title": "WITHDRAW FROM ACCOUNT",
      "widget": const WithdrawFromAccount(),
    },
    <String, dynamic>{
      "title": "DISPLAY ACCOUNT LIST",
      "widget": const AccountsList(),
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text("Home", style: GoogleFonts.itim(fontSize: 25, fontWeight: FontWeight.w500, color: whiteColor)),
                const Spacer(),
                AnimatedButton(
                  width: 100,
                  height: 30,
                  text: "Sign-Out",
                  selectedTextColor: darkColor,
                  animatedOn: AnimatedOn.onHover,
                  animationDuration: 500.ms,
                  isReverse: true,
                  selectedBackgroundColor: greenColor,
                  backgroundColor: purpleColor,
                  transitionType: TransitionType.TOP_TO_BOTTOM,
                  textStyle: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: whiteColor),
                  onPress: () => Navigator.pop(context),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              width: MediaQuery.sizeOf(context).width - 2 * 24,
              height: .5,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: greyColor),
            ),
            SizedBox(
              width: MediaQuery.sizeOf(context).width - 2 * 24,
              height: MediaQuery.sizeOf(context).height - 2 * 24 - 60,
              child: SingleChildScrollView(
                child: Center(
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    alignment: WrapAlignment.center,
                    runAlignment: WrapAlignment.center,
                    runSpacing: 20,
                    spacing: 20,
                    children: <Widget>[for (final Map<String, dynamic> item in _screens) ScreenContainer(item: item)],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
