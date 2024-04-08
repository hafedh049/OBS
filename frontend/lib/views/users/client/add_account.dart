import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_tilt/flutter_tilt.dart';
import 'package:frontend/views/users/client/current_form.dart';
import 'package:frontend/views/users/client/savings_form.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../utils/shared.dart';

class AddAccount extends StatefulWidget {
  const AddAccount({super.key});

  @override
  State<AddAccount> createState() => _AddAccountState();
}

class _AddAccountState extends State<AddAccount> {
  final List<Map<String, dynamic>> _screens = <Map<String, dynamic>>[
    <String, dynamic>{
      "title": "ADD SAVINGS ACCOUNT",
      "widget": const SavingsForm(),
      "state": false,
      "image": "savings",
    },
    <String, dynamic>{
      "title": "ADD CURRENT ACCOUNT",
      "widget": const CurrentForm(),
      "state": false,
      "image": "current",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(FontAwesome.chevron_left_solid, size: 15, color: whiteColor)),
                Text("Choose an account type", style: GoogleFonts.itim(fontSize: 25, fontWeight: FontWeight.w500, color: whiteColor)),
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
                child: StatefulBuilder(builder: (BuildContext context, void Function(void Function()) _) {
                  return Wrap(
                    alignment: WrapAlignment.center,
                    runAlignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    runSpacing: 20,
                    spacing: 20,
                    children: <Widget>[
                      for (final Map<String, dynamic> item in _screens) ...<Widget>[
                        InkWell(
                          splashColor: transparentColor,
                          highlightColor: transparentColor,
                          hoverColor: transparentColor,
                          onHover: (bool value) => _(() => item["state"] = value),
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => item["widget"])),
                          child: Tilt(
                            borderRadius: BorderRadius.circular(15),
                            lightConfig: const LightConfig(color: transparentColor),
                            child: AnimatedScale(
                              duration: 300.ms,
                              scale: item["state"] ? 1.1 : 1,
                              child: AnimatedContainer(
                                duration: 300.ms,
                                alignment: Alignment.center,
                                width: 300,
                                height: 200,
                                decoration: BoxDecoration(
                                  color: item["state"] ? whiteColor.withOpacity(.6) : darkColor,
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(width: item["state"] ? 1.5 : 0, color: purpleColor),
                                  image: DecorationImage(image: AssetImage("assets/images/${item['image']}.jpg"), fit: BoxFit.cover),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: purpleColor.withOpacity(.9)),
                                  child: Text(item["title"], style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: darkColor)),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ],
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
