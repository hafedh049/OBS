import 'package:animated_loading_border/animated_loading_border.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:lottie/lottie.dart';

import '../../../utils/callbacks.dart';
import '../../../utils/shared.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<State<StatefulWidget>> _cardKey = GlobalKey<State<StatefulWidget>>();

  final PageController _pagesController = PageController();

  bool _submitButtonState = false;
  bool _passwordState = false;

  Future<void> _resetPassword() async {
    if (_emailController.text.trim().isEmpty) {
      showToast(context, "Please enter the e-mail", redColor);
    } else if (_passwordController.text.trim().isEmpty) {
      showToast(context, "Please enter the password", redColor);
    } else {
      _cardKey.currentState!.setState(() => _submitButtonState = true);
      try {
        final Response response = await Dio().post(
          "$ip/resetPassword",
          data: <String, dynamic>{
            "email": _emailController.text,
            "password": _passwordController.text,
          },
        );
        if (response.data["data"] == "Password changed successfully") {
          _pagesController.animateToPage(1, duration: 300.ms, curve: Curves.linear);
        } else {
          _cardKey.currentState!.setState(() => _submitButtonState = false);
          // ignore: use_build_context_synchronously
          showToast(context, response.data["data"], redColor);
        }
      } catch (e) {
        _cardKey.currentState!.setState(() => _submitButtonState = false);
        // ignore: use_build_context_synchronously
        showToast(context, e.toString(), redColor);
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _pagesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: scaffoldColor,
        body: Center(
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
                  height: MediaQuery.sizeOf(context).height * .7,
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(FontAwesome.chevron_left_solid, size: 20, color: greyColor)),
                      Expanded(
                        child: PageView(
                          controller: _pagesController,
                          physics: const NeverScrollableScrollPhysics(),
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text("DID YOU FORGET YOUR PASSWORD ?", style: GoogleFonts.itim(fontSize: 22, fontWeight: FontWeight.w500, color: greyColor)),
                                const SizedBox(height: 20),
                                Container(width: MediaQuery.sizeOf(context).width, height: .3, color: greyColor, margin: const EdgeInsets.symmetric(vertical: 20)),
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
                                        onSubmitted: (String value) => _resetPassword(),
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
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Flexible(child: Text("Password", style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: whiteColor))),
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
                                        obscureText: !_passwordState,
                                        onSubmitted: (String value) => _resetPassword(),
                                        onChanged: (String value) => value.trim().length <= 1 ? _(() {}) : null,
                                        controller: _passwordController,
                                        style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: greyColor),
                                        decoration: InputDecoration(
                                          contentPadding: const EdgeInsets.all(20),
                                          focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: purpleColor, width: 2, style: BorderStyle.solid)),
                                          border: InputBorder.none,
                                          hintText: '**********',
                                          hintStyle: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: greyColor),
                                          prefixIcon: _passwordController.text.trim().isEmpty ? null : const Icon(FontAwesome.circle_check_solid, size: 15, color: greenColor),
                                          suffixIcon: IconButton(onPressed: () => _(() => _passwordState = !_passwordState), icon: Icon(_passwordState ? FontAwesome.eye_solid : FontAwesome.eye_slash_solid, size: 15, color: purpleColor)),
                                        ),
                                        cursorColor: purpleColor,
                                      );
                                    },
                                  ),
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
                                            width: 150,
                                            height: 40,
                                            text: 'RESET PASSWORD',
                                            selectedTextColor: darkColor,
                                            animatedOn: AnimatedOn.onHover,
                                            animationDuration: 500.ms,
                                            isReverse: true,
                                            selectedBackgroundColor: redColor,
                                            backgroundColor: purpleColor,
                                            transitionType: TransitionType.TOP_TO_BOTTOM,
                                            textStyle: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: whiteColor),
                                            onPress: () => _resetPassword(),
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
                            Column(
                              children: <Widget>[
                                LottieBuilder.asset("assets/lotties/email.json", reverse: true),
                                Text("Your password has been changed", style: GoogleFonts.itim(fontSize: 20, fontWeight: FontWeight.w500, color: whiteColor)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
