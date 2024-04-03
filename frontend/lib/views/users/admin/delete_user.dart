import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:frontend/models/user_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../utils/callbacks.dart';
import '../../../utils/shared.dart';

class DeleteUser extends StatefulWidget {
  const DeleteUser({super.key, required this.userID, required this.users, required this.callback});
  final String userID;
  final List<UserModel> users;
  final void Function() callback;
  @override
  State<DeleteUser> createState() => _DeleteUserState();
}

class _DeleteUserState extends State<DeleteUser> {
  final String _passphrase = "admin";
  bool _passphraseState = false;
  final TextEditingController _confirmController = TextEditingController();

  void _validate() async {
    if (_confirmController.text != _passphrase) {
      showToast(context, "Enter the confirmation passphrase", redColor);
    } else {
      widget.users.removeWhere((UserModel element) => element.userID == widget.userID);
      widget.callback();
      showToast(context, "User deleted", greenColor);
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Are you sure to delete '${widget.users.firstWhere((UserModel element) => element.userID == widget.userID).userName}'",
          style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: whiteColor),
        ),
        const SizedBox(height: 20),
        Container(
          decoration: BoxDecoration(color: scaffoldColor, borderRadius: BorderRadius.circular(3)),
          child: StatefulBuilder(
            builder: (BuildContext context, void Function(void Function()) _) {
              return TextField(
                obscureText: !_passphraseState,
                onSubmitted: (String value) => _validate(),
                onChanged: (String value) => value.trim().length <= 1 ? _(() {}) : null,
                controller: _confirmController,
                style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: greyColor),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(20),
                  focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: purpleColor, width: 2, style: BorderStyle.solid)),
                  border: InputBorder.none,
                  hintText: '**********',
                  hintStyle: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: greyColor),
                  prefixIcon: _confirmController.text.trim().isEmpty ? null : const Icon(FontAwesome.circle_check_solid, size: 15, color: greenColor),
                  suffixIcon: IconButton(onPressed: () => _(() => _passphraseState = !_passphraseState), icon: Icon(_passphraseState ? FontAwesome.eye_solid : FontAwesome.eye_slash_solid, size: 15, color: purpleColor)),
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
            const Spacer(),
            AnimatedButton(
              width: 100,
              height: 30,
              text: 'DELETE',
              selectedTextColor: whiteColor,
              animatedOn: AnimatedOn.onHover,
              animationDuration: 500.ms,
              isReverse: true,
              selectedBackgroundColor: darkColor,
              backgroundColor: greenColor,
              transitionType: TransitionType.TOP_TO_BOTTOM,
              textStyle: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: whiteColor),
              onPress: () => _validate(),
            ),
            const SizedBox(width: 10),
            AnimatedButton(
              width: 100,
              height: 30,
              text: 'CANCEL',
              selectedTextColor: whiteColor,
              animatedOn: AnimatedOn.onHover,
              animationDuration: 500.ms,
              isReverse: true,
              selectedBackgroundColor: darkColor,
              backgroundColor: greenColor,
              transitionType: TransitionType.TOP_TO_BOTTOM,
              textStyle: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: whiteColor),
              onPress: () => Navigator.pop(context),
            ),
          ],
        ),
      ],
    );
  }
}
