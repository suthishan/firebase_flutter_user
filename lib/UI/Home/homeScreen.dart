import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart' as auth;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_task/UI/addNotes/addscreen.dart';
import 'package:flutter_firebase_task/UI/auth/authScreen.dart';
import 'package:flutter_firebase_task/UI/widgets/item_list.dart';
import 'package:flutter_firebase_task/constants/AppConstants.dart';
import 'package:flutter_firebase_task/main.dart';
import 'package:flutter_firebase_task/model/user.dart';

import 'package:flutter_firebase_task/services/helper.dart';

class HomeScreen extends StatefulWidget {
  final User user;

  HomeScreen({Key? key, required this.user}) : super(key: key);

  @override
  State createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  late User user;

  @override
  void initState() {
    super.initState();
    user = widget.user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(
                'Drawer Header',
                style: TextStyle(color: Colors.white),
              ),
              decoration: BoxDecoration(
                color: Color(COLOR_PRIMARY),
              ),
            ),
            ListTile(
              title: Text(
                'Logout',
                style: TextStyle(color: Colors.black),
              ),
              leading: Transform.rotate(
                  angle: pi / 1,
                  child: Icon(Icons.exit_to_app, color: Colors.black)),
              onTap: () async {
                await auth.FirebaseAuth.instance.signOut();
                MyAppState.currentUser = null;
                pushAndRemoveUntil(context, AuthScreen(), false);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(
          'Home',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddScreen(),
            ),
          );
        },
        backgroundColor: Color(COLOR_PRIMARY),
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 32,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 32, right: 32, top: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                      height: 100,
                      width: 100,
                      child: ClipOval(
                        child: Image.asset(
                          'assets/profile.png',
                          fit: BoxFit.cover,
                        ),
                      )),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          user.name,
                          style: TextStyle(
                              color: Colors.grey[800],
                              fontFamily: "Roboto",
                              fontSize: 36,
                              fontWeight: FontWeight.w700),
                        ),
                        Text(
                          user.email,
                          style: TextStyle(
                              color: Colors.grey[500],
                              fontFamily: "Roboto",
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(right: 40.0, left: 40.0, top: 40),
            //   child: ConstrainedBox(
            //     constraints: const BoxConstraints(minWidth: double.infinity),
            //     child: ElevatedButton(
            //       style: ElevatedButton.styleFrom(
            //         primary: Color(COLOR_PRIMARY),
            //         textStyle: TextStyle(color: Colors.white),
            //         padding: EdgeInsets.only(top: 12, bottom: 12),
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(25.0),
            //           side: BorderSide(
            //             color: Color(COLOR_PRIMARY),
            //           ),
            //         ),
            //       ),
            //       child: Text(
            //         'Add User',
            //         style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            //       ),
            //       onPressed: () => push(
            //         context,
            //         new AddUser(),
            //       ),
            //     ),
            //   ),
            // ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  bottom: 20.0,
                ),
                child: ItemList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
