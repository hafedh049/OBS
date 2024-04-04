// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:uuid/v8.dart';

import '../../../utils/callbacks.dart';
import '../../../utils/shared.dart';
import '../../../models/bank_model.dart';

class AddBank extends StatefulWidget {
  const AddBank({super.key, required this.callback, required this.banks});
  final List<BankModel> banks;
  final void Function() callback;
  @override
  State<AddBank> createState() => _AddBankState();
}

class _AddBankState extends State<AddBank> {
  final TextEditingController _bankNameController = TextEditingController();
  final TextEditingController _bankAddressController = TextEditingController();

  Future<void> _addBank() async {
    if (_bankNameController.text.trim().isEmpty) {
      showToast(context, "Enter a valid bank name", redColor);
    } else if (_bankAddressController.text.trim().isEmpty) {
      showToast(context, "Enter a valid bank address", redColor);
    } else {
      final Map<String, dynamic> bankItem = <String, dynamic>{
        "bankid": const UuidV8().generate(),
        'bankname': _bankNameController.text.trim(),
        'bankaddress': _bankAddressController.text.trim(),
      };

      await Dio().post("$ip/addBank", data: bankItem);

      widget.banks.add(BankModel.fromJson(bankItem));
      widget.callback();
      showToast(context, "Bank added successfully", greenColor);
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _bankNameController.dispose();
    _bankAddressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          color: darkColor,
          child: StatefulBuilder(
            builder: (BuildContext context, void Function(void Function()) _) {
              return TextField(
                onChanged: (String value) => value.trim().length <= 1 ? _(() {}) : null,
                onSubmitted: (String value) => _addBank(),
                controller: _bankNameController,
                style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: greyColor),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(20),
                  focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: purpleColor, width: 2, style: BorderStyle.solid)),
                  border: InputBorder.none,
                  hintText: 'BANK NAME',
                  hintStyle: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: greyColor),
                  prefixIcon: _bankNameController.text.trim().isEmpty ? null : const Icon(FontAwesome.circle_check_solid, size: 15, color: greenColor),
                ),
                cursorColor: purpleColor,
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        Container(
          color: darkColor,
          child: StatefulBuilder(
            builder: (BuildContext context, void Function(void Function()) _) {
              return TextField(
                onChanged: (String value) => value.trim().length <= 1 ? _(() {}) : null,
                onSubmitted: (String value) => _addBank(),
                controller: _bankAddressController,
                style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: greyColor),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(20),
                  focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: purpleColor, width: 2, style: BorderStyle.solid)),
                  border: InputBorder.none,
                  hintText: 'BANK ADDRESS',
                  hintStyle: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: greyColor),
                  prefixIcon: _bankAddressController.text.trim().isEmpty ? null : const Icon(FontAwesome.circle_check_solid, size: 15, color: greenColor),
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
              width: 150,
              height: 30,
              text: 'ADD BANK',
              selectedTextColor: whiteColor,
              animatedOn: AnimatedOn.onHover,
              animationDuration: 500.ms,
              isReverse: true,
              selectedBackgroundColor: darkColor,
              backgroundColor: greenColor,
              transitionType: TransitionType.TOP_TO_BOTTOM,
              textStyle: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: whiteColor),
              onPress: () async => await _addBank(),
            ),
          ],
        ),
      ],
    );
  }
}
