// ignore_for_file: use_build_context_synchronously

import 'package:animated_loading_border/animated_loading_border.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:frontend/models/user_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../utils/callbacks.dart';
import '../../../utils/helpers/password_strength.dart';
import '../../../utils/shared.dart';

class EditUser extends StatefulWidget {
  const EditUser({super.key, required this.user, required this.callback});
  final UserModel user;
  final void Function() callback;
  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _userIDController = TextEditingController();

  final GlobalKey<State<StatefulWidget>> _cardKey = GlobalKey<State<StatefulWidget>>();

  bool _submitButtonState = false;

  String _selectedRole = "CLIENT";

  final Map<String, List<dynamic>> _icons = const <String, List<dynamic>>{
    "CLIENT": <dynamic>[FontAwesome.person_circle_check_solid, greenColor],
    "ADMIN": <dynamic>[Icons.admin_panel_settings, blueColor],
    "AGENT": <dynamic>[Icons.support_agent, Colors.amber],
  };

  @override
  void initState() {
    _selectedRole = widget.user.userRole;
    _userIDController.text = widget.user.userID;
    _usernameController.text = widget.user.userName;
    _emailController.text = widget.user.userEmail;
    _passwordController.text = widget.user.userPassword;
    super.initState();
  }

  Future<void> _signUp() async {
    if (_usernameController.text.trim().isEmpty) {
      showToast(context, "Please enter the username", redColor);
    } else if (_emailController.text.trim().isEmpty) {
      showToast(context, "Please enter the e-mail", redColor);
    } else if (!_emailController.text.contains(RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$'))) {
      showToast(context, "Please enter a valid e-mail", redColor);
    } else if (_passwordController.text.trim().isEmpty) {
      showToast(context, "Please enter the password", redColor);
    } else if (_selectedRole == "Admin") {
      showToast(context, "You are not allowed to create an admin account", redColor);
    } else {
      _cardKey.currentState!.setState(() => _submitButtonState = true);
      try {
        await Dio().post(
          "$ip/updateUser",
          data: <String, dynamic>{
            "userid": widget.user.userID,
            "username": _usernameController.text,
            "password": _passwordController.text,
            "email": _emailController.text,
            "role": _selectedRole.toUpperCase(),
          },
        );
        showToast(context, "USER UPDATED SUCCESSFULLY", redColor);
        Navigator.pop(context);
        widget.callback();
      } catch (e) {
        _cardKey.currentState!.setState(() => _submitButtonState = false);
        showToast(context, e.toString(), redColor);
      }
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    _userIDController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: scaffoldColor,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                AnimatedLoadingBorder(
                  borderWidth: 4,
                  borderColor: purpleColor,
                  child: Container(
                    color: darkColor,
                    width: MediaQuery.sizeOf(context).width * .7,
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(FontAwesome.chevron_left_solid, size: 20, color: greyColor)),
                        const SizedBox(height: 10),
                        Container(width: MediaQuery.sizeOf(context).width, height: .3, color: greyColor, margin: const EdgeInsets.symmetric(vertical: 20)),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Flexible(child: Text("Username", style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: whiteColor))),
                            const SizedBox(width: 5),
                            Text("*", style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: redColor)),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(color: scaffoldColor, borderRadius: BorderRadius.circular(3)),
                          child: StatefulBuilder(
                            builder: (BuildContext context, void Function(void Function()) _) {
                              return TextField(
                                enableSuggestions: true,
                                onSubmitted: (String value) => _signUp(),
                                onChanged: (String value) => value.trim().length <= 1 ? _(() {}) : null,
                                controller: _usernameController,
                                style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: greyColor),
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(20),
                                  focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: purpleColor, width: 2, style: BorderStyle.solid)),
                                  border: InputBorder.none,
                                  hintText: 'alpha_zero',
                                  hintStyle: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: greyColor),
                                  prefixIcon: _usernameController.text.trim().isEmpty ? null : const Icon(FontAwesome.circle_check_solid, size: 15, color: greenColor),
                                ),
                                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'[ a-zA-Z]'))],
                                cursorColor: purpleColor,
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Flexible(child: Text("E-mail", style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: whiteColor))),
                            const SizedBox(width: 5),
                            Text("*", style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: redColor)),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(color: scaffoldColor, borderRadius: BorderRadius.circular(3)),
                          child: StatefulBuilder(
                            builder: (BuildContext context, void Function(void Function()) _) {
                              return TextField(
                                enableSuggestions: true,
                                onSubmitted: (String value) => _signUp(),
                                onChanged: (String value) => value.trim().length <= 1 ? _(() {}) : null,
                                controller: _emailController,
                                style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: greyColor),
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(20),
                                  focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: purpleColor, width: 2, style: BorderStyle.solid)),
                                  border: InputBorder.none,
                                  hintText: 'abc@xyz.com',
                                  hintStyle: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: greyColor),
                                  prefixIcon: _emailController.text.trim().isEmpty ? null : const Icon(FontAwesome.circle_check_solid, size: 15, color: greenColor),
                                ),
                                cursorColor: purpleColor,
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        PasswordStrength(controller: _passwordController),
                        const SizedBox(height: 20),
                        StatefulBuilder(
                          builder: (BuildContext context, void Function(void Function()) _) {
                            return AnimatedToggleSwitch<String>.rolling(
                              current: _selectedRole,
                              values: _icons.keys.toList(),
                              onChanged: (String item) => _(() => _selectedRole = item),
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
                        StatefulBuilder(
                          key: _cardKey,
                          builder: (BuildContext context, void Function(void Function()) _) {
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                IgnorePointer(
                                  ignoring: _submitButtonState,
                                  child: AnimatedButton(
                                    width: 200,
                                    height: 40,
                                    text: _submitButtonState ? "WAIT..." : 'UPDATE USER',
                                    selectedTextColor: darkColor,
                                    animatedOn: AnimatedOn.onHover,
                                    animationDuration: 500.ms,
                                    isReverse: true,
                                    selectedBackgroundColor: redColor,
                                    backgroundColor: purpleColor,
                                    transitionType: TransitionType.TOP_TO_BOTTOM,
                                    textStyle: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: whiteColor),
                                    onPress: () => _signUp(),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                AnimatedOpacity(opacity: _submitButtonState ? 1 : 0, duration: 300.ms, child: const Icon(FontAwesome.bookmark_solid, color: purpleColor, size: 35)),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
