import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:frontend/views/auth/sign_in.dart';
import 'package:frontend/models/user_model.dart';
import 'package:frontend/views/users/admin/add_user.dart';
import 'package:frontend/views/users/admin/delete_user.dart';
import 'package:frontend/views/users/admin/edit_user.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:lottie/lottie.dart';

import '../../../utils/callbacks.dart';
import '../../../utils/helpers/errored.dart';
import '../../../utils/helpers/loading.dart';
import '../../../utils/shared.dart';

class UsersList extends StatefulWidget {
  const UsersList({super.key});

  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  final GlobalKey<State> _usersKey = GlobalKey<State>();

  List<UserModel> _users = <UserModel>[];

  Future<List<UserModel>> _loadUsers() async {
    try {
      final Response response = await Dio().get("$ip/getAllUsers");
      final List<UserModel> users = <UserModel>[];
      for (final e in response.data["data"]) {
        users.add(UserModel.fromJson(e));
      }
      return users;
    } catch (e) {
      return Future.error(e);
    }
  }

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
                Text("Users List", style: GoogleFonts.itim(fontSize: 22, fontWeight: FontWeight.w500, color: greyColor)),
                const Spacer(),
                AnimatedButton(
                  width: 100,
                  height: 35,
                  text: 'ADD',
                  selectedTextColor: darkColor,
                  animatedOn: AnimatedOn.onHover,
                  animationDuration: 500.ms,
                  isReverse: true,
                  selectedBackgroundColor: redColor,
                  backgroundColor: purpleColor,
                  transitionType: TransitionType.TOP_TO_BOTTOM,
                  textStyle: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: whiteColor),
                  onPress: () => showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      backgroundColor: scaffoldColor,
                      contentPadding: const EdgeInsets.all(16),
                      content: SizedBox(width: MediaQuery.sizeOf(context).width * .7, child: AddUser(users: _users, callback: () => _usersKey.currentState!.setState(() {}))),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                AnimatedButton(
                  width: 100,
                  height: 35,
                  text: 'SIGN-OUT',
                  selectedTextColor: darkColor,
                  animatedOn: AnimatedOn.onHover,
                  animationDuration: 500.ms,
                  isReverse: true,
                  selectedBackgroundColor: redColor,
                  backgroundColor: purpleColor,
                  transitionType: TransitionType.TOP_TO_BOTTOM,
                  textStyle: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: whiteColor),
                  onPress: () async {
                    showToast(context, "Salamou alaykom", redColor);
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context) => const SignIn()), (Route route) => false);
                  },
                ),
              ],
            ),
            Container(width: MediaQuery.sizeOf(context).width, height: .3, color: greyColor, margin: const EdgeInsets.symmetric(vertical: 20)),
            Expanded(
              child: Center(
                child: StatefulBuilder(
                  key: _usersKey,
                  builder: (BuildContext context, void Function(void Function()) snapshot) {
                    return FutureBuilder<List<UserModel>>(
                      future: _loadUsers(),
                      builder: (BuildContext context, AsyncSnapshot<List<UserModel>> snapshot) {
                        if (snapshot.hasData) {
                          _users = snapshot.data!;
                          return _users.isEmpty
                              ? Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    LottieBuilder.asset("assets/lotties/empty.json", reverse: true),
                                    Text("No users yet.", style: GoogleFonts.itim(fontSize: 18, fontWeight: FontWeight.w500, color: greyColor)),
                                  ],
                                )
                              : ListView.separated(
                                  itemBuilder: (BuildContext context, int index) => InkWell(
                                    splashColor: transparentColor,
                                    hoverColor: transparentColor,
                                    highlightColor: transparentColor,
                                    onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) => EditUser(
                                          user: _users[index],
                                          callback: () => _usersKey.currentState!.setState(() {}),
                                        ),
                                      ),
                                    ),
                                    child: Container(
                                      width: 300,
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: darkColor),
                                      child: Stack(
                                        alignment: Alignment.topRight,
                                        children: <Widget>[
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Row(
                                                children: <Widget>[
                                                  Text("User ID", style: GoogleFonts.itim(fontSize: 18, fontWeight: FontWeight.w500, color: greyColor)),
                                                  const SizedBox(width: 10),
                                                  Text(_users[index].userID, style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: blueColor)),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              Row(
                                                children: <Widget>[
                                                  Text("Username", style: GoogleFonts.itim(fontSize: 18, fontWeight: FontWeight.w500, color: greyColor)),
                                                  const SizedBox(width: 10),
                                                  Text(_users[index].userName, style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: greenColor)),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              Row(
                                                children: <Widget>[
                                                  Text("E-mail", style: GoogleFonts.itim(fontSize: 18, fontWeight: FontWeight.w500, color: greyColor)),
                                                  const SizedBox(width: 10),
                                                  Text(_users[index].userEmail, style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: blueColor)),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              Row(
                                                children: <Widget>[
                                                  Text("Role", style: GoogleFonts.itim(fontSize: 18, fontWeight: FontWeight.w500, color: greyColor)),
                                                  const SizedBox(width: 10),
                                                  Container(
                                                    padding: const EdgeInsets.all(8),
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(5),
                                                      color: _users[index].userRole == "ADMIN"
                                                          ? greenColor
                                                          : _users[index].userRole == "AGENT"
                                                              ? redColor
                                                              : blueColor,
                                                    ),
                                                    child: Text(_users[index].userRole, style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: darkColor)),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          IconButton(
                                            onPressed: () => showDialog(
                                              context: context,
                                              builder: (BuildContext context) => AlertDialog(
                                                backgroundColor: scaffoldColor,
                                                content: SizedBox(
                                                  width: MediaQuery.sizeOf(context).width * .7,
                                                  child: DeleteUser(userID: _users[index].userID, users: _users, callback: () => _usersKey.currentState!.setState(() {})),
                                                ),
                                              ),
                                            ),
                                            icon: const Icon(FontAwesome.delete_left_solid, size: 25, color: purpleColor),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 20),
                                  itemCount: _users.length,
                                );
                        } else if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Loading();
                        }
                        return Errored(error: snapshot.error.toString());
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
