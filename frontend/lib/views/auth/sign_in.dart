import 'package:animated_loading_border/animated_loading_border.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:frontend/models/user_model.dart';
import 'package:frontend/utils/shared.dart';
import 'package:frontend/views/auth/reset_password.dart';
import 'package:frontend/views/auth/sign_up.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../utils/callbacks.dart';
import '../users/client/holder.dart';
import '../users/admin/holder.dart';
import '../users/agent/holder.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<State<StatefulWidget>> _cardKey = GlobalKey<State<StatefulWidget>>();

  bool _submitButtonState = false;
  bool _passwordState = false;

  Future<void> _signIn() async {
    if (_usernameController.text.trim().isEmpty) {
      showToast(context, "Please enter the username", redColor);
    } else if (_passwordController.text.trim().isEmpty) {
      showToast(context, "Please enter the password", redColor);
    } else {
      _cardKey.currentState!.setState(() => _submitButtonState = true);
      try {
        final Response response = await Dio().post(
          "$ip/signUser",
          data: <String, dynamic>{
            "username": _usernameController.text,
            "password": _passwordController.text,
          },
        );
        if (response.data["data"] is Map<String, dynamic>) {
          user = UserModel.fromJson(response.data["data"]);
          // ignore: use_build_context_synchronously
          Navigator.pushAndRemoveUntil(
            // ignore: use_build_context_synchronously
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => user!.userRole == "ADMIN"
                    ? const AdminHolder()
                    : user!.userRole == "AGENT"
                        ? const AgentHolder()
                        : const ClientHolder()),
            (Route route) => false,
          );
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
    _usernameController.dispose();
    _passwordController.dispose();
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
                            Expanded(child: Text("WELCOME TO ONLINE BANKING SYSTEM", style: GoogleFonts.itim(fontSize: 22, fontWeight: FontWeight.w500, color: greyColor))),
                            const SizedBox(width: 10),
                            AnimatedButton(
                              width: 200,
                              height: 40,
                              text: 'CREATE ACCOUNT',
                              selectedTextColor: whiteColor,
                              animatedOn: AnimatedOn.onHover,
                              animationDuration: 500.ms,
                              isReverse: true,
                              selectedBackgroundColor: greyColor.withOpacity(.1),
                              backgroundColor: greenColor,
                              transitionType: TransitionType.TOP_TO_BOTTOM,
                              textStyle: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: whiteColor),
                              onPress: () => Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const SignUp())),
                            ),
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
                                onSubmitted: (String value) => _signIn(),
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
                                onSubmitted: (String value) => _signIn(),
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
                                    text: _submitButtonState ? "WAIT..." : 'SIGN-IN',
                                    selectedTextColor: darkColor,
                                    animatedOn: AnimatedOn.onHover,
                                    animationDuration: 500.ms,
                                    isReverse: true,
                                    selectedBackgroundColor: redColor,
                                    backgroundColor: purpleColor,
                                    transitionType: TransitionType.TOP_TO_BOTTOM,
                                    textStyle: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: whiteColor),
                                    onPress: () => _signIn(),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                AnimatedOpacity(opacity: _submitButtonState ? 1 : 0, duration: 300.ms, child: const Icon(FontAwesome.bookmark_solid, color: purpleColor, size: 35)),
                                const SizedBox(width: 10),
                                const Spacer(),
                                AnimatedButton(
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
                                  onPress: () => Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const ResetPassword())),
                                ),
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
