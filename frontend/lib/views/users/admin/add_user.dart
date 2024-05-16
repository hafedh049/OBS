// ignore_for_file: use_build_context_synchronously

import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:frontend/models/bank_model.dart';
import 'package:frontend/utils/helpers/password_strength.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:searchfield/searchfield.dart';
import 'package:uuid/v8.dart';

import '../../../utils/callbacks.dart';
import '../../../utils/shared.dart';
import '../../../models/user_model.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key, required this.callback, required this.users});
  final List<UserModel> users;
  final void Function() callback;
  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _banksController = TextEditingController();

  final GlobalKey<State<StatefulWidget>> _banksKey = GlobalKey<State<StatefulWidget>>();

  List<BankModel> _banks = List<BankModel>.empty();

  String _role = "Client";

  final Map<String, List<dynamic>> _icons = const <String, List<dynamic>>{
    "Client": <dynamic>[FontAwesome.person_circle_check_solid, greenColor],
    "Agent": <dynamic>[Icons.support_agent, Colors.amber],
  };

  Future<void> _addUser() async {
    if (_usernameController.text.trim().isEmpty) {
      showToast(context, "Enter a valid username", redColor);
    } else if (_emailController.text.trim().isEmpty) {
      showToast(context, "Enter a valid user e-mail", redColor);
    } else if (_role == "Agent" && _banksController.text.trim().isEmpty) {
      showToast(context, "Select a bank ID", redColor);
    } else if (_passwordController.text.trim().isEmpty) {
      showToast(context, "Enter a valid user password", redColor);
    } else {
      String userID = const UuidV8().generate();

      final Map<String, dynamic> userItem = <String, dynamic>{
        'userid': userID,
        'username': _usernameController.text.trim(),
        'email': _emailController.text.trim(),
        'password': _passwordController.text.trim(),
        'role': _role.toUpperCase(),
        'bankid': _role != "Agent" ? null : _banksController.text,
      };
      await Dio().post("$ip/addUser", data: userItem);

      widget.users.add(UserModel.fromJson(userItem));
      widget.callback();
      showToast(context, "User added successfully", greenColor);
      Navigator.pop(context);
    }
  }

  Future<List<BankModel>> _loadBanks() async {
    try {
      final Response response = await Dio().post("$ip/getAllBanks");
      return response.data["data"].map((e) => BankModel.fromJson(e)).toList().cast<BankModel>();
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
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
                onSubmitted: (String value) => _addUser(),
                controller: _usernameController,
                style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: greyColor),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(20),
                  focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: purpleColor, width: 2, style: BorderStyle.solid)),
                  border: InputBorder.none,
                  hintText: 'USERNAME',
                  hintStyle: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: greyColor),
                  prefixIcon: _usernameController.text.trim().isEmpty ? null : const Icon(FontAwesome.circle_check_solid, size: 15, color: greenColor),
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
                onSubmitted: (String value) => _addUser(),
                controller: _emailController,
                style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: greyColor),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(20),
                  focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: purpleColor, width: 2, style: BorderStyle.solid)),
                  border: InputBorder.none,
                  hintText: 'USER E-MAIL',
                  hintStyle: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: greyColor),
                  prefixIcon: _emailController.text.trim().isEmpty ? null : const Icon(FontAwesome.circle_check_solid, size: 15, color: greenColor),
                ),
                cursorColor: purpleColor,
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        FutureBuilder<List<BankModel>>(
          future: _loadBanks(),
          builder: (BuildContext context, AsyncSnapshot<List<BankModel>> snapshot) {
            if (snapshot.hasData) {
              return StatefulBuilder(
                key: _banksKey,
                builder: (BuildContext context, void Function(void Function()) _) {
                  _banks = snapshot.data!;
                  return Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          color: scaffoldColor,
                          child: SearchField<String>(
                            autoCorrect: false,
                            readOnly: true,
                            onSearchTextChanged: (String value) {
                              if (value.trim().length <= 1) {
                                _banksKey.currentState!.setState(() {});
                              }
                              return _banks
                                  .where((BankModel element) => element.bankID.startsWith(value))
                                  .map(
                                    (BankModel e) => SearchFieldListItem<String>(
                                      e.bankID,
                                      item: e.bankID,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(e.bankName, style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: darkColor)),
                                      ),
                                    ),
                                  )
                                  .toList();
                            },
                            controller: _banksController,
                            searchStyle: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: greyColor),
                            searchInputDecoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(20),
                              focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: purpleColor, width: 2, style: BorderStyle.solid)),
                              border: InputBorder.none,
                              hintText: "WHICH BANK?",
                              hintStyle: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: greyColor),
                              suffixIcon: _banksController.text.trim().isEmpty ? const SizedBox() : const Icon(FontAwesome.circle_check_solid, size: 15, color: greenColor),
                            ),
                            suggestions: _banks
                                .map(
                                  (BankModel e) => SearchFieldListItem<String>(
                                    e.bankID,
                                    item: e.bankID,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(e.bankName, style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: darkColor)),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            } else {
              return const SizedBox();
            }
          },
        ),
        const SizedBox(height: 20),
        PasswordStrength(controller: _passwordController),
        const SizedBox(height: 20),
        StatefulBuilder(
          builder: (BuildContext context, void Function(void Function()) _) {
            return AnimatedToggleSwitch<String>.rolling(
              current: _role,
              values: _icons.keys.toList(),
              onChanged: (String item) => _(() => _role = item),
              fittingMode: FittingMode.preventHorizontalOverlapping,
              indicatorSize: const Size.fromWidth(85),
              iconBuilder: (String value, bool foreground) => Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(_icons[value]!.first, size: 25, color: _icons[value]!.last),
                  const SizedBox(width: 10),
                  Text(value, style: GoogleFonts.itim(fontSize: 14, fontWeight: FontWeight.w500, color: _icons[value]!.last)),
                ],
              ),
              style: ToggleStyle(
                backgroundColor: scaffoldColor,
                borderRadius: BorderRadius.circular(10),
                indicatorColor: whiteColor.withOpacity(.3),
              ),
            );
          },
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Spacer(),
            AnimatedButton(
              width: 120,
              height: 40,
              text: 'ADD BANK',
              selectedTextColor: whiteColor,
              animatedOn: AnimatedOn.onHover,
              animationDuration: 500.ms,
              isReverse: true,
              selectedBackgroundColor: darkColor,
              backgroundColor: greenColor,
              transitionType: TransitionType.TOP_TO_BOTTOM,
              textStyle: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: whiteColor),
              onPress: () async => await _addUser(),
            ),
          ],
        ),
      ],
    );
  }
}
