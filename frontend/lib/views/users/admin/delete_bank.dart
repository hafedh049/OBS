// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../utils/callbacks.dart';
import '../../../utils/shared.dart';
import '../../../models/bank_model.dart';

class DeleteBank extends StatefulWidget {
  const DeleteBank({super.key, required this.bankID, required this.banks, required this.callback});
  final String bankID;
  final List<BankModel> banks;
  final void Function() callback;
  @override
  State<DeleteBank> createState() => _DeleteBankState();
}

class _DeleteBankState extends State<DeleteBank> {
  bool _passphraseState = false;
  final TextEditingController _confirmController = TextEditingController();

  void _validate() async {
    if (_confirmController.text != user!.userPassword) {
      showToast(context, "Enter the confirmation passphrase", redColor);
    } else {
      await Dio().post("$ip/deleteBank", data: <String, dynamic>{"bankid": widget.bankID});
      widget.banks.removeWhere((BankModel element) => element.bankID == widget.bankID);
      widget.callback();
      showToast(context, "Bank deleted", greenColor);
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Are you sure to delete '${widget.banks.firstWhere((BankModel element) => element.bankID == widget.bankID).bankName}'",
          style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: whiteColor),
        ),
        const SizedBox(height: 20),
        Container(
          decoration: BoxDecoration(color: scaffoldColor, borderRadius: BorderRadius.circular(3)),
          child: StatefulBuilder(
            builder: (BuildContext context, void Function(void Function()) _) {
              return TextField(
                obscureText: !_passphraseState,
                onSubmitted: (String value) => _validate(),
                onChanged: (String value) => value.trim().length <= 1 ? _(() {}) : null,
                controller: _confirmController,
                style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: greyColor),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(20),
                  focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: purpleColor, width: 2, style: BorderStyle.solid)),
                  border: InputBorder.none,
                  hintText: '**********',
                  hintStyle: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: greyColor),
                  prefixIcon: _confirmController.text.trim().isEmpty ? null : const Icon(FontAwesome.circle_check_solid, size: 15, color: greenColor),
                  suffixIcon: IconButton(onPressed: () => _(() => _passphraseState = !_passphraseState), icon: Icon(_passphraseState ? FontAwesome.eye_solid : FontAwesome.eye_slash_solid, size: 15, color: purpleColor)),
                ),
                cursorColor: purpleColor,
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Spacer(),
            AnimatedButton(
              width: 100,
              height: 30,
              text: 'DELETE',
              selectedTextColor: whiteColor,
              animatedOn: AnimatedOn.onHover,
              animationDuration: 500.ms,
              isReverse: true,
              selectedBackgroundColor: darkColor,
              backgroundColor: greenColor,
              transitionType: TransitionType.TOP_TO_BOTTOM,
              textStyle: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: whiteColor),
              onPress: () => _validate(),
            ),
            const SizedBox(width: 10),
            AnimatedButton(
              width: 100,
              height: 30,
              text: 'CANCEL',
              selectedTextColor: whiteColor,
              animatedOn: AnimatedOn.onHover,
              animationDuration: 500.ms,
              isReverse: true,
              selectedBackgroundColor: darkColor,
              backgroundColor: greenColor,
              transitionType: TransitionType.TOP_TO_BOTTOM,
              textStyle: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: whiteColor),
              onPress: () => Navigator.pop(context),
            ),
          ],
        ),
      ],
    );
  }
}
