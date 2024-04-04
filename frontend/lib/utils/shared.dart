import 'package:flutter/material.dart';
import 'package:frontend/models/user_model.dart';
import 'package:frontend/views/users/admin/list_banks.dart';
import 'package:frontend/views/users/admin/list_users.dart';
import 'package:frontend/views/users/client/accounts/accounts_list.dart';
import 'package:sidebarx/sidebarx.dart';

const Color scaffoldColor = Color.fromARGB(255, 32, 35, 38);
const Color purpleColor = Color.fromARGB(255, 124, 120, 239);
const Color darkColor = Color.fromARGB(255, 20, 20, 20);
const Color whiteColor = Color.fromARGB(255, 242, 245, 249);
const Color greyColor = Color.fromARGB(255, 166, 170, 176);
const Color greenColor = Colors.greenAccent;
const Color blueColor = Colors.blueAccent;
const Color redColor = Colors.red;
const Color transparentColor = Colors.transparent;

const String ip = "http://127.0.0.1:8000";

UserModel? user;

int adminIndex = 0;
SidebarXController adminSideBarController = SidebarXController(selectedIndex: adminIndex);
PageController adminPageController = PageController();

int agentIndex = 0;
SidebarXController agentSideBarController = SidebarXController(selectedIndex: agentIndex);
PageController agentPageController = PageController();

final List<Widget> adminScreens = <Widget>[const BanksList(), const UsersList()];

final List<Widget> agentScreens = <Widget>[const AccountsList()];
