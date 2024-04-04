import 'package:flutter/material.dart';
import 'package:frontend/utils/shared.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:sidebarx/sidebarx.dart';

class AgentSideBar extends StatefulWidget {
  const AgentSideBar({super.key});

  @override
  State<AgentSideBar> createState() => _AgentSideBarState();
}

class _AgentSideBarState extends State<AgentSideBar> {
  @override
  void initState() {
    agentSideBarController = SidebarXController(selectedIndex: agentIndex);
    super.initState();
  }

  @override
  void dispose() {
    agentSideBarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SidebarX(
      showToggleButton: true,
      controller: agentSideBarController,
      extendedTheme: SidebarXTheme(
        width: 200,
        selectedTextStyle: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: purpleColor),
        textStyle: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: whiteColor),
        hoverTextStyle: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: purpleColor),
        selectedItemTextPadding: const EdgeInsets.only(left: 16),
        itemTextPadding: const EdgeInsets.only(left: 16),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: darkColor),
        padding: const EdgeInsets.all(8),
        iconTheme: const IconThemeData(color: whiteColor, size: 25),
      ),
      theme: SidebarXTheme(
        selectedTextStyle: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: purpleColor),
        textStyle: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: whiteColor),
        hoverTextStyle: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: purpleColor),
        selectedItemTextPadding: const EdgeInsets.only(left: 16),
        itemTextPadding: const EdgeInsets.only(left: 16),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: darkColor),
        padding: const EdgeInsets.all(8),
        iconTheme: const IconThemeData(color: whiteColor, size: 25),
      ),
      items: <SidebarXItem>[
        SidebarXItem(
          iconWidget: Icon(FontAwesome.robot_solid, size: 25, color: agentIndex == 0 ? purpleColor : blueColor),
          label: "Accounts List",
          onTap: () {
            agentIndex = 0;
            setState(() {});
            adminPageController.jumpToPage(agentIndex);
          },
        ),
      ],
    );
  }
}
