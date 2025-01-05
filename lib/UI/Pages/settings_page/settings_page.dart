import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:medicine_manager/UI/Theme/colors.dart';
import 'package:medicine_manager/UI/Pages/common/widgets/settings_tile.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //this is the app bar of the page where the title and the icon button to leave the settings page will be added
      appBar: AppBar(
        title: Text(
          "Settings",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        centerTitle: true,
      ),

      //this is the body of the scaffold where the content of the page will be added
      body: SafeArea(
        child: Column(
          children: [
            SettingsTile(
              icon: Ionicons.person_circle_outline,
              title: "Account",
              onTap: () {
                //TODO: create an account page
                Navigator.pushNamed(context, 'account_page');
              },
            ),
            // SettingsTile(
            //   icon: Ionicons.notifications_outline,
            //   title: "Notifications",
            //   onTap: () {
            //     Navigator.pushNamed(context, 'notifications');
            //   },
            // ),
            SettingsTile(
              icon: Ionicons.pencil_sharp,
              title: "Display",
              onTap: () {
                Navigator.pushNamed(context, 'display');
              },
            ),
            SettingsTile(
              icon: Ionicons.log_out_outline,
              title: "Log out",
              onTap: () async {
                await FirebaseAuth.instance.signOut();

                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, "login_page");
              },
            )
          ],
        ),
      ),
    );
  }
}
