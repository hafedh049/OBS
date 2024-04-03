import 'package:animated_line_through/animated_line_through.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';

import '../shared.dart';

class PasswordStrength extends StatefulWidget {
  const PasswordStrength({super.key, required this.controller});
  final TextEditingController controller;
  @override
  State<PasswordStrength> createState() => _PasswordStrengthState();
}

class _PasswordStrengthState extends State<PasswordStrength> {
  bool _passwordState = false;
  bool _containsAlpha = false;
  bool _containsNum = false;
  bool _checkLength = false;

  int _compute() {
    return (_containsAlpha ? 1 : 0) + (_containsNum ? 1 : 0) + (_checkLength ? 1 : 0);
  }

  void _check(String value) {
    if (value.contains(RegExp(r'[a-zA-Z]'))) {
      _containsAlpha = true;
    } else {
      _containsAlpha = false;
    }
    if (value.contains(RegExp(r'[0-9]'))) {
      _containsNum = true;
    } else {
      _containsNum = false;
    }
    if (value.length >= 8 && _containsAlpha && _containsNum) {
      _checkLength = true;
    } else {
      _checkLength = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Flexible(child: Text("Password", style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: whiteColor))),
            const SizedBox(width: 5),
            Text("*", style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: redColor)),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: <Widget>[
            if (_containsAlpha) ...<Widget>[
              const Icon(FontAwesome.circle_check, color: greenColor, size: 15).animate().fade(duration: 500.ms),
              const SizedBox(width: 10),
            ],
            AnimatedLineThrough(
              isCrossed: _containsAlpha,
              duration: 500.ms,
              color: greenColor,
              child: Text("Contains alphabetics : [a-zA-Z]*", style: GoogleFonts.itim(fontSize: 14, fontWeight: FontWeight.w500, color: whiteColor)),
            )
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: <Widget>[
            if (_containsNum) ...<Widget>[
              const Icon(FontAwesome.circle_check, color: greenColor, size: 15).animate().fade(duration: 500.ms),
              const SizedBox(width: 10),
            ],
            AnimatedLineThrough(
              isCrossed: _containsNum,
              duration: 500.ms,
              color: greenColor,
              child: Text("Contains numerics : [0-9]*", style: GoogleFonts.itim(fontSize: 14, fontWeight: FontWeight.w500, color: whiteColor)),
            )
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: <Widget>[
            if (_checkLength) ...<Widget>[
              const Icon(FontAwesome.circle_check, color: greenColor, size: 15).animate().fade(duration: 500.ms),
              const SizedBox(width: 10),
            ],
            AnimatedLineThrough(
              isCrossed: _checkLength,
              duration: 500.ms,
              color: greenColor,
              child: Text("More than 8 characters", style: GoogleFonts.itim(fontSize: 14, fontWeight: FontWeight.w500, color: whiteColor)),
            )
          ],
        ),
        const SizedBox(height: 20),
        Container(
          decoration: BoxDecoration(color: scaffoldColor, borderRadius: BorderRadius.circular(3)),
          child: TextField(
            obscureText: !_passwordState,
            onChanged: (String value) {
              _check(value);
              setState(() {});
            },
            controller: widget.controller,
            style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: greyColor),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(20),
              focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: purpleColor, width: 2, style: BorderStyle.solid)),
              border: InputBorder.none,
              hintText: '**********',
              hintStyle: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: greyColor),
              prefixIcon: widget.controller.text.trim().isEmpty ? null : const Icon(FontAwesome.circle_check_solid, size: 15, color: greenColor),
              suffixIcon: IconButton(onPressed: () => setState(() => _passwordState = !_passwordState), icon: Icon(_passwordState ? FontAwesome.eye_solid : FontAwesome.eye_slash_solid, size: 15, color: purpleColor)),
            ),
            inputFormatters: <FilteringTextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'[0-9A-Za-z]'))],
            cursorColor: purpleColor,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: <Widget>[
            for (int index = 0; index < 3; index += 1)
              Expanded(
                child: AnimatedContainer(
                  duration: 500.ms,
                  height: 5,
                  margin: index == 1 ? const EdgeInsets.symmetric(horizontal: 10) : null,
                  decoration: BoxDecoration(color: index < _compute() ? greenColor : greyColor.withOpacity(.1), borderRadius: BorderRadius.circular(5), border: Border.all(color: greyColor.withOpacity(.3), width: 2)),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
