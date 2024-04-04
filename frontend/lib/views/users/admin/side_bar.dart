import 'package:flutter/material.dart';
import 'package:frontend/utils/shared.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:sidebarx/sidebarx.dart';

class AdminSideBar extends StatefulWidget {
  const AdminSideBar({super.key});

  @override
  State<AdminSideBar> createState() => _AdminSideBarState();
}

class _AdminSideBarState extends State<AdminSideBar> {
  @override
  void initState() {
    adminSideBarController = SidebarXController(selectedIndex: agentIndex);
    super.initState();
  }

  @override
  void dispose() {
    adminSideBarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SidebarX(
      showToggleButton: true,
      controller: adminSideBarController,
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
          iconWidget: Icon(Bootstrap.bank, size: 25, color: adminIndex == 0 ? purpleColor : blueColor),
          label: "Banks List",
          onTap: () {
            adminIndex = 0;
            setState(() {});
            adminPageController.jumpToPage(adminIndex);
          },
        ),
        SidebarXItem(
          iconWidget: Icon(FontAwesome.user, size: 25, color: adminIndex == 1 ? purpleColor : blueColor),
          label: "Users List",
          onTap: () {
            adminIndex = 1;
            setState(() {});
            adminPageController.jumpToPage(adminIndex);
          },
        ),
      ],
    );
  }
}
