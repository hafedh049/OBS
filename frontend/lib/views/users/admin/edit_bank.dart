// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:frontend/models/bank_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../utils/callbacks.dart';
import '../../../utils/shared.dart';

class EditBank extends StatefulWidget {
  const EditBank({super.key, required this.bank, required this.callback});
  final BankModel bank;
  final void Function() callback;
  @override
  State<EditBank> createState() => _EditBankState();
}

class _EditBankState extends State<EditBank> {
  final TextEditingController _bankIDController = TextEditingController();
  final TextEditingController _bankNameController = TextEditingController();
  final TextEditingController _bankAddressController = TextEditingController();

  @override
  void initState() {
    _bankIDController.text = widget.bank.bankID;
    _bankNameController.text = widget.bank.bankName.toUpperCase();
    _bankAddressController.text = widget.bank.bankAddress;

    super.initState();
  }

  late final Map<String, Map<String, dynamic>> _bankTemplate = <String, Map<String, dynamic>>{
    "BANK ID": <String, dynamic>{"controller": _bankIDController, "type": "reference", "required": false, "hint": ""},
    "BANK NAME": <String, dynamic>{"controller": _bankNameController, "type": "text", "required": true, "hint": "Enter the bank name"},
    "BANK ADDRESS": <String, dynamic>{"controller": _bankAddressController, "type": "text", "required": true, "hint": "fill the bank address"},
  };

  @override
  void dispose() {
    _bankIDController.dispose();
    _bankNameController.dispose();
    _bankAddressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(FontAwesome.chevron_left_solid, size: 25, color: purpleColor)),
                  const SizedBox(width: 10),
                  Text("EDIT BANK INFORMATION", style: GoogleFonts.itim(fontSize: 22, fontWeight: FontWeight.w500, color: greyColor)),
                  const Spacer(),
                ],
              ),
              Container(width: MediaQuery.sizeOf(context).width, height: .3, color: greyColor, margin: const EdgeInsets.symmetric(vertical: 20)),
              Wrap(
                children: <Widget>[
                  for (final MapEntry<String, Map<String, dynamic>> entry in _bankTemplate.entries)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(entry.key, style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: whiteColor)),
                            const SizedBox(width: 5),
                            Text("*", style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: entry.value["required"] ? redColor : greenColor)),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Container(
                          color: darkColor,
                          child: StatefulBuilder(
                            builder: (BuildContext context, void Function(void Function()) _) {
                              return TextField(
                                onChanged: (String value) {
                                  if (value.trim().length <= 1) {
                                    _(() {});
                                  }
                                },
                                controller: entry.value["controller"],
                                readOnly: entry.value["type"] == "date" || entry.value["type"] == "reference" ? true : false,
                                style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: greyColor),
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(20),
                                  focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: purpleColor, width: 2, style: BorderStyle.solid)),
                                  border: InputBorder.none,
                                  hintText: entry.value["hint"],
                                  hintStyle: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: greyColor),
                                  suffixIcon: entry.value["controller"].text.trim().isEmpty ? null : const Icon(FontAwesome.circle_check_solid, size: 15, color: greenColor),
                                ),
                                cursorColor: purpleColor,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                    RegExp(
                                      entry.value["type"] == "double"
                                          ? r"[\d.]"
                                          : entry.value["type"] == "number"
                                              ? r"\d"
                                              : r".",
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                ],
              ),
              AnimatedButton(
                width: 160,
                height: 40,
                text: 'UPDATE BANK INFO',
                selectedTextColor: darkColor,
                animatedOn: AnimatedOn.onHover,
                animationDuration: 500.ms,
                isReverse: true,
                selectedBackgroundColor: greenColor,
                backgroundColor: purpleColor,
                transitionType: TransitionType.TOP_TO_BOTTOM,
                textStyle: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: whiteColor),
                onPress: () async {
                  if (_bankNameController.text.trim().isEmpty) {
                    showToast(context, "Enter the bank's name", redColor);
                  } else if (_bankAddressController.text.trim().isEmpty) {
                    showToast(context, "Enter the bank address", redColor);
                  } else {
                    await Dio().post(
                      "$ip/updateBank",
                      data: <String, dynamic>{
                        "bankid": widget.bank.bankID,
                        "bankname": _bankNameController.text.trim(),
                        "bankaddress": _bankAddressController.text.trim(),
                      },
                    );
                    showToast(context, "Bank is up to date now", greenColor);
                    Navigator.pop(context);
                    widget.callback();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
