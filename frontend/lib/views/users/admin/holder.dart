import 'package:flutter/material.dart';
import 'package:frontend/views/users/admin/side_bar.dart';

import '../../../utils/shared.dart';

class AdminHolder extends StatefulWidget {
  const AdminHolder({super.key});

  @override
  State<AdminHolder> createState() => _AdminHolderState();
}

class _AdminHolderState extends State<AdminHolder> {
  @override
  void initState() {
    adminPageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    adminPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Row(
          children: <Widget>[
            const AdminSideBar(),
            const SizedBox(width: 20),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: darkColor),
                child: PageView.builder(
                  controller: adminPageController,
                  itemBuilder: (BuildContext context, int index) => adminScreens[index],
                  itemCount: adminScreens.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
