import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:frontend/models/account_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:searchfield/searchfield.dart';

import '../../../utils/callbacks.dart';
import '../../../utils/shared.dart';

class WithdrawFromAccount extends StatefulWidget {
  const WithdrawFromAccount({super.key});

  @override
  State<WithdrawFromAccount> createState() => _WithdrawState();
}

class _WithdrawState extends State<WithdrawFromAccount> {
  final TextEditingController _balanceController = TextEditingController();

  final TextEditingController _searchMyAccountsController = TextEditingController();

  final TextEditingController _fromCurrencyController = TextEditingController();

  final TextEditingController _toCurrencyController = TextEditingController();

  final TextEditingController _fromController = TextEditingController(text: "00.00");

  final TextEditingController _toController = TextEditingController(text: "00.00");

  final TextEditingController _descriptionController = TextEditingController();

  final List<AccountModel> _accounts = <AccountModel>[];

  final GlobalKey<State<StatefulWidget>> _myAccountsKey = GlobalKey<State<StatefulWidget>>();

  final GlobalKey<State<StatefulWidget>> _fromCurrencyKey = GlobalKey<State<StatefulWidget>>();
  final GlobalKey<State<StatefulWidget>> _toCurrencyKey = GlobalKey<State<StatefulWidget>>();

  final List<String> _currencies = const <String>["TND", "USD", "GBP", "EUR"];

  final Map<String, double> _currencyExchange = const <String, double>{
    "USD2TND": 3.05,
    "TND2USD": 1 / 3.05,
    "EUR2TND": 3.55,
    "TND2EUR": 1 / 3.55,
    "GBP2TND": 4.15,
    "TND2GBP": 1 / 4.15,
    "USD2EUR": 0.85,
    "EUR2USD": 1 / 0.85,
    "USD2GBP": 0.73,
    "GBP2USD": 1 / 0.73,
    "EUR2GBP": 0.86,
    "GBP2EUR": 1 / 0.86,
    "GBP2GBP": 1,
    "TND2TND": 1,
    "USD2USD": 1,
    "EUR2EUR": 1,
  };

  Future<void> _withdraw() async {
    if (_searchMyAccountsController.text.trim().isEmpty) {
      showToast(context, "Select you account please.", redColor);
    } else if (_fromCurrencyController.text.trim().isEmpty) {
      showToast(context, "From Currency should be filled", redColor);
    } else if (_toCurrencyController.text.trim().isEmpty) {
      showToast(context, "To Currency should be filled", redColor);
    } else {
      final AccountModel myAccount = _accounts.firstWhere((AccountModel element) => element.accountNumber == _searchMyAccountsController.text);
      if ((myAccount.accountType.toUpperCase() == "CURRENT" && myAccount.balance >= double.parse(_fromController.text)) || (myAccount.accountType.toUpperCase() == "SAVINGS" && myAccount.balance - double.parse(_fromController.text) > -myAccount.withdrawLimit!)) {
        await Dio().post(
          "$ip/withdraw",
          data: <String, dynamic>{
            "senderid": _searchMyAccountsController.text,
            "receiverid": _searchMyAccountsController.text,
            "currencyfrom": _fromCurrencyController.text,
            "currencyto": _toCurrencyController.text,
            "amount": _fromController.text.isEmpty ? 0.00 : double.parse(_fromController.text),
            "description": _descriptionController.text.trim(),
            "state": "PENDING",
          },
        );
        // ignore: use_build_context_synchronously
        showToast(context, "Withdraw Completed", greenColor);
        _fromCurrencyController.clear();
        _toCurrencyController.clear();
        _fromController.clear();
        _toController.clear();
        _searchMyAccountsController.clear();
        _descriptionController.clear();
      } else {
        showToast(context, "Invalid Balance", redColor);
      }
    }
  }

  @override
  void dispose() {
    _fromCurrencyController.dispose();
    _toCurrencyController.dispose();
    _fromController.dispose();
    _toController.dispose();
    _balanceController.dispose();
    _searchMyAccountsController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<bool> _loadMyAccounts() async {
    _accounts.clear();
    final response = await Dio().get("$ip/getAllAccounts");
    for (final dynamic account in response.data["data"]) {
      _accounts.add(AccountModel.fromJson(account));
    }
    return true;
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
                Text("Withdraw from account", style: GoogleFonts.itim(fontSize: 25, fontWeight: FontWeight.w500, color: whiteColor)),
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      FutureBuilder<bool>(
                        future: _loadMyAccounts(),
                        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                          return Row(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  color: scaffoldColor,
                                  child: StatefulBuilder(
                                    key: _myAccountsKey,
                                    builder: (BuildContext context, void Function(void Function()) _) {
                                      return SearchField<String>(
                                        autoCorrect: false,
                                        onSearchTextChanged: (String value) {
                                          if (value.trim().length <= 1) {
                                            _myAccountsKey.currentState!.setState(() {});
                                          }
                                          return _accounts
                                              .where((AccountModel element) => element.accountNumber.startsWith(value))
                                              .map(
                                                (AccountModel e) => SearchFieldListItem<String>(
                                                  e.accountNumber,
                                                  item: e.accountNumber,
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Text(e.accountNumber, style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: darkColor)),
                                                  ),
                                                ),
                                              )
                                              .toList();
                                        },
                                        controller: _searchMyAccountsController,
                                        searchStyle: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: greyColor),
                                        searchInputDecoration: InputDecoration(
                                          contentPadding: const EdgeInsets.all(20),
                                          focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: purpleColor, width: 2, style: BorderStyle.solid)),
                                          border: InputBorder.none,
                                          hintText: "WHICH ACOUNT?",
                                          hintStyle: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: greyColor),
                                          suffixIcon: _searchMyAccountsController.text.trim().isEmpty ? const SizedBox() : const Icon(FontAwesome.circle_check_solid, size: 15, color: greenColor),
                                        ),
                                        suggestions: _accounts
                                            .where((AccountModel element) => element.accountHolderID == user!.userID)
                                            .map(
                                              (AccountModel e) => SearchFieldListItem<String>(
                                                e.accountNumber,
                                                item: e.accountNumber,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text(e.accountNumber, style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: darkColor)),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              color: scaffoldColor,
                              child: StatefulBuilder(
                                key: _fromCurrencyKey,
                                builder: (BuildContext context, void Function(void Function()) _) {
                                  return SearchField<String>(
                                    autoCorrect: false,
                                    onSuggestionTap: (SearchFieldListItem<String> item) {
                                      try {
                                        _toController.text = _fromController.text.isEmpty ? "0.00" : (_currencyExchange["${_fromCurrencyController.text}2${_toCurrencyController.text}"]! * double.parse(_fromController.text)).toStringAsFixed(3);
                                      } catch (e) {
                                        _toController.text = "00.00";
                                      }
                                    },
                                    onSearchTextChanged: (String value) {
                                      if (value.trim().length <= 1) {
                                        _fromCurrencyKey.currentState!.setState(() {});
                                      }
                                      return _currencies
                                          .where((String element) => element.toLowerCase().startsWith(value.toLowerCase()))
                                          .map(
                                            (String e) => SearchFieldListItem<String>(
                                              e,
                                              item: e,
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text(e, style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: darkColor)),
                                              ),
                                            ),
                                          )
                                          .toList();
                                    },
                                    readOnly: true,
                                    controller: _fromCurrencyController,
                                    searchStyle: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: greyColor),
                                    searchInputDecoration: InputDecoration(
                                      contentPadding: const EdgeInsets.all(20),
                                      focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: purpleColor, width: 2, style: BorderStyle.solid)),
                                      border: InputBorder.none,
                                      hintText: "CURRENCY",
                                      hintStyle: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: greyColor),
                                    ),
                                    initialValue: SearchFieldListItem<String>(
                                      _currencies.first,
                                      item: _currencies.first,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(_currencies.first, style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: darkColor)),
                                      ),
                                    ),
                                    suggestions: _currencies
                                        .map(
                                          (String e) => SearchFieldListItem<String>(
                                            e,
                                            item: e,
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(e, style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: darkColor)),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  );
                                },
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Container(
                              color: scaffoldColor,
                              child: StatefulBuilder(
                                key: _toCurrencyKey,
                                builder: (BuildContext context, void Function(void Function()) _) {
                                  return SearchField<String>(
                                    autoCorrect: false,
                                    onSuggestionTap: (SearchFieldListItem<String> item) {
                                      try {
                                        _toController.text = _fromController.text.isEmpty ? "0.00" : (_currencyExchange["${_fromCurrencyController.text}2${_toCurrencyController.text}"]! * double.parse(_fromController.text)).toStringAsFixed(3);
                                      } catch (e) {
                                        _toController.text = "00.00";
                                      }
                                    },
                                    onSearchTextChanged: (String value) {
                                      if (value.trim().length <= 1) {
                                        _toCurrencyKey.currentState!.setState(() {});
                                      }
                                      return _currencies
                                          .where((String element) => element.toLowerCase().startsWith(value.toLowerCase()))
                                          .map(
                                            (String e) => SearchFieldListItem<String>(
                                              e,
                                              item: e,
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text(e, style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: darkColor)),
                                              ),
                                            ),
                                          )
                                          .toList();
                                    },
                                    readOnly: true,
                                    initialValue: SearchFieldListItem<String>(
                                      _currencies.first,
                                      item: _currencies.first,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(_currencies.first, style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: darkColor)),
                                      ),
                                    ),
                                    controller: _toCurrencyController,
                                    searchStyle: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: greyColor),
                                    searchInputDecoration: InputDecoration(
                                      contentPadding: const EdgeInsets.all(20),
                                      focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: purpleColor, width: 2, style: BorderStyle.solid)),
                                      border: InputBorder.none,
                                      hintText: "CURRENCY",
                                      hintStyle: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: greyColor),
                                    ),
                                    suggestions: _currencies
                                        .map(
                                          (String e) => SearchFieldListItem<String>(
                                            e,
                                            item: e,
                                            child: Padding(padding: const EdgeInsets.all(8.0), child: Text(e, style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: darkColor))),
                                          ),
                                        )
                                        .toList(),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: scaffoldColor),
                              child: TextField(
                                style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: whiteColor),
                                controller: _fromController,
                                onChanged: (String value) {
                                  try {
                                    _toController.text = value.isEmpty ? "0.00" : (_currencyExchange["${_fromCurrencyController.text}2${_toCurrencyController.text}"]! * double.parse(value)).toStringAsFixed(3);
                                  } catch (e) {
                                    _toController.text = "00.00";
                                  }
                                },
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(16),
                                  border: InputBorder.none,
                                  hintText: "From",
                                  hintStyle: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: whiteColor),
                                ),
                                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r"[\d\.]"))],
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: scaffoldColor),
                              child: TextField(
                                readOnly: true,
                                style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: whiteColor),
                                controller: _toController,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(16),
                                  border: InputBorder.none,
                                  hintText: "To",
                                  hintStyle: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: whiteColor),
                                ),
                                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r"[\d\.]"))],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: scaffoldColor),
                        child: TextField(
                          maxLines: 7,
                          style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: whiteColor),
                          controller: _descriptionController,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(16),
                            border: InputBorder.none,
                            hintText: "Description",
                            hintStyle: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: whiteColor),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      AnimatedButton(
                        width: 90,
                        height: 40,
                        text: "Withdraw",
                        selectedTextColor: darkColor,
                        animatedOn: AnimatedOn.onHover,
                        animationDuration: 500.ms,
                        isReverse: true,
                        selectedBackgroundColor: greenColor,
                        backgroundColor: purpleColor,
                        transitionType: TransitionType.TOP_TO_BOTTOM,
                        textStyle: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: whiteColor),
                        onPress: _withdraw,
                      ),
                    ],
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
