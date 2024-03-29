import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:google_fonts/google_fonts.dart';

import '../shared.dart';

class ScreenContainer extends StatefulWidget {
  const ScreenContainer({super.key, required this.item});
  final Map<String, dynamic> item;

  @override
  State<ScreenContainer> createState() => _ScreenContainerState();
}

class _ScreenContainerState extends State<ScreenContainer> {
  bool _state = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: transparentColor,
      highlightColor: transparentColor,
      focusColor: transparentColor,
      onHover: (bool value) => setState(() => _state = value),
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => widget.item["widget"])),
      child: Container(
        width: 400,
        height: 200,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: darkColor, borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(child: Text(widget.item["title"], style: GoogleFonts.itim(fontSize: 22, fontWeight: FontWeight.w500, color: whiteColor))),
                const SizedBox(width: 20),
                AnimatedContainer(
                  width: 40,
                  height: 40,
                  duration: 500.ms,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage("assets/images/${_state ? 'logo' : 'flutter'}.png")),
                    shape: BoxShape.circle,
                    border: Border.all(width: 2, color: _state ? redColor : greenColor),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            AnimatedContainer(duration: 500.ms, width: _state ? 400 - 16 * 2 : 0, height: .5, color: greyColor),
            const SizedBox(height: 20),
            AnimatedOpacity(
              duration: 500.ms,
              opacity: _state ? 1 : 0,
              child: AnimatedButton(
                width: 150,
                height: 40,
                text: "Go to >",
                selectedTextColor: darkColor,
                animatedOn: AnimatedOn.onHover,
                animationDuration: 500.ms,
                isReverse: true,
                selectedBackgroundColor: greenColor,
                backgroundColor: purpleColor,
                transitionType: TransitionType.TOP_TO_BOTTOM,
                textStyle: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: whiteColor),
                onPress: () => !_state ? null : Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => widget.item["widget"])),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
