import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:cool_dropdown/models/cool_dropdown_item.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:frontend/models/bank_model.dart';
import 'package:frontend/utils/callbacks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../../../utils/shared.dart';

class CurrentForm extends StatefulWidget {
  const CurrentForm({super.key});

  @override
  State<CurrentForm> createState() => _CurrentFormState();
}

class _CurrentFormState extends State<CurrentForm> {
  final TextEditingController _balanceController = TextEditingController();
  final TextEditingController _overdraftLimitController = TextEditingController(text: "500 DT");
  final TextEditingController _maxTransLimitController = TextEditingController(text: "3000 DT per month");

  List<BankModel> _banks = <BankModel>[];

  BankModel _selectedBank = BankModel(bankID: "CHOOSE BANK ACCOUNT", bankName: "CHOOSE BANK ACCOUNT", bankAddress: "CHOOSE BANK ACCOUNT");

  final DropdownController _banksController = DropdownController();

  Future<bool> _getAllBanks() async {
    _banks = <BankModel>[];
    final Response response = await Dio().get("$ip/getAllBanks");
    for (final dynamic bank in response.data["data"]) {
      _banks.add(BankModel.fromJson(bank));
    }
    return true;
  }

  Future<void> _addSavingsAccount() async {
    if (_selectedBank.bankName.isEmpty || _selectedBank.bankName == "CHOOSE BANK ACCOUNT") {
      showToast(context, "Please choose the bank name", redColor);
    } else if (_balanceController.text.isEmpty) {
      showToast(context, "Balance cannot be empty!", redColor);
    } else {
      await Dio().post(
        "$ip/createAccount",
        data: <String, dynamic>{
          "bankid": _selectedBank.bankID,
          "userid": user!.userID,
          "username": user!.userName,
          "balance": double.parse(_balanceController.text.split(" ").first),
          "type": "CURRENT",
          "isactive": true,
          "overdraftlimit": double.parse(_overdraftLimitController.text.split(" ").first),
          "maxtranslimit": double.parse(_maxTransLimitController.text.split(" ").first),
          "interestrate": null,
          "minimumbalance": null,
          "withdrawlimit": null,
        },
      );
      _balanceController.clear();
      _selectedBank = BankModel(bankID: "CHOOSE BANK ACCOUNT", bankName: "CHOOSE BANK ACCOUNT", bankAddress: "CHOOSE BANK ACCOUNT");
      _banksController.resetValue();
      // ignore: use_build_context_synchronously
      showToast(context, "Account added successfully", greenColor);
    }
  }

  @override
  void dispose() {
    _banksController.dispose();
    _balanceController.dispose();
    _overdraftLimitController.dispose();
    _maxTransLimitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(FontAwesome.chevron_left_solid, size: 15, color: whiteColor)),
                Text("Create savings account", style: GoogleFonts.itim(fontSize: 25, fontWeight: FontWeight.w500, color: whiteColor)),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              width: MediaQuery.sizeOf(context).width - 2 * 24,
              height: .5,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: greyColor),
            ),
            Expanded(
              child: Center(
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: darkColor),
                  constraints: const BoxConstraints(maxWidth: 600),
                  padding: const EdgeInsets.all(16),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Flexible(child: Text("Bank name", style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: whiteColor))),
                            const SizedBox(width: 5),
                            Text("*", style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: redColor)),
                          ],
                        ),
                        const SizedBox(height: 20),
                        FutureBuilder<bool>(
                          future: _getAllBanks(),
                          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                            return CoolDropdown<String>(
                              resultOptions: ResultOptions(
                                textStyle: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: whiteColor),
                                boxDecoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: scaffoldColor),
                                openBoxDecoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: scaffoldColor),
                              ),
                              dropdownItemOptions: DropdownItemOptions(
                                selectedTextStyle: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w600, color: purpleColor),
                                textStyle: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: whiteColor),
                              ),
                              dropdownOptions: DropdownOptions(borderRadius: BorderRadius.circular(10), color: scaffoldColor),
                              defaultItem: CoolDropdownItem(label: "CHOOSE BANK ACCOUNT", value: "CHOOSE BANK ACCOUNT"),
                              dropdownList: _banks.map((BankModel e) => CoolDropdownItem<String>(label: e.bankName.toUpperCase(), value: e.bankID)).toList(),
                              controller: _banksController,
                              onChange: (String bankID) => _selectedBank = _banks.firstWhere((BankModel e) => e.bankID == bankID),
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Flexible(child: Text("Balance amount", style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: whiteColor))),
                            const SizedBox(width: 5),
                            Text("*", style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: redColor)),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: scaffoldColor),
                          child: TextField(
                            style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: whiteColor),
                            controller: _balanceController,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(16),
                              border: InputBorder.none,
                              hintText: "Balance",
                              hintStyle: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: whiteColor),
                            ),
                            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r"[\d\.]"))],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Flexible(child: Text("Overdraft limit", style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: whiteColor))),
                            const SizedBox(width: 5),
                            Text("*", style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: redColor)),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: scaffoldColor),
                          child: TextField(
                            readOnly: true,
                            style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: whiteColor),
                            controller: _overdraftLimitController,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(16),
                              border: InputBorder.none,
                              hintText: "Overdraft",
                              hintStyle: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: whiteColor),
                            ),
                            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r"[\d\.]"))],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Flexible(child: Text("Maximum transaction limit", style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: whiteColor))),
                            const SizedBox(width: 5),
                            Text("*", style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: redColor)),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: scaffoldColor),
                          child: TextField(
                            readOnly: true,
                            style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: whiteColor),
                            controller: _maxTransLimitController,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(16),
                              border: InputBorder.none,
                              hintText: "Minimum balance",
                              hintStyle: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: whiteColor),
                            ),
                            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r"[\d\.]"))],
                          ),
                        ),
                        const SizedBox(height: 20),
                        AnimatedButton(
                          width: 140,
                          height: 40,
                          text: "ADD ACCOUNT",
                          selectedTextColor: darkColor,
                          animatedOn: AnimatedOn.onHover,
                          animationDuration: 500.ms,
                          isReverse: true,
                          selectedBackgroundColor: greenColor,
                          backgroundColor: purpleColor,
                          transitionType: TransitionType.TOP_TO_BOTTOM,
                          textStyle: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: whiteColor),
                          onPress: _addSavingsAccount,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
