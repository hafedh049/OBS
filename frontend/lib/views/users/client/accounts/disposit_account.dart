import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:frontend/models/account_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:searchfield/searchfield.dart';

import '../../../../utils/shared.dart';

class Disposit2Account extends StatefulWidget {
  const Disposit2Account({super.key});

  @override
  State<Disposit2Account> createState() => _Disposit2AccountState();
}

class _Disposit2AccountState extends State<Disposit2Account> {
  final TextEditingController _accountNumberController = TextEditingController();
  final TextEditingController _balanceController = TextEditingController();

  final TextEditingController _searchAccountsController = TextEditingController();
  final TextEditingController _searchMyAccountsController = TextEditingController();

  final TextEditingController _fromCurrencyController = TextEditingController();
  final TextEditingController _toCurrencyController = TextEditingController();

  final TextEditingController _fromController = TextEditingController(text: "00.00");
  final TextEditingController _toController = TextEditingController(text: "00.00");

  final TextEditingController _descriptionController = TextEditingController();

  final List<AccountModel> _accounts = <AccountModel>[];

  final GlobalKey<State<StatefulWidget>> _accountsKey = GlobalKey<State<StatefulWidget>>();
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
    "TND2TND": 1,
    "USD2USD": 1,
    "EUR2EUR": 1,
    "GBP2GBP": 1,
  };

  Future<void> _withdraw() async {
    await Dio().post(
      "$ip/deposit",
      data: <String, dynamic>{
        "senderid": _accounts.firstWhere((AccountModel element) => element.accountHolderName == _searchAccountsController.text).accountHolderID,
        "receiverid": _accounts.firstWhere((AccountModel element) => element.accountHolderName == _searchMyAccountsController.text).accountHolderID,
        "currencyfrom": _fromCurrencyController.text,
        "currencyto": _toCurrencyController.text,
        "amount": _fromController.text.isEmpty ? 0.00 : _currencyExchange["${_fromCurrencyController.text}2${_toCurrencyController.text}"]! * double.parse(_fromController.text),
        "description": _descriptionController.text.trim(),
        "status": "COMPLETED",
      },
    );
  }

  @override
  void dispose() {
    _fromCurrencyController.dispose();
    _toCurrencyController.dispose();
    _fromController.dispose();
    _toController.dispose();
    _accountNumberController.dispose();
    _balanceController.dispose();
    _searchAccountsController.dispose();
    _searchMyAccountsController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<bool> _loadMyAccounts() async {
    _accounts.clear();
    final response = await Dio().get("$ip/getAccounts", data: <String, dynamic>{"userid": user!.userID});
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
                Text("Deposit to account", style: GoogleFonts.itim(fontSize: 25, fontWeight: FontWeight.w500, color: whiteColor)),
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
                                              .where((AccountModel element) => element.accountHolderID == user!.userID && element.accountHolderName.toLowerCase().startsWith(value.toLowerCase()))
                                              .map(
                                                (AccountModel e) => SearchFieldListItem<String>(
                                                  e.accountHolderName,
                                                  item: e.accountHolderName,
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Text(e.accountHolderName, style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: darkColor)),
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
                                                e.accountHolderName,
                                                item: e.accountHolderName,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text(e.accountHolderName.toUpperCase(), style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: darkColor)),
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
                                    key: _accountsKey,
                                    builder: (BuildContext context, void Function(void Function()) _) {
                                      return SearchField<String>(
                                        autoCorrect: false,
                                        onSearchTextChanged: (String value) {
                                          if (value.trim().length <= 1) {
                                            _accountsKey.currentState!.setState(() {});
                                          }
                                          return _accounts
                                              .where((AccountModel element) => element.accountHolderName.toLowerCase().startsWith(value.toLowerCase()))
                                              .map(
                                                (AccountModel e) => SearchFieldListItem<String>(
                                                  e.accountHolderName,
                                                  item: e.accountHolderName,
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Text(e.accountHolderName, style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: darkColor)),
                                                  ),
                                                ),
                                              )
                                              .toList();
                                        },
                                        controller: _searchAccountsController,
                                        searchStyle: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: greyColor),
                                        searchInputDecoration: InputDecoration(
                                          contentPadding: const EdgeInsets.all(20),
                                          focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: purpleColor, width: 2, style: BorderStyle.solid)),
                                          border: InputBorder.none,
                                          hintText: "WHICH ACOUNT?",
                                          hintStyle: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: greyColor),
                                          suffixIcon: _searchAccountsController.text.trim().isEmpty ? const SizedBox() : const Icon(FontAwesome.circle_check_solid, size: 15, color: greenColor),
                                        ),
                                        suggestions: _accounts
                                            .map(
                                              (AccountModel e) => SearchFieldListItem<String>(
                                                e.accountHolderName,
                                                item: e.accountHolderName,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text(e.accountHolderName.toUpperCase(), style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: darkColor)),
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
                                      suffixIcon: _fromCurrencyController.text.trim().isEmpty ? const SizedBox() : const Icon(FontAwesome.circle_check_solid, size: 15, color: greenColor),
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
                                      suffixIcon: _toCurrencyController.text.trim().isEmpty ? const SizedBox() : const Icon(FontAwesome.circle_check_solid, size: 15, color: greenColor),
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
                        text: "DEPOSITE",
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
