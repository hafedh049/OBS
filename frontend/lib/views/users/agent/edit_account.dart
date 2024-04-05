import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../models/account_model.dart';
import '../../../utils/callbacks.dart';
import '../../../utils/shared.dart';

class EditAccount extends StatefulWidget {
  const EditAccount({super.key, required this.account});
  final AccountModel account;

  @override
  State<EditAccount> createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  final TextEditingController _accountHolderIDController = TextEditingController();
  final TextEditingController _accountNumberController = TextEditingController();
  final TextEditingController _accountBankIDController = TextEditingController();
  final TextEditingController _accountHolderNameController = TextEditingController();
  final TextEditingController _balanceController = TextEditingController();
  final TextEditingController _accountTypeController = TextEditingController();
  final TextEditingController _isActiveController = TextEditingController();
  final TextEditingController _overdraftLimitController = TextEditingController();
  final TextEditingController _maxTransLimitController = TextEditingController();
  final TextEditingController _interestRateController = TextEditingController();
  final TextEditingController _minimumBalanceController = TextEditingController();
  final TextEditingController _withdrawLimitController = TextEditingController();
  final TextEditingController _createdAtController = TextEditingController();

  @override
  void initState() {
    _accountBankIDController.text = widget.account.accountBankID;
    _createdAtController.text = formatDate(widget.account.createdAt, const <String>[yy, '/', MM, '/', d, " - ", HH, ':', nn, ':', ss]).toUpperCase();
    _accountHolderIDController.text = widget.account.accountHolderID;
    _accountHolderNameController.text = widget.account.accountHolderName;
    _accountNumberController.text = widget.account.accountNumber;
    _balanceController.text = widget.account.balance.toStringAsFixed(2);
    _accountTypeController.text = widget.account.accountType;
    _isActiveController.text = widget.account.isActive ? "ACTIVE" : "DISABLED";

    if (widget.account.accountType == "CURRENT") {
      _overdraftLimitController.text = widget.account.overdraftLimit!.toStringAsFixed(2);
      _maxTransLimitController.text = widget.account.maxTransLimit.toString();
    }

    if (widget.account.accountType == "SAVINGS") {
      _interestRateController.text = widget.account.interestRate!.toStringAsFixed(2);
      _minimumBalanceController.text = widget.account.minimumBalance!.toStringAsFixed(2);
      _withdrawLimitController.text = widget.account.withdrawLimit!.toStringAsFixed(2);
    }

    super.initState();
  }

  late final Map<String, Map<String, dynamic>> _accountTemplate = <String, Map<String, dynamic>>{
    "BANK ID": <String, dynamic>{"controller": _accountBankIDController, "type": "reference", "required": true, "hint": ""},
    "CREATED AT": <String, dynamic>{"controller": _createdAtController, "type": "date", "required": false, "hint": ""},
    "HOLDER ID": <String, dynamic>{"controller": _accountHolderIDController, "type": "reference", "required": false, "hint": ""},
    "HOLDER NAME": <String, dynamic>{"controller": _accountHolderNameController, "type": "text", "required": true, "hint": "Account owner name"},
    "ACCOUNT ID": <String, dynamic>{"controller": _accountNumberController, "type": "reference", "required": false, "hint": ""},
    "ACCOUNT BALANCE": <String, dynamic>{"controller": _balanceController, "type": "double", "required": true, "hint": "00.00 DT"},
    "ACCOUNT TYPE": <String, dynamic>{"controller": _accountTypeController, "type": "text", "required": true, "hint": "CURRENT or SAVINGS"},
    "ACCOUNT STATE": <String, dynamic>{"controller": _isActiveController, "type": "text", "required": true, "hint": "ACTIVE or DISABLED"},
    "OVERDRAFT LIMIT": <String, dynamic>{"controller": _overdraftLimitController, "type": "double", "required": true, "hint": "1K DT"},
    "MAXIMUM TRANSACTIONS LIMIT": <String, dynamic>{"controller": _maxTransLimitController, "type": "number", "required": true, "hint": "30 per month"},
    "INTEREST RATE": <String, dynamic>{"controller": _interestRateController, "type": "double", "required": true, "hint": "0.5 DT"},
    "MINIMUM BALANCE": <String, dynamic>{"controller": _minimumBalanceController, "type": "double", "required": true, "hint": "100 DT"},
    "WITHDRAWAL LIMIT": <String, dynamic>{"controller": _withdrawLimitController, "type": "double", "required": true, "hint": "10K DT per month"},
  };

  @override
  void dispose() {
    _accountHolderIDController.dispose();
    _accountNumberController.dispose();
    _accountBankIDController.dispose();
    _accountHolderNameController.dispose();
    _balanceController.dispose();
    _accountTypeController.dispose();
    _isActiveController.dispose();
    _overdraftLimitController.dispose();
    _maxTransLimitController.dispose();
    _interestRateController.dispose();
    _minimumBalanceController.dispose();
    _withdrawLimitController.dispose();
    _createdAtController.dispose();
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
                  Text("EDIT ACCOUNT", style: GoogleFonts.itim(fontSize: 22, fontWeight: FontWeight.w500, color: greyColor)),
                  const Spacer(),
                ],
              ),
              Container(width: MediaQuery.sizeOf(context).width, height: .3, color: greyColor, margin: const EdgeInsets.symmetric(vertical: 20)),
              Wrap(
                children: <Widget>[
                  for (final MapEntry<String, Map<String, dynamic>> entry in _accountTemplate.entries.skipWhile(
                    (MapEntry<String, Map<String, dynamic>> value) => widget.account.accountType == "CURRENT"
                        ? const <String>[
                            "OVERDRAFT LIMIT",
                            "MAXIMUM TRANSACTIONS LIMIT",
                          ].contains(value.key)
                        : const <String>[
                            "INTEREST RATE",
                            "MINIMUM BALANCE",
                            "WITHDRAWAL LIMIT",
                          ].contains(value.key),
                  ))
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
                width: 150,
                height: 40,
                text: 'METTRE A JOUR',
                selectedTextColor: darkColor,
                animatedOn: AnimatedOn.onHover,
                animationDuration: 500.ms,
                isReverse: true,
                selectedBackgroundColor: greenColor,
                backgroundColor: purpleColor,
                transitionType: TransitionType.TOP_TO_BOTTOM,
                textStyle: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: whiteColor),
                onPress: () async {
                  if (_accountHolderNameController.text.trim().isEmpty) {
                    showToast(context, "Enter the account owner's name", redColor);
                  } else if (_accountTypeController.text.trim().isEmpty) {
                    showToast(context, "Choose the account type", redColor);
                  } else if (_balanceController.text.trim().isEmpty) {
                    showToast(context, "Enter the account balance", redColor);
                  } else if (_isActiveController.text.trim().isEmpty) {
                    showToast(context, "Select if the account is active or not", redColor);
                  } else {
                    showToast(context, "Produit ajouté", greenColor);
                    Navigator.pop(context);
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
