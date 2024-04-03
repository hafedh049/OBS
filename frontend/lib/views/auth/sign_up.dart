import 'package:animated_loading_border/animated_loading_border.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:frontend/utils/helpers/password_strength.dart';
import 'package:frontend/utils/shared.dart';
import 'package:frontend/views/home.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../utils/callbacks.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<State<StatefulWidget>> _cardKey = GlobalKey<State<StatefulWidget>>();

  bool _submitButtonState = false;

  String _selectedRole = "Client";

  final Map<String, List<dynamic>> _icons = const <String, List<dynamic>>{
    "Client": <dynamic>[FontAwesome.person_circle_check_solid, greenColor],
    "Admin": <dynamic>[Icons.admin_panel_settings, blueColor],
    "Agent": <dynamic>[Icons.support_agent, Colors.amber],
  };

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
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context) => const Home()), (Route route) => false);
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
                        Row(
                          children: <Widget>[
                            IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(FontAwesome.chevron_left_solid, size: 20, color: greyColor)),
                            Text("SIGN UP", style: GoogleFonts.itim(fontSize: 22, fontWeight: FontWeight.w500, color: greyColor)),
                          ],
                        ),
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
                                    text: _submitButtonState ? "WAIT..." : 'CREATE ACCOUNT',
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
